#!/bin/bash
#content_loc.sh
#MacOSX Installer script for setting the CONTENT_ROOT_PATH in the Poser Prefs file
echo "***** set_content_root.sh *****"

APP_LOC="/Applications"
PSR="Poser 13"
DBT="Poser Debut"

INSTALLER_TEMP_DATA="/tmp/com.bondware.poserInstallerData";
INSTALLER_TYPE_FILENAME="installerType";
TYPE_FILE="$INSTALLER_TEMP_DATA/$INSTALLER_TYPE_FILENAME";
INSTALLER_LOCATION_FILENAME="installerLocation";
LOCATION_FILE="$INSTALLER_TEMP_DATA/$INSTALLER_LOCATION_FILENAME";

if [ -e "$TYPE_FILE" ];
then 
	echo "reading APP_TYPE from $TYPE_FILE"
	read APP < "$TYPE_FILE";
	echo "APP is $APP"
else
	echo "could not read from TYPE_FILE"
	exit 1
fi

USER_CONTENT_LOC="$2"
TMP_DEFAULT_LOC="/Users/Shared"
PREFS_LOC="/$APP/Runtime/prefs"
PREFS_FILE="/Default Poser Prefs"
PREFS_PATH="$APP_LOC$PREFS_LOC$PREFS_FILE"

#if [ "$APP" = "$PRO" ] || [ "$APP" = "$JPR" ] || [ "$APP" = "$DPR" ];
#then
#	CONTENT_LOC="$USER_CONTENT_LOC/$PRO Content"
if [ "$APP" = "$PSR" ]
then
	CONTENT_LOC="$USER_CONTENT_LOC/$PSR Content"
elif [ "$APP" = "$DBT" ];
then 
	CONTENT_LOC="$USER_CONTENT_LOC/$DBT Content"
fi

echo "setting Content directory name to $CONTENT_LOC"

if  [ -d "$CONTENT_LOC" ]
then
	echo "$CONTENT_LOC directory exists. excuting ditto copy"
	ditto -v -V "$USER_CONTENT_LOC/Poser Content/" "$CONTENT_LOC"
	echo "ditto copy complete. removing source directory"
	rm -v -R "$USER_CONTENT_LOC/Poser Content"
	echo "source directory removed"
else
	echo "creating $CONTENT_LOC directory"
	mkdir -v -p -m 777 "$CONTENT_LOC"
	echo "moving content from $USER_CONTENT_LOC to $CONTENT_LOC"
	mv -v -f "$USER_CONTENT_LOC/Poser Content/Runtime" "$CONTENT_LOC"
	mv -v -f "$USER_CONTENT_LOC/Poser Content/Documentation" "$CONTENT_LOC"
	rm -v -R "$USER_CONTENT_LOC/Poser Content"	
	echo "move complete"
fi

if [ -d "$TMP_DEFAULT_LOC/Poser Content/Runtime" ]
then
	echo "copying extended content from $TMP_DEFAULT_LOC/Poser Content to $CONTENT_LOC"
	ditto -v -V "$TMP_DEFAULT_LOC/Poser Content" "$CONTENT_LOC"
	echo "ditto copy complete. removing source directory"
	rm -v -R "$TMP_DEFAULT_LOC/Poser Content"
	echo "source directory removed"
fi


if [ ! -e "$PREFS_PATH" ];
then
	echo "Creating Prefs file"
	touch "$PREFS_PATH"
	chmod -v 644 "$PREFS_PATH"
fi

echo "Setting Content Root Path at $CONTENT_LOC into $PREFS_PATH"
echo "CONTENT_ROOT_PATH \"$CONTENT_LOC\"" > "$PREFS_PATH"

mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/camera"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/character"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/face"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/hair"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/hand"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/light"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/materials"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/pose"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/props"
mkdir -p -v -m 777 "$CONTENT_LOC/Downloads/Runtime/libraries/scene"

sudo chown -R $USER:staff "$CONTENT_LOC"
sudo chmod -R 777 "$CONTENT_LOC"
exit 0
