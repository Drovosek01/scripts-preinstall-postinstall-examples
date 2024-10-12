#!/bin/bash

# Move old stuff to the trash.
function trash()
{
	if [ -e "$1" ]; then

		local dst=${1##*/}
		while [ -e ~/.Trash/"$dst" ]; do
			dst="`expr "$dst" : '\(.*\)\.[^.]*'` `date +%H-%M-%S`.`expr "$dst" : '.*\.\([^.]*\)'`"
		done

		echo ~/.Trash"$dst"
		mv -f "$1" ~/.Trash"/$dst"
	fi
}

function makeAndFixFolder()
{
	echo "-----"
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
		if [ $? -eq 0 ]; then
			echo "Created folder: $1"
		else
			echo "ERROR: Unable to create folder: $1"
		fi
	fi

	CHOWN_USER=$USER
	if [ -n "$SUDO_USER" ]; then
		CHOWN_USER=$SUDO_USER
		if [ -n "$SUDO_GID" ]; then
			CHOWN_USER="$SUDO_USER:$SUDO_GID"
		fi
	fi

	chown "$CHOWN_USER" "$1"
	if [ $? -eq 0 ]; then
		echo "Changed owner of folder ($1) to user: $CHOWN_USER"
	else
		echo "ERROR: Unable to change the folder ($1) to user: $CHOWN_USER"
	fi

	chmod 777 "$1"
	if [ $? -eq 0 ]; then
		echo "Permissions set successfully for folder: $1"
	else
		echo "ERROR: Unable to set the permissions for folder: $1"
	fi

	return 0
}


# If they exist in /tmp, move the files and set the proper ownership and access
function moveFileFromTemp()
{
	# Validate params
	if [ -z "$1" ] || [ "$1" == "/tmp" ] || [ "$1" == "/" ] || [ -z "$2" ] || [ "$2" == "/" ]; then
		return 1
	fi

	CHOWN_USER=$USER
	if [ -n "$SUDO_USER" ]; then
		CHOWN_USER=$SUDO_USER
		if [ -n "$SUDO_GID" ]; then
			CHOWN_USER="$SUDO_USER:$SUDO_GID"
		fi
	fi

	if [ -f "$1" ]; then
		echo "Moving $1 to $2..."
		mv -f "$1" "$2"
		chown "$CHOWN_USER" "$2"
		chmod 755 "$2"
	elif [ -d "$1" ]; then
		echo "Moving $1 to $2..."
		# Remove old versions
		if [ -d "$2" ]; then
			trash "$2"
		fi
		mv -f "$1" "$2"
		chown -R "$CHOWN_USER" "$2"
		chmod -R 755 "$2"
	fi
}

# Create the App Support folder under /Users/Shared/Library/... Other applications
# (eg Adobe) that install files under /Users/Shared/Library make the permissions
# inaccessible to all users, so we need to fix them when we create our subfolder
USERS_SHARED_LIBRARY_FOLDER="/Users/Shared/Library"
APP_SUPPORT_FOLDER="$USERS_SHARED_LIBRARY_FOLDER/Application Support"
SMITH_MICRO_FOLDER="$APP_SUPPORT_FOLDER/Smith Micro"
APP_FOLDER_PRO="$SMITH_MICRO_FOLDER/Moho Pro"
APP_FOLDER_DEBUT="$SMITH_MICRO_FOLDER/Moho Debut"
APP_FOLDER="$SMITH_MICRO_FOLDER/Moho"

APP_VERSION_FOLDER_PRO="$APP_FOLDER_PRO/12"
APP_VERSION_FOLDER_DEBUT="$APP_FOLDER_DEBUT/12"
APP_VERSION_FOLDER="$APP_FOLDER/12"

makeAndFixFolder "$USERS_SHARED_LIBRARY_FOLDER"
makeAndFixFolder "$APP_SUPPORT_FOLDER"
makeAndFixFolder "$SMITH_MICRO_FOLDER"
makeAndFixFolder "$APP_FOLDER"
makeAndFixFolder "$APP_FOLDER_PRO"
makeAndFixFolder "$APP_FOLDER_DEBUT"
makeAndFixFolder "$APP_VERSION_FOLDER"
makeAndFixFolder "$APP_VERSION_FOLDER_PRO"
makeAndFixFolder "$APP_VERSION_FOLDER_DEBUT"

# FIXME: 2016-01-15 - Eric Long: I don't know how all this FastSpring stuff will need to be worked out

# The trial mode installer does not have admin privileges, so if it can't write to
# /Users/Shared/Library/.. It will just dump its support files to a temp folder
ANIME_TMP_FOLDER=/tmp

# File names to be moved
ANIME_DTA_FILE="Moho"
ANIME_REG_DTA_FILE="MohoReg.dta"
AMIME_TRIAL_MODE_PLIST="com.smithmicro.MohoDebutTrialVersion.plist"
AMIME_TRIAL_MODE_CHECKER="MohoDebutTrialModeChecker.app"
AMIME_APP_SETTINGS_FILE="Moho Debut11.app.settings"

# Source files
ANIME_SRC_DTA_FILE_PATH="$ANIME_TMP_FOLDER/$ANIME_DTA_FILE"
ANIME_SRC_REG_DTA_FILE_PATH="$ANIME_TMP_FOLDER/$ANIME_REG_DTA_FILE"
AMIME_SRC_TRIAL_MODE_PLIST_PATH="$ANIME_TMP_FOLDER/$AMIME_TRIAL_MODE_PLIST"
AMIME_SRC_TRIAL_MODE_CHECKER_PATH="$ANIME_TMP_FOLDER/$AMIME_TRIAL_MODE_CHECKER"
AMIME_SRC_APP_SETTINGS_FILE_PATH="$ANIME_TMP_FOLDER/$AMIME_APP_SETTINGS_FILE"

# FIXME: 2016-01-15 - Eric Long: Where is ANIME_APP_SUPPORT_FOLDER defined? I only see APP_SUPPORT_FOLDER above!

# Destination of files - The destination MUST be the full path since we could be copying folders (like app bundles)
ANIME_DEST_DTA_FILE_PATH="$ANIME_APP_SUPPORT_FOLDER/$ANIME_DTA_FILE"
ANIME_DEST_REG_DTA_FILE_PATH="$ANIME_APP_SUPPORT_FOLDER/$ANIME_REG_DTA_FILE"
AMIME_DEST_TRIAL_MODE_PLIST_PATH="$ANIME_APP_SUPPORT_FOLDER/$AMIME_TRIAL_MODE_PLIST"
AMIME_DEST_TRIAL_MODE_CHECKER_PATH="$ANIME_APP_SUPPORT_FOLDER/$AMIME_TRIAL_MODE_CHECKER"
AMIME_DEST_APP_SETTINGS_FILE_PATH="$ANIME_APP_SUPPORT_FOLDER/$AMIME_APP_SETTINGS_FILE"

# Move all of the files
moveFileFromTemp "$ANIME_SRC_DTA_FILE_PATH" "$ANIME_DEST_DTA_FILE_PATH"
moveFileFromTemp "$ANIME_SRC_REG_DTA_FILE_PATH" "$ANIME_DEST_REG_DTA_FILE_PATH"
moveFileFromTemp "$AMIME_SRC_TRIAL_MODE_PLIST_PATH" "$AMIME_DEST_TRIAL_MODE_PLIST_PATH"
moveFileFromTemp "$AMIME_SRC_TRIAL_MODE_CHECKER_PATH" "$AMIME_DEST_TRIAL_MODE_CHECKER_PATH"
moveFileFromTemp "$AMIME_SRC_APP_SETTINGS_FILE_PATH" "$AMIME_DEST_APP_SETTINGS_FILE_PATH"

# Make /Users/Shared/Library/Application Support/Smith Micro read/writable by all by
# making a recursive chmod command starting with the /Users/Shared/Library folder.
#if [ -d "$USERS_SHARED_LIBRARY_FOLDER" ]; then
#	chmod -R 777 "$USERS_SHARED_LIBRARY_FOLDER"
#fi

# if there's a usershared folder left behind, remove it
UserSharedFolder="$APP_VERSION_FOLDER/usershared"
if [ -d "$UserSharedFolder" ]; then
	rm -R "$UserSharedFolder"
fi

exit 0

