#!/bin/bash

# **********************************************************
#             Copyright 2009-2012 Esko Software bvba
#                     All rights reserved
#  All programs and data are property of Esko Software bvba
# **********************************************************
#
# Post Installation Procedure

# Full folder specification where this file is 
where=${0%/*}
pushd "${where}" >/dev/null ; where=$(pwd) ; popd >/dev/null

# Make sure run by sudo
#if [ "$UID" -ne 0 ]
#then
#  echo
#  echo "ERROR - This script must be run using 'sudo' or as root (su)."
#  exit 1
#fi

status=1

sleep 2
dattim=$(date "+%Y%m%d%H%M%S")

# Log file
LOGFIL="${HOME}/Library/Logs/EskoNetworkLicenseManager_22.07_PostInstall.log"

# Folder locations
SCRIPT_PATH="$0"
PACKAGE_PATH="$1"
TARGET_PATH="$2"
TARGET_VOL="$3"

# TARGET_PATH="/Applications/Esko Network License Manager"

echo "Esko License Server Post_Installation" >"${LOGFIL}"
date "+%Y-%m-%d %H:%M:%S" >>"${LOGFIL}"
echo "TARGET_PATH=${TARGET_PATH}" >>"${LOGFIL}"
echo "" >>"${LOGFIL}"

"${where}/clean_ls_lm" "${TARGET_PATH}" "${LOGFIL}"
if [ $? -ne 0 ]
then
  status=1
else
  status=0
fi

"${where}/install_ls_lm" "${TARGET_PATH}" "${LOGFIL}"
if [ $? -ne 0 ]
then
  status=1
else
  status=0
fi

echo "Creating link to log file ..." >>"${LOGFIL}"
srcfil="/Library/Application Support/FLEXnet Publisher/Manager/Log File/flexlm.log"
lnkfil="${TARGET_PATH}/Open License Server Log File"
ln -s -f -v "${srcfil}" "${lnkfil}" >>"${LOGFIL}" 2>&1

# remove previous versions installed in other folders


# GetValueFromPlist : get the value for the given key from the given plist
# will echo the result
# $1 the key for which we need the value
# $2 path to plist file containing the needed key
function GetValueFromPlist
{
    echo `/usr/libexec/PlistBuddy -c "Print $1" $2`
}

# RemoveEmptyFolderVerbose : remove an empty folder ( also removes the folder if only a .DS_STORE file is present )
# and print out the removed folder path if succeeded
# $1 the folder to remove
function RemoveEmptyFolderVerbose
{
    local THE_FOLDER_TO_REMOVE_IF_EMPTY=$1

    # if the folder only contains .DS_Store, remove the file so we can remove the folder

    if [ "`ls -A \"$THE_FOLDER_TO_REMOVE_IF_EMPTY\" | grep -iv '^.DS_Store$'`" == "" ]
    then

        if [ -f "$THE_FOLDER_TO_REMOVE_IF_EMPTY/.DS_Store" ]
        then

            rm -v "$THE_FOLDER_TO_REMOVE_IF_EMPTY/.DS_Store"

        fi

    fi

    # remove folder and print out folder name if it succeeded

    rmdir "$THE_FOLDER_TO_REMOVE_IF_EMPTY"

    if [ "$?" == "0" ]
    then

        echo "$THE_FOLDER_TO_REMOVE_IF_EMPTY"

    fi
}

# DeleteSymlinksInFolder : remove all symlinks in given folder
# $1 the folder with symlinks
function DeleteSymlinksInFolder
{
    local THE_FOLDER_WITH_SYMLINKS=$1

    for THE_POSSIBLE_SYMLINK in `ls -A "$THE_FOLDER_WITH_SYMLINKS" | sed -e "s: :@@:g"`
    do

        THE_POSSIBLE_SYMLINK=`echo "$THE_POSSIBLE_SYMLINK" | sed -e "s:@@: :g"`

        if [ -h "$THE_FOLDER_WITH_SYMLINKS/$THE_POSSIBLE_SYMLINK" ]
        then

            rm -v "$THE_FOLDER_WITH_SYMLINKS/$THE_POSSIBLE_SYMLINK"

        fi

    done
}

# RemoveApplication : remove all files for the given application identifier ( reverse domain name )
# $1 the application identifier in reverse domain name format (example : com.enfocus.locallicensemanager.1.5 )
function RemoveApplication
{
    local THE_APPLICATION_IDENTIFIER=$1

    local THE_RECEIPT_FILE="/var/db/receipts/$THE_APPLICATION_IDENTIFIER.bom"
    local THE_RECEIPT_PLIST="/var/db/receipts/$THE_APPLICATION_IDENTIFIER.plist"

    if [ "$THE_RECEIPT_PLIST" != "" ]
    then

        local THE_FILES_PREFIX=`GetValueFromPlist "InstallPrefixPath" $THE_RECEIPT_PLIST`

        for THE_FILE_OR_FOLDER_TO_REMOVE in `lsbom -fdls $THE_RECEIPT_FILE | grep -v '^\.$' | sort -r | sed -e "s:^\.:\/${THE_FILES_PREFIX}:g" -e "s: :@@:g"`
        do

            THE_FILE_OR_FOLDER_TO_REMOVE=`echo "$THE_FILE_OR_FOLDER_TO_REMOVE" | sed -e "s:@@: :g"`

            if [ -d "$THE_FILE_OR_FOLDER_TO_REMOVE" ]
            then

                DeleteSymlinksInFolder "$THE_FILE_OR_FOLDER_TO_REMOVE"
                RemoveEmptyFolderVerbose "$THE_FILE_OR_FOLDER_TO_REMOVE"

            elif [ -f "$THE_FILE_OR_FOLDER_TO_REMOVE" ]
            then

                rm -v "$THE_FILE_OR_FOLDER_TO_REMOVE"

            fi

        done

        # remove parent folder if not installed directly under /Applications

        if [[ $THE_FILES_PREFIX == Applications* ]]
        then

            if [ "$THE_FILES_PREFIX" != "Applications" ]
            then

                DeleteSymlinksInFolder "/$THE_FILES_PREFIX"
                RemoveEmptyFolderVerbose "/$THE_FILES_PREFIX"
            fi

        fi

        rm -v "$THE_RECEIPT_FILE"
        rm -v "$THE_RECEIPT_PLIST"

    fi
}

# UninstallPackage : uninstall an application that was install using a pkg file
# $1 the reverse domain application name of the pkg
function UninstallPackage
{
    local THE_INSTALLED_APPS_LIST=`pkgutil --pkgs=$1`

    if [ "$THE_INSTALLED_APPS_LIST" != "" ]
    then

        local THE_REMOVE_ALL_INSTALLED_APPS=1

        for THE_INSTALLED_APP in $THE_INSTALLED_APPS_LIST
        do

            local THE_APP_PLIST_FILE="/var/db/receipts/$THE_INSTALLED_APP.plist"

            local THE_INSTALLED_APP_VERSION=`GetValueFromPlist "PackageVersion" "$THE_APP_PLIST_FILE"`

            echo "removing application $THE_INSTALLED_APP with version $THE_INSTALLED_APP_VERSION"

            RemoveApplication $THE_INSTALLED_APP

        done
    fi
}

THE_OLD_INSTALLER_IDS="com.esko.enfocusLicenseServer100.enfocusLicenseServer.pkg com.esko.enfocusLicenseServer101.enfocusLicenseServer.pkg com.esko.enfocusLicenseServer102.enfocusLicenseServer.pkg com.esko.enfocusLicenseServer103.enfocusLicenseServer.pkg com.esko.enfocusLicenseServer106.EnfocusLicenseServer.pkg com.enfocus.LicenseServer com.esko.eskoartworkLicenseServer100.eskoartworkLicenseServer.pkg com.esko.eskoartworkLicenseServer101.eskoartworkLicenseServer.pkg com.esko.eskoartworkLicenseServer102.eskoartworkLicenseServer.pkg com.esko.eskoLicenseServer100.eskoLicenseServer.pkg com.esko.eskoLicenseServer103.eskoLicenseServer.pkg com.esko.eskoLicenseServer1211.EskoLicenseServer.pkg com.esko.LicenseServer"


for THE_INSTALLER_ID in $THE_OLD_INSTALLER_IDS
do

    UninstallPackage $THE_INSTALLER_ID

done

# some versions of the License Managers copy data into the License Server folder in the postflight script, so we remove those now

rm -r "/Applications/Enfocus License Server 1.0" 2>/dev/null
rm -r "/Applications/Esko License Server" 2>/dev/null


if [ $status -ne 0 ]
then
  echo "Finished with errors."
  exit 1
else
  echo "Finished."
  exit 0
fi
