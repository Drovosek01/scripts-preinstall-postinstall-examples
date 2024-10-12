#!/bin/bash
 #
 #  Postinstall script for MacOS X installer
 #
 #  Environment variables:
 #
 #    $SCRIPT_NAME .... The name of this script
 #    PACKAGE_PATH .... The pathname for the installer package (same as $1)
 #    INSTALLER_TEMP .. Temp directory for installation
 #    $RECEIPT_PATH ... 
 #
 PKGPATH="$1"
 DEST_DIR="$2"
 VOLUME="$3"
 ROOT_DIR="$4"
 
 SUITE="2018-4"
 APP_DIR="/Applications/SchrodingerSuites$SUITE"
 LIB_DIR="/Library/Application Support/Schrodinger"
 
 log () {
   if [ -n "$SCHRODINGER_INSTALLER_DEBUG" ]; then
     echo $* >> ~/installation.log
   fi
 }
 
 log $0 "$@"
 log "SCRIPT_NAME:    '$SCRIPT_NAME'"
 log "PACKAGE_PATH:   '$PACKAGE_PATH'"
 log "DEST_DIR:       '$DEST_DIR'"
 log "USER:           '$USER'"
 
 PACKAGE_DIR=`dirname "$PKGPATH"`
 
 export SCHRODINGER="$DEST_DIR"
 
 CWD=`pwd`
 cd "$DEST_DIR"
 
 localize () {
     _script="$1"
     mv "$_script" "$_script.orig"
     sed "s!^export SCHRODINGER=.*!export SCHRODINGER='$DEST_DIR'!" "$_script.orig" > "$_script"
     chmod a+rx "$_script"
     rm "$_script.orig"
 
     if ! cmp "$_script" "$_script.local" > /dev/null ; then
         log "Localize '$x'"
         cp "$_script" "$_script.local"
     fi
     unset _script
 }
 
 ## Install .app bundles into the /Applications directory
 ##
 APPS=`ls -d *.app`
 
 if [ -n "$APPS" ]; then
     sudo mkdir $APP_DIR
     ls -1 -d *.app | while read app; do
 
         ls -1 "$app"/Contents/MacOS/* | while read x ; do
             case "$x" in
             *.orig|*.local|*~) ;; # skip
                     *) localize "$x" ;;
             esac
         done
 
         if [[ -d "$APP_DIR/$app" ]]; then
             log "Removing old $APP_DIR/$app"
             rm -rf "$APP_DIR/$app"
         fi
         log "Install $app in $APP_DIR"
         mv "$app" "$APP_DIR/$app"
     done
 else
     log "No apps found in $DEST_DIR"
 fi 
 
 ## Copy the uninstall script to the /Applications directory
 ##
 cd "$PACKAGE_DIR"
 UNINSTALL=`ls -d Uninstall*.{command,app}`
 if [ -n "$UNINSTALL" ]; then
     sudo mkdir $APP_DIR
     ls -1 -d Uninstall*.{command,app} | while read app; do
         log "Install $app in $APP_DIR"
         cp -pr "$app" "$APP_DIR/$app"
         chmod a+x "$APP_DIR/$app"
     done
 fi
 
 ## Initialize the schrodinger.hosts file, if necessary
 ##
 log "Debating creation of schrodinger.hosts"
 if [ ! -f "$DEST_DIR/schrodinger.hosts" ]; then
     log "Create initial schrodinger.hosts file"
     cp $DEST_DIR/mmshare-v*/temp/schrodinger.hosts.hdr $DEST_DIR/schrodinger.hosts
     nproc=`/usr/sbin/sysctl -n hw.physicalcpu 2> /dev/null`
     echo "" >> $DEST_DIR/schrodinger.hosts
     echo "name:        localhost" >> $DEST_DIR/schrodinger.hosts
     echo "schrodinger: $DEST_DIR" >> $DEST_DIR/schrodinger.hosts
     echo "processors:  $nproc" >> $DEST_DIR/schrodinger.hosts
     echo "" >> $DEST_DIR/schrodinger.hosts
 
 else
     log "Did not to create $DEST_DIR/schrodinger.hosts file since already present"
 fi
 
 ## Install license, if provided.
 ##
 log "Creating $LIB_DIR"
 sudo mkdir -p "$LIB_DIR"
 
 ACADEMIC_LICENSE="$PACKAGE_DIR/academic_license.lic"
 
 if [ -f "$ACADEMIC_LICENSE" ]; then
     log "Installing Academic license"
     #Set APPDATA to TMPDIR to ensure that a ~/.schrodinger directory is not created as the user running this script. INST-1983
     env SCHRODINGER_APPDATA_OVERRIDE="$TMPDIR" "$SCHRODINGER/licadmin" INSTALL -c "$ACADEMIC_LICENSE"
 fi
 
 ## Adjust file and directory ownership
 ##
 if [ "$USER" != root ]; then
   log "Adjusting file permissions"
   sudo chown -R "$USER:admin" "$APP_DIR"
   sudo chown -R "$USER:admin" "$LIB_DIR"
   sudo chown "$USER:admin" "$DEST_DIR"
   sudo chown "$USER:admin" "$DEST_DIR/.."
   sudo find "$DEST_DIR" -maxdepth 1 \! -user "$USER" -exec chown -R "$USER:admin" {} \;
 fi
 
 # Force update of file registrations
 /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -f $APP_DIR
 
 log "--------"
 