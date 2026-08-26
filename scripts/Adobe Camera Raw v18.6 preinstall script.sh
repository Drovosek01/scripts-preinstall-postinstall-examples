#!/bin/bash

# The following method makes another folder and moves everything in
# the File Formats folder over to it.
# mkdir -p "/Library/Application Support/Adobe/Plug-Ins/CC/OtherCameraRawPlugins"
# mv /Library/Application\ Support/Adobe/Plug-Ins/CC/File\ Formats/* /Library/Application\ Support/Adobe/Plug-Ins/CC/OtherCameraRawPlugins

# This method is more brutal. It just zaps everything in File Formats
# and therefore ensures the resulting installed plug-in will be the
# only thing in this folder.
mkdir -p /Library/Application\ Support/Adobe/Plug-Ins/CC/File\ Formats
rm -rf /Library/Application\ Support/Adobe/Plug-Ins/CC/File\ Formats/*

# Also zap the Settings/Adobe subfolder. This is the folder in which Adobe
# installs the "factory set" of presets, starting with ACR 10.0. Since the
# installer never removes/deletes entries, zapping this entire folder during the
# 'preinstall' stage guarantees that the installer will always be installing a
# completely new set of presets. This is particularly useful for prerelease
# builds, when we may still be experimenting with some presets that may not make
# the final cut.
rm -rf /Library/Application\ Support/Adobe/CameraRaw/Settings/Adobe

exit 0
