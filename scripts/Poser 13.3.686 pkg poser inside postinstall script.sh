#!/bin/bash
#set_trustfile.sh
#MacOSX Installer script for writing the Poser/Pro app location to the flashplayer trust file
echo "***** set trustfile and permsissions *****"

APP_LOC="/Applications"
PSR="Poser 13"
DBT="Poser Debut"

INSTALLER_TEMP_DATA="/tmp/com.bondware.poserInstallerData";
INSTALLER_TYPE_FILENAME="installerType";
TYPE_FILE="$INSTALLER_TEMP_DATA/$INSTALLER_TYPE_FILENAME";

if [ -e "$TYPE_FILE" ];
then 
	echo "reading APP_TYPE from $TYPE_FILE"
	read APP < "$TYPE_FILE";
	echo "APP=$APP"
	
	elif [ -d "$APP_LOC/$PSR/${PSR:0:5}.app" ];
then
		APP="$PSR";
	elif [ -d "$APP_LOC/$DBT/$DBT.app" ];
then
		APP="$DBT";
else
	echo "could not determine Poser version"
fi

USERS_SHARED="/Users/Shared/Library"
APP_SUPPORT="$USERS_SHARED/Application Support"
PSR_SUPPORT_DIR="Poser"
PRO_SUPPORT_DIR="Poser Pro"
TRUST_DIR="/Library/Application Support/Macromedia/FlashPlayerTrust"
PSR_TRUST="Poser11Trust.cfg"
DBT_TRUST="PoserDebutTrust.cfg"

#create liberal permissions for /Users/Shared/Library/Application Support
if [ -d "$USERS_SHARED" ]; then
		chmod 777 "$USERS_SHARED"
		if [ -d "$APP_SUPPORT" ]; then
			sudo chmod 777 "$APP_SUPPORT"
		fi
		if [ -d "$APP_SUPPORT/$PSR_SUPPORT_DIR" ]; then
			sudo chown -R  $USER:staff "$APP_SUPPORT/$PSR_SUPPORT_DIR"
			sudo chmod -R 777 "$APP_SUPPORT/$PSR_SUPPORT_DIR"
		fi
		if [ -d "$APP_SUPPORT/$PRO_SUPPORT_DIR" ]; then
			sudo chown -R  $USER:staff "$APP_SUPPORT/$PRO_SUPPORT_DIR"
			sudo chmod -R 777 "$APP_SUPPORT/$PRO_SUPPORT_DIR"
		fi
fi

#check for FlashPlayer trust directory. Set liberal permissions if present, create new if not.
if [ -d "$TRUST_DIR" ];
then
	chmod -v 775 "$TRUST_DIR"
else
	echo "Creating FlashPlayer Trust directory"
	mkdir -v -p -m 775 "$TRUST_DIR"
fi


#check for trust file for Poser. Create new if not present. Write app location into trust file.
if [ "$APP" = "$PSR" ];
then
	LIB_LOC="/$PSR/Runtime/ui/Flex/LSMGUI/bin-release"
	TRUST_FILE="$TRUST_DIR/$PSR_TRUST"
	
	if [ ! -e "$TRUST_FILE" ];
	then
		echo "Creating $PSR_TRUST file"
		touch "$TRUST_FILE"
		chmod -v 775 "$TRUST_FILE"
	fi

echo "Setting PoserTrust at $APP_LOC$LIB_LOC into $TRUST_FILE"
echo -e "\n$APP_LOC$LIB_LOC" >> "$TRUST_FILE"

mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Camera"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Character"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Face"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Hair"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Hand"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Light"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Materials"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Pose"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Props"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Libraries/Scene"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Geometries"
mkdir -p -v -m 775 "$APP_LOC/$PSR/Runtime/Textures"
echo "setting ownership and permissions"
sudo chown -R  $USER:staff "$APP_LOC/$PSR"
sudo chmod -R  775 "$APP_LOC/$PSR"
sudo chmod 644 "$APP_LOC/$PSR/Runtime/prefs/Default Poser Prefs"

fi

#check for trust file for Poser Debut. Create new if not present. Write app location into trust file.
if [ "$APP" = "$DBT" ];
then
	LIB_LOC="/$DBT/Runtime/ui/Flex/LSMGUI/bin-release"
	TRUST_FILE="$TRUST_DIR/$DBT_TRUST"
	
	if [ ! -e "$TRUST_FILE" ];
	then
		echo "Creating $DBT_TRUST file"
		touch "$TRUST_FILE"
		chmod -v 775 "$TRUST_FILE"
	fi

echo "Setting PoserTrust at $APP_LOC$LIB_LOC into $TRUST_FILE"
echo -e "\n$APP_LOC$LIB_LOC" >> "$TRUST_FILE"

	echo "setting ownership and permissions"
	sudo chown -R  $USER:staff "$APP_LOC/$DBT"
	sudo chmod -R  775 "$APP_LOC/$DBT"
	sudo chmod 644 "$APP_LOC/$DBT/Runtime/prefs/Default Poser Prefs"
fi

if [ -e "updaterDeleteFiles.sh" ];
then
	echo "deleting files"
	bash "updaterDeleteFiles.sh"
fi

exit 0
