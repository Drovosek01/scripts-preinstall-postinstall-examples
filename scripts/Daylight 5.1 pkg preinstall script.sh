#!/bin/bash
#
# pre-install script for Daylight on OS X

PRODUCT=Daylight
APP_DIR=/Applications/$PRODUCT/Current

# Remove legacy LaunchDaemons
for ld in $(find /Library/LaunchDaemons -name "uk.ltd.filmlight.*" | grep -v postgres); do
    launchctl stop $ld
    launchctl unload $ld
    rm $ld
done

[ -x $APP_DIR/Utilities/Resources/bin/fl-service ] && $APP_DIR/Utilities/Resources/bin/fl-service stop

true
