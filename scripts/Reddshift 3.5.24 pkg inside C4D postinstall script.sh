#!/bin/bash

# $0 Returns the path to the script
# $1 Returns the path to the installer package
# $2 Returns the target location (for example: /Applications)
# $3 Returns the target volume (for example: /Volumes/Macintosh HD)


RSINSTALLDIR=/Applications/redshift

function install_c4d {
	local C4D_VER=$1	# C4D version eg. 19
	local C4D_DIR=$2
	local C4D_PLUGIN_DIR="$C4D_DIR"

	# Add Plugins at end of install dir if necessary
	local DIRNAME=`basename "$C4D_DIR"`
	shopt -s nocasematch
	if [[ "$DIRNAME" != "plugins" ]]; then
		C4D_PLUGIN_DIR="$C4D_DIR/plugins"
	fi
	shopt -u nocasematch

	# Plugins dir doesn't exist?
	if [ ! -d "$C4D_PLUGIN_DIR" ]; then
		# Create it
		mkdir "$C4D_PLUGIN_DIR"
	fi

	PLUGIN_SOURCE_DIR="$RSINSTALLDIR/redshift4c4d/R$C4D_VER/Redshift"
	PLUGIN_TARGET_DIR="$C4D_PLUGIN_DIR/Redshift"

	# Sanity check. Plugin must exist in the RS folder
	if [ ! -d "$PLUGIN_SOURCE_DIR" ]; then return; fi

	# Remove old plugin folder
	if [ -d "$PLUGIN_TARGET_DIR" ]; then
		#echo Removing $PLUGIN_TARGET_DIR
		rm -rf "$PLUGIN_TARGET_DIR"
	fi

	# Copy plugin folder
	cp -Rf "$PLUGIN_SOURCE_DIR" "$C4D_PLUGIN_DIR"
	
	PLUGIN_TARGET_LIB_DIR="$PLUGIN_TARGET_DIR/res/libs/osx"

	# Also copy dylib dependencies (core, OIIO, OVDB)
	cp -Rf "$RSINSTALLDIR/bin/"*.dylib "$PLUGIN_TARGET_LIB_DIR/"
}

install_c4d "2024" "$2"

