#!/bin/bash
#$SUDO_USER = ??
#/usr/bin/sudo mkdir "/private/tmp"
/usr/bin/sudo rm -rf "/Library/Application Support/Adobe/Plug-Ins/CC/Retouch4me Heal.plugin"
/usr/bin/sudo rm -rf "/Library/Application Support/Adobe/Plug-Ins/CC/Retouch4me Heal Plugin.plugin"
/usr/bin/sudo rm -rf "/Library/Application Support/Adobe/Plug-Ins/CC/Retouch4me Heal Demo.plugin"
/usr/bin/sudo rm -rf "/Library/Application Support/Adobe/Plug-Ins/CC/Retouch4me Heal Free.plugin"
/usr/bin/sudo rm -rf "/Applications/Retouch4me Heal App.app"
/usr/bin/sudo rm -rf "/Applications/Retouch4me Heal Demo.app"
/usr/bin/sudo rm -rf "/Applications/Retouch4me Heal Free.app"
sudo sh -c 'rm "$HOME/Library/Application Support/Adobe/Lightroom/External Editor Presets/Retouch4me Heal Demo.lrtemplate"'
/usr/bin/sudo mkdir "/Applications/Retouch4me Heal.app"
/usr/bin/sudo mkdir -p "/Library/Application Support/Adobe/Plug-Ins/CC/"
/usr/bin/sudo cp -Rv "/private/tmp/ZSR/Retouch4me Heal.plugin" "/Library/Application Support/Adobe/Plug-Ins/CC"
/usr/bin/sudo cp -Rv "/private/tmp/ZSR/Retouch4me Heal.lrtemplate" ~/Library/Application\ Support/Adobe/Lightroom/External\ Editor\ Presets/
/usr/bin/sudo rm -rf "/private/tmp/ZSR/"

fix_dir_permissions() {
    /usr/bin/sudo chmod 777 "$1"
}

baseDirName="/Library/Application Support/Retouch4me"
/usr/bin/sudo mkdir "$baseDirName"
fix_dir_permissions "$baseDirName"
exit 0
