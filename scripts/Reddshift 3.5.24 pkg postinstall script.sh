#!/bin/bash

# $0 Returns the path to the script
# $1 Returns the path to the installer package
# $2 Returns the target location (for example: /Applications)
# $3 Returns the target volume (for example: /Volumes/Macintosh HD)

RSINSTALLDIR=/Applications/redshift

# Install Maya
# Install Maya
# Install Maya

if [ -d "/Applications/Autodesk/maya2018/Maya.app/Contents/modules/" ]; then
	cp /Applications/redshift/redshift4maya/redshift4maya.mod.template /Applications/Autodesk/maya2018/Maya.app/Contents/modules/redshift4maya.mod
fi

if [ -d "/Applications/Autodesk/maya2019/Maya.app/Contents/modules/" ]; then
	cp /Applications/redshift/redshift4maya/redshift4maya.mod.template /Applications/Autodesk/maya2019/Maya.app/Contents/modules/redshift4maya.mod
fi

if [ -d "/Applications/Autodesk/maya2020/Maya.app/Contents/modules/" ]; then
	cp /Applications/redshift/redshift4maya/redshift4maya.mod.template /Applications/Autodesk/maya2020/Maya.app/Contents/modules/redshift4maya.mod
fi

if [ -d "/Applications/Autodesk/maya2022/Maya.app/Contents/modules/" ]; then
	cp /Applications/redshift/redshift4maya/redshift4maya.mod.template /Applications/Autodesk/maya2022/Maya.app/Contents/modules/redshift4maya.mod
fi

if [ -d "/Applications/Autodesk/maya2023/Maya.app/Contents/modules/" ]; then
	cp /Applications/redshift/redshift4maya/redshift4maya.mod.template /Applications/Autodesk/maya2023/Maya.app/Contents/modules/redshift4maya.mod
fi


# Install Houdini
# Install Houdini
# Install Houdini

function install_houdini {
	HOUDINI_VER=$1
	HOUDINI_TARGET="$RSINSTALLDIR/redshift4houdini/$HOUDINI_VER"

	# Sanity check. Plugin must exist in the RS folder
	if [ ! -d $HOUDINI_TARGET ]; then return; fi

	# Ensure the bin folder exists before copying. If it does, mkdir won't fail
	mkdir -p $HOUDINI_TARGET/bin
	cp -R "$RSINSTALLDIR"/bin/*.dylib $HOUDINI_TARGET/bin
}

install_houdini 18.0.597
install_houdini 18.5.759
install_houdini 19.0.720
install_houdini 19.5.805
install_houdini 19.5.805_arm64
install_houdini 20.0.506
install_houdini 20.0.506_arm64
install_houdini 20.0.547
install_houdini 20.0.547_arm64
install_houdini 20.0.590
install_houdini 20.0.590_arm64

# Ensure /Library/Application Support/Reprise exists and has wide open permissions
# This is required starting with RLM v14.1
mkdir "/Library/Application Support/Reprise"
chmod 777 "/Library/Application Support/Reprise"
