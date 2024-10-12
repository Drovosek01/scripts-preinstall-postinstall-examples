#!/bin/bash
#
# arguments:
#
# $1: The full path to the installation package.
# $2: The full path to the installation destination.
# $3: The mountpoint of the destination volume.
# $4: The root directory for the current System folder. 
#

INSTALL_DIR=/Library/PostgreSQL/9.3.4
DSCL=/usr/bin/dscl

# Delete old postgres user
if ! $DSCL . -list /Users/postgres >/dev/null 2>&1 ; then
    echo Deleting old postgresql user
    $DSCL -q . -delete /Users/postgres
fi

# Create postgres user
X=401
until test $PG_UID; do
    TEST_UID=`/usr/bin/dscl . -search /Users UniqueID $X | grep $X`

    if ! test $TEST_UID; then
        PG_UID=$X
    fi
    X=$((X+1))
done

echo "Creating postgres user (uid $PG_UID)"

/usr/bin/dscl . -create /Users/postgres
/usr/bin/dscl . -create /Users/postgres UniqueID $PG_UID
/usr/bin/dscl . -create /Users/postgres PrimaryGroupID 20
/usr/bin/dscl . -create /Users/postgres UserShell /bin/bash
/usr/bin/dscl . -create /Users/postgres RealName "PostgreSQL Server"
/usr/bin/dscl . -create /Users/postgres NFSHomeDirectory /Library/PostgreSQL

# Prevent the postgres user from showing up in the login window
if ! /usr/bin/defaults read /Library/Preferences/com.apple.loginwindow HiddenUsersList | grep -q postgres; then

    /usr/bin/defaults \
        write \
        /Library/Preferences/com.apple.loginwindow\
        HiddenUsersList \
        -array-add \
        postgres
fi

# Add shared memory config to sysctl.conf
SHM_MAX=$(/usr/sbin/sysctl -n kern.sysv.shmmax)
SHM_ALL=$(/usr/sbin/sysctl -n kern.sysv.shmall)
if [ $SHM_MAX -lt 268435456 -o $SHM_ALL -lt 268435456 ]; then

    echo "Updating shmmax and shmall in /etc/sysctl.conf"

    # Apply parameters new
    sysctl -w kern.sysv.shmmax=268435456
    sysctl -w kern.sysv.shmall=268435456

    if [ -e /etc/sysctl.conf ]; then
	echo "Removing old shm parameters"
        # Remove old shm parameters
	sed -i "" "/kern.sysv.shmmax/d" /etc/sysctl.conf
	sed -i "" "/kern.sysv.shmall/d" /etc/sysctl.conf
    fi

    # Add new shmmem parameters
    echo 'kern.sysv.shmmax=268435456' >> /etc/sysctl.conf
    echo 'kern.sysv.shmall=268435456' >> /etc/sysctl.conf

fi

# Change ownership of directory to postgres user
chown -R postgres $INSTALL_DIR

# Run initdb as postgres user
# --auth=trust              Trust local UNIX domain & TCP socket connections
# -D $INSTALL_DIR/data      Where to store data for this database
#
sudo -u postgres $INSTALL_DIR/bin/initdb --auth=trust -D $INSTALL_DIR/data

# Remove old LaunchDaemon configuration
if launchctl list uk.ltd.filmlight.postgresql >/dev/null 2>&1; then
    echo Removing old postgresql LaunchDaemon configuration
    launchctl stop uk.ltd.filmlight.postgresql || true
    launchctl remove uk.ltd.filmlight.postgresql
fi

# Install LaunchDaemon configuration
cp $INSTALL_DIR/share/uk.ltd.filmlight.postgresql.plist /Library/LaunchDaemons
chown root:wheel /Library/LaunchDaemons/uk.ltd.filmlight.postgresql.plist
launchctl load /Library/LaunchDaemons/uk.ltd.filmlight.postgresql.plist
launchctl start uk.ltd.filmlight.postgresql

