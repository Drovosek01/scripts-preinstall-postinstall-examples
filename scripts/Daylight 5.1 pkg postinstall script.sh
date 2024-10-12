#!/bin/bash
#
# post-install script for Daylight on OS X
#
# create support directories, copy licence files, that sort of thing
#
# arguments:
#
# $1: The full path to the installation package.
# $2: The full path to the installation destination.
# $3: The mountpoint of the destination volume.
# $4: The root directory for the current System folder. 
#
#
# NOTE: this script is run by the installer as euid root.
# This is useful for creating links etc, but be cautious when
# running scripts that may make files, as they will end up with
# the wrong owner.

PRODUCT=Daylight

PREV_VERS=""

APP_DIR=/Applications/$PRODUCT/Current

if [ -h $APP_DIR ]; then
    LINK=$(readlink $APP_DIR)
    PREV_VERS=$(basename $LINK)
    rm $APP_DIR
fi

# set up Current link: latest is a link to the new install
mv /Applications/$PRODUCT/latest $APP_DIR

LINK=$(readlink $APP_DIR)
VERS=$(basename $LINK)

# Baselight Application Support directory for host/site prefs and formats
# owned by root/admin, but writable by anyone
SUPPORT_DIR="/Library/Application Support/FilmLight"

mkdir -p "$SUPPORT_DIR/$PRODUCT"
chown root:staff "$SUPPORT_DIR"
chmod -R 777 "$SUPPORT_DIR"

# log directories
LOG_DIRS="log \
    log/support \
    log/support/sent \
    log/support/unsent \
    log/support/local \
    log/support/ignored"

# plugin may have created a symlink to log
[ -L "$SUPPORT_DIR/Log" ] && rm -f "$SUPPORT_DIR/Log"

for D in etc etc/colourspaces slates Gallery $PRODUCT/$VERS/cache $PRODUCT/$VERS/setups $LOG_DIRS; do
    mkdir -p "$SUPPORT_DIR/$D"
done

# migrate existing settings if any (but just wipe the old log files)
# check to see if el-capitan has migrated them out of the way
for fl in /usr/fl $(find /Library/SystemMigration/History -name fl); do
    if [ ! -L "$fl" ] && [ -e "$fl/etc/licence.flic" ] ; then
	rm -rf "$fl/log"
	(cd "$fl"; tar cf - .) | (cd "$SUPPORT_DIR"; tar --keep-newer-files -xf - )
	rm -rf "$fl"
    fi
done

# copy bundled setups to a version-specific (writable) directory
cp -rpv $APP_DIR/Utilities/Resources/etc/setups/* "$SUPPORT_DIR/$PRODUCT/$VERS/setups"

# if no previous setups directory use previous non-versioned directory (if any)
[ ! -d "$SUPPORT_DIR/$PRODUCT/$PREV_VERS/setups" ] && PREV_VERS=""

# if we're first-time migrating from daylight-13 world, where setups
# were stored in /Library/Application Support/FilmLight/Baselight/
# then copy them from the Baselight folder (to Daylight)
if [ -z "$PREV_VERS" ]; then
    PRODUCT_SETUPS="Baselight"
else
    PRODUCT_SETUPS="$PRODUCT/$PREV_VERS/setups"
fi

# copy user setups from previous install
if [ -d "$SUPPORT_DIR/$PRODUCT_SETUPS" ]; then
    pushd "$SUPPORT_DIR/$PRODUCT_SETUPS"
    cp -rpv *.setup "$SUPPORT_DIR/$PRODUCT/$VERS/setups"
    popd
fi

# these commands will silently fail on el-capitan
rm -rf /usr/fl
ln -s "$SUPPORT_DIR" /usr/fl

for D in $LOG_DIRS; do
    # clean up all log files to just one week of activity. This might
    # initially take some time at larger sites, since it has never
    # been done before, so spin it off as a background task.
    find "$SUPPORT_DIR/$D" -maxdepth 1 -name '*-*' -type d  -mtime +7 -exec rm -rf {} \; >/dev/null 2>&1 &
done

# Install slate image
cp -fp $APP_DIR/Utilities/Resources/textures/FL_logo.png "$SUPPORT_DIR/slates"

# make sure we now have a default licence.flic which we can add things to
touch "$SUPPORT_DIR/etc/licence.flic"

if [ ! -d /Library/Truelight ]; then
    mkdir -p -m 777 /Library/Truelight/cameras
    mkdir -p -m 777 /Library/Truelight/cdlooks
    mkdir -p -m 777 /Library/Truelight/cubes
    mkdir -p -m 777 /Library/Truelight/displays/spaces
    mkdir -p -m 777 /Library/Truelight/etc
    mkdir -p -m 777 /Library/Truelight/lamps
    mkdir -p -m 777 /Library/Truelight/prints
    mkdir -p -m 777 /Library/Truelight/profiles/looks
    mkdir -p -m 777 /Library/Truelight/recorders
    mkdir -p -m 777 /Library/Truelight/transforms
fi

# these need to be writable as well
chmod 777 /Library/Truelight/displays
chmod 777 /Library/Truelight/profiles

cp $APP_DIR/Utilities/Resources/displays/spaces/* /Library/Truelight/displays/spaces
cp $APP_DIR/Utilities/Resources/profiles/looks/* /Library/Truelight/profiles/looks

if [ ! -d /private/vol ] ; then
    echo "Making /private/vol directory"
    mkdir /private/vol
    chmod 000 /private/vol
fi

# general ownership and permissions tidying up
SU_TOOLS="suflici fl-sudo"
for T in $SU_TOOLS; do
    echo Setting suid bit on $APP_DIR/Utilities/Tools/$T
    chown root $APP_DIR/Utilities/Tools/$T
    chmod +s $APP_DIR/Utilities/Tools/$T
done

# Create filmlight user
if ! /usr/bin/id filmlight >/dev/null 2>&1 ; then
    echo Creating filmlight user
    
    # loop through the '400's' until we find an available uid
    X=401
    until test $FL_UID; do
	TEST_UID=`/usr/bin/dscl . -search /Users UniqueID $X | grep $X `
	
	if ! test $TEST_UID; then
	    FL_UID=$X
	fi
	X=$((X+1))
    done
   
    /usr/bin/dscl . -create /Users/filmlight
    /usr/bin/dscl . -create /Users/filmlight UniqueID $FL_UID
    /usr/bin/dscl . -append /Users/filmlight PrimaryGroupID 20
    /usr/bin/dscl . -append /Users/filmlight UserShell /usr/bin/false
    /usr/bin/dscl . -append /Users/filmlight RealName "FilmLight Service Account"
    /usr/bin/dscl . -append /Users/filmlight NFSHomeDirectory "$SUPPORT_DIR/home"
    
    echo ...User filmlight created with UID $FL_UID
else
    if /usr/bin/dscl . -read /Users/filmlight NFSHomeDirectory | grep -q /usr/fl/home ; then
	# Change existing filmlight user home dir from /usr/fl to new location
	rm -rf "$SUPPORT_DIR/home"
	if [ -f /usr/fl/home ] ; then
	    cp -Rfp /usr/fl/home "$SUPPORT_DIR"
	    rm -rf /usr/fl/home
	else
	    mkdir -p "$SUPPORT_DIR/home"
	fi
	/usr/bin/dscl . -change /Users/filmlight NFSHomeDirectory /usr/fl/home "$SUPPORT_DIR/home"
    fi
fi

chown -R filmlight:staff "$SUPPORT_DIR"
chmod -R 777 "$SUPPORT_DIR"

# Ensure home folder exists (might have been destroyed by previous errant installers)
mkdir -p ~filmlight
chown filmlight:20 ~filmlight
chmod 777 ~filmlight
mkdir -m 777 /Library/Caches/FilmLight

# Remove legacy LaunchDaemons
for ld in $(find /Library/LaunchDaemons -name "uk.ltd.filmlight.*" | grep -v postgres); do
    echo Removing old $ld
    launchctl stop $ld
    launchctl unload $ld
    rm $ld
done

# Install archivedb service
cp $APP_DIR/Utilities/Resources/etc/uk.ltd.filmlight.archivedb.plist /Library/LaunchDaemons
chmod 644 /Library/LaunchDaemons/uk.ltd.filmlight.archivedb.plist
launchctl load /Library/LaunchDaemons/uk.ltd.filmlight.archivedb.plist
launchctl start uk.ltd.filmlight.archivedb

# correct ownership and setuid settings of swapmacservice 
chown root:admin $APP_DIR/Utilities/Tools/swapmacservices
chmod +s $APP_DIR/Utilities/Tools/swapmacservices

# Update the command line paths to expose tools
# remove all existing (base|day|film)light paths - done inside swapmacservices
# install and start boot time services
echo "Updating path"
mkdir -p /etc/paths.d
$APP_DIR/Utilities/Tools/swapmacservices

# Remove tools from /usr/bin & /usr/sbin that may have been copied there from earlier BL
# installs.
for i in /usr/bin/fl-* /usr/bin/bl-* /usr/sbin/bl-* /usr/sbin/fl-*; do
    if [ -h "$i" ]; then
	target=`readlink $i`
	target_dir=`dirname $target`
	if [ "$target_dir" = "$APP_DIR/Utilities/Tools" ]; then
	    rm -f $i
	fi
    fi
done

# Reset the thumbnail cache directory
$APP_DIR/Utilities/Resources/bin/bl-reset-cache -createthumb

# Setup crash reporting - now included in the installer itself

# Patch PostgreSQL 8.4 pg_hba.conf
$APP_DIR/Utilities/Resources/share/fix-postgresql-8.4.sh

exit 0
