#!/bin/bash

rm -R /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/
rmdir /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/

mkdir /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/
unzip -o /Users/Shared/Autokroma\ AfterCodecs.zip -d /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs


rm -R /Library/Application\ Support/Adobe/CEP/extensions/com.autokroma.afcpanel/
rmdir /Library/Application\ Support/Adobe/CEP/extensions/com.autokroma.afcpanel/

mv /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/com.autokroma.afcpanel/ /Library/Application\ Support/Adobe/CEP/extensions/com.autokroma.afcpanel/

rm /Users/Shared/Autokroma\ AfterCodecs.zip

#https://www.lifewire.com/aliases-symbolic-links-hard-links-mac-2260189
##https://apple.stackexchange.com/questions/51709/can-i-create-a-desktop-shortcut-alias-to-a-folder-from-the-terminal

cd /Applications/

mkdir Autokroma
cd Autokroma


# Set or erase icon for this folder
tar -xvf /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/AutokromaFolderIcon.tar -C /Applications/Autokroma/
SetFile -a C /Applications/Autokroma/
rm -f /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/AutokromaFolderIcon.tar

mkdir Uninstallers
rm -f /Applications/Autokroma/Uninstallers/UNINSTALL\ AfterCodecs.pkg
mv /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/UNINSTALL\ AfterCodecs.pkg /Applications/Autokroma/Uninstallers/UNINSTALL\ AfterCodecs.pkg
# to be sure
rm /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/UNINSTALL\ AfterCodecs.pkg


# remove old symlink to be sure the new one is at the right destination in case we ever update the path
unlink /Applications/AfterCodecs
rm -f /Applications/AfterCodecs

unlink /Applications/Autokroma/AfterCodecs
rm -f /Applications/Autokroma/AfterCodecs

ln -s /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/AfterCodecs.app "AfterCodecs"

#protection to preserve integrity of .app, see Gitlab akCommon#146 and 747
#Don't know why we have to add .app
#Beware to not put a / at the end ! It might delete the linked .app so our Desktop app !
unlink /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/AfterCodecs.app/AfterCodecs.app
rm -f /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/AfterCodecs.app/AfterCodecs.app


open /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/
open /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/Autokroma\ AfterCodecs/AfterCodecs.app

exit 0