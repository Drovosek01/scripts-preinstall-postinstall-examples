#!/bin/bash -x
#
# This preflight script echoes the values of the available 
# arguments and environmental variables.

# $1: full path to the installation package
# $2: full path to the installation destination
# $3: mountpoint of the destination volume
# $4: root directory \"/\" for the current System folder"
# Environment variables available to a preflight executable:
# 	$INSTALLER_TEMP: scratch area used by Installer for temporary work files
# 	$PACKAGE_PATH: full path to the installation package; should be same as $1
# 	$RECEIPT_PATH: full path to directory containing the file being executed
# 	$SCRIPT_NAME: name of the file being executed"
# 	$TMPDIR: if set, a path to a location on a writable destination volume
# 

# Backup Analog Lab V User data
if [ -d "$2""Library/Arturia/Analog Lab V/" ]; then
	if [ ! -d "$2""Library/Arturia/Analog Lab V Backup/" ]; then
		mkdir -p "$2""Library/Arturia/Analog Lab V Backup/"

		if [ -d "$2""Library/Arturia/Presets/Analog Lab V/User" ]; then
			echo "Backup Analog Lab V User Presets"
			mkdir -p "$2""Library/Arturia/Analog Lab V Backup/Presets/User"
			cp -r "$2""Library/Arturia/Presets/Analog Lab V/User" "$2""Library/Arturia/Analog Lab V Backup/Presets"
		fi
		if [ -d "$2""Library/Arturia/Analog Lab V/User" ]; then
			echo "Backup Analog Lab V User Playlists"
			mkdir -p "$2""Library/Arturia/Analog Lab V Backup/Playlists"
			cp -r "$2""Library/Arturia/Analog Lab V/User" "$2""Library/Arturia/Analog Lab V Backup/Playlists"
		fi
		if [ -d "$2""Library/Arturia/Analog Lab V/tmp" ]; then
			echo "Backup Analog Lab V User tmp"
			mkdir -p "$2""Library/Arturia/Analog Lab V Backup/tmp"
			cp -r "$2""Library/Arturia/Analog Lab V/tmp" "$2""Library/Arturia/Analog Lab V Backup"
		fi
	fi
fi

# Backup playlists
cp -R  "$2""Library/Arturia/Presets/Analog Lab V/Playlists/" "$2""Library/Arturia/Backup/Presets/Analog Lab V/Playlists/"

# Backup tags
cp -R "$2""Library/Arturia/Presets/Shared/" "$2""Library/Arturia/Backup/Presets/Shared/"

# 172440 : The presets installed from the store were in Analog Lab V 5 folder
if [ -d "$2""Library/Arturia/Presets/Analog Lab V 5" ]; then
    cp -r  "$2""Library/Arturia/Presets/Analog Lab V 5/" "$2""Library/Arturia/Presets/Analog Lab V/" 
    rm -rf "$2""Library/Arturia/Presets/Analog Lab V 5"
fi
	
# Dont remove Factory as it contains the in-app packs
# delete Real Factory folders by hand
rm -rf "$2""Library/Arturia/Presets/Analog Lab V/Factory/Factory"
rm -rf "$2""Library/Arturia/Presets/Analog Lab V/Factory/Templates"
rm -rf "$2""Library/Arturia/Presets/Analog Lab V/Factory/Originals"
rm -rf "$2""Library/Arturia/Presets/Analog Lab V/Tutorials"

# Removing the old state as we want to show the arturia picks when installing a new version
rm "$2""Library/Arturia/Analog Lab V/tmp/lastpresetc.pref"
rm "$2""Library/Arturia/Analog Lab V/tmp/lastpresetp.pref"

#remove .vst and .vst3
rm -rf "$2""Library/Arturia/Analog Lab V/Analog Lab V.vst3"
rm -rf "$2""Library/Arturia/Analog Lab V/Analog Lab V.vst"

#Clear the tutorial folder
rm -rf "$2""Library/Arturia/Analog Lab V/resources/gui_xml/tutorials"

# Remove deprecated pkgutil entry
pkgutil --forget "com.arturia.pkg.Analog Lab V_Resources"

exit 0
