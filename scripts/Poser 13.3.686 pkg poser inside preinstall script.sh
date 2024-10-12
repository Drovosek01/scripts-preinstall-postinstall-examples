#!/bin/sh
echo "***** psrSetup.sh *****"

APP_TYPE="Poser 13";
INSTALLER_TEMP_DATA="/tmp/com.bondware.poserInstallerData";
INSTALLER_TYPE_FILENAME="installerType";
TYPE_FILE="$INSTALLER_TEMP_DATA/$INSTALLER_TYPE_FILENAME";

mkdir -v -p -m 777 "$INSTALLER_TEMP_DATA";

if [ -e "$TYPE_FILE" ];
	then echo "Removing existing TYPE_FILE at $TYPE_FILE"
	rm -v -R "$TYPE_FILE"
fi
echo "Creating TYPE_FILE at $TYPE_FILE";
touch -f "$TYPE_FILE";
chown -v :staff "$TYPE_FILE";
chmod -v 777 "$TYPE_FILE";

echo "Setting APP_TYPE to $APP_TYPE";
echo "$APP_TYPE" >> "$TYPE_FILE";
#echo -e "$APP_TYPE" >> "$TYPE_FILE";

if [ -e ~/Library/Application\ Support/Poser/13/ ];
then
    #TDC changed to backup prefs on upgrade but retain current values
	#mv ~/Library/Application\ Support/Poser\ Pro/13/ ~/Library/Application\ Support/Poser\ Pro/13_"`date +%Y%m%d%H%M`"/
	cp -Rf ~/Library/Application\ Support/Poser/13 ~/Library/Application\ Support/Poser/13_"`date +%Y%m%d%H%M`"
	echo "preferences backed up and retained"
else
	echo "no preferences found"
fi

echo "*** Deleting unneeded files and folders ***"
echo $(date)

LANG=en_US.UTF-8;export LANG


APP="Poser 13"
RUNTIME_ROOT="/Applications/$APP/Runtime"

declare -a filesForDeletion=(
#*** FILE LIST ***
"ui/altui/German/Dlg_ClothRoomCollObject.xml"
"ui/altui/Japanese/Dlg_ClothRoomCollObject.xml"

);

declare -a foldersForDeletion=();

echo "Deleting files"
for FILE in "${filesForDeletion[@]}";
do
	#echo "Deleting $FILE"
	sudo rm -f -v "$RUNTIME_ROOT/$FILE"
done

echo "Deleting folders"
for FOLDER in "${foldersForDeletion[@]}";
do
	echo "Deleting $FOLDER"
	sudo rmdir -p "$RUNTIME_ROOT/$FOLDER"
done;

