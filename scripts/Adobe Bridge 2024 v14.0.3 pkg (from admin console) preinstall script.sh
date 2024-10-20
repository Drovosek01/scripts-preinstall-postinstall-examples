#!/bin/sh

#*************************************************************************
#
# ADOBE CONFIDENTIAL
# ___________________
#
#  Copyright 2010 Adobe Systems Incorporated
#  All Rights Reserved.
#
# NOTICE:  All information contained herein is, and remains
# the property of Adobe Systems Incorporated and its suppliers,
# if any.  The intellectual and technical concepts contained
# herein are proprietary to Adobe Systems Incorporated and its
# suppliers and are protected by trade secret or copyright law.
# Dissemination of this information or reproduction of this material
# is strictly forbidden unless prior written permission is obtained
# from Adobe Systems Incorporated.
#*************************************************************************

AAMEE_Remove_Dir()
{
	if [  -d "$2" ]
	then
		rm -rdf	"$2"
		if [ "$?" -ne "0" ]; then
			echo "CCP Package Installer : Deletion of folder : ($1) failed"
		fi
	else
		echo "CCP Package Installer : ($1) folder not found."
	fi
}

AAMEE_Remove_File()
{
	if [ -f "$2" ]
	then
		rm -f "$2"
		if [ "$?" -ne "0" ]; then
        	       	echo "CCP Package Installer : Deletion of file : ($1) failed"
	        fi
	else
		echo "CCP Package Installer : ($1) file not found."
	fi
}

echo "CCP Package Installer : preinstall launched..."
echo "The language set is $INSTALLLANG"

if [ -f "/System/Library/CoreServices/SystemVersion.plist" ]
then
	OS_VERSION=`/usr/bin/defaults read /System/Library/CoreServices/SystemVersion ProductVersion`
else 
	if [ -f "/System/Library/CoreServices/ServerVersion.plist" ]
	then
		OS_VERSION=`/usr/bin/defaults read /System/Library/CoreServices/ServerVersion ProductVersion`
	else
		echo "CCP Package Installer : Failed to get OS_VERSION in preinstall..."
	fi
fi

if [ -n "$OS_VERSION" ]
then
	OS_MAJOR_VERSION=`echo $OS_VERSION | cut -f1 -d'.'`
	OS_MINOR_VERSION=`echo $OS_VERSION | cut -f2 -d'.'`
	OS_PATCH_VERSION=`echo $OS_VERSION | cut -f3 -d'.'`

	# Checking specifically for 10.5.x as we do not support OS below 10.5
	# Trying to clean Receipt for 10.5.x
	if [[ "$OS_MAJOR_VERSION" -eq "10" && "$OS_MINOR_VERSION" -eq "5" ]]
	then
		PkgName=`basename "$PACKAGE_PATH"`
		ReceiptsPkgPath="$INSTALLER_TEMP/Receipts/$PkgName/Contents/Resources"
		
		if [  -d "$ReceiptsPkgPath" ]
		then
			echo "CCP Package Installer : Receipt found, trying to cleanup..."
			
			AAMEE_Remove_Dir "Setup" 		"$ReceiptsPkgPath/Setup"
			AAMEE_Remove_Dir "ASU" 		"$ReceiptsPkgPath/ASU"
			AAMEE_Remove_Dir "Patches" 		"$ReceiptsPkgPath/Patches"
			AAMEE_Remove_Dir "ProvisioningTool" 	"$ReceiptsPkgPath/ProvisioningTool"
			
			AAMEE_Remove_File "AdobeDeploymentManager" 	"$ReceiptsPkgPath/AdobeDeploymentManager"
			AAMEE_Remove_File "OptionXML" 		"$ReceiptsPkgPath/optionXML.xml"
		fi
	fi
fi

oldWD=`pwd`

parentDir=`dirname "$0"`
cd "$parentDir"
WD=`pwd`

cd "$oldWD"

if [ -f "$WD/AdobeDeploymentManager" ]
then
	echo "CCP Package Installer : Working directory is $WD"
else
	echo "CCP Package Installer : Working directory is not valid $WD"
	echo "CCP Package Installer : Trying to find relative path from pkg"
	WD="$1/Contents/Resources"
	if [ -f "$WD/AdobeDeploymentManager" ]
	then
		echo "CCP Package Installer : Working directory is $WD"
	else
		echo "CCP Package Installer : Working directory is not valid $WD"
		echo "CCP Package Installer : AdobeDeploymentManager is not present in the working directory. Corrupted Installer. "
		exit -1
	fi
fi

infoPlistFilePath="$WD/../Info.plist"
INSTALLLANG=""
if [ -f "$infoPlistFilePath" ]
then
	INSTALLLANG=`/usr/bin/defaults read "$WD/../Info" InstallLanguage`
	echo "CCP Package Installer : InstallLanguage specified in Info.plist in preinstall...($INSTALLLANG)"
else 
	echo "CCP Package Installer : Failed to find pkg Info.plist in preinstall...$infoPlistFilePath"
fi

echo "CCP Package Installer : Launching AdobeDeploymentManager..."
"$WD/AdobeDeploymentManager" --optXMLPath="$WD/optionXML.xml" --setupBasePath="$WD/" --installDirPath="$2" --installLanguage="$INSTALLLANG" --mode=install
ADMExitCode=$?

echo "CCP Package Installer : Exit code of AdobeDeploymentManager is ($ADMExitCode)"
echo "CCP Package Installer : Exit ..."
exit $ADMExitCode
