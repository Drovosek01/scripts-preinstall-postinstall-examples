#!/bin/bash

installation_path=$2

acrobatapp="Adobe Acrobat.app"
conflictingappinstalled="false"
currentMajor="22"
currentMinor="002"
currentMinorMinor="20191"
installedVersion="22.002.20191"
trackName=DC

CLI_mode=0	#0 indicates GUI, 1 indicates CLI installation
if [ $COMMAND_LINE_INSTALL 2>/dev/null ]
then
CLI_mode=1
fi

function detectConflictingAppInstalled
{
    majorObtained=$1
    minorObtained=$2
    minorMinorObtained=$3
    
	if [ $majorObtained -gt $currentMajor ] 
	then
		conflictingappinstalled="true"
		return 0
	fi
	if [ $majorObtained -lt $currentMajor ]
	then
		conflictingappinstalled="false"
		return 0
	fi
	#majors are equal
	if [ $minorObtained -gt $currentMinor ] 
	then
		conflictingappinstalled="true"
		return 0
	fi
	if [ $minorObtained -lt $currentMinor ] 
	then
		conflictingappinstalled="false"
		return 0
	fi
	#minors are equal
	if [ $minorMinorObtained -gt $currentMinorMinor ] 
	then
		conflictingappinstalled="true"
		return 0
	fi
	if [ $minorMinorObtained -lt $currentMinorMinor ] 
	then
		conflictingappinstalled="false"
		return 0
	fi
	#both minors are equal which means versions match
	conflictingappinstalled="false"
}

mydir=`pwd`
myAlert="$mydir/Tools/AcroInstallAlert.app/Contents/MacOS/AcroInstallAlert"

if [  -e "$installation_path/$acrobatapp" ]
then
	if [ -e "$installation_path/$acrobatapp/Contents/Info.plist" ]
	then
		installedVersion=`defaults read "$installation_path/$acrobatapp/Contents/Info" CFBundleVersion`
		major=`echo $installedVersion | cut -d "." -f 1`
		minor=`echo $installedVersion | cut -d "." -f 2`
		minor_minor=`echo $installedVersion | cut -d "." -f 3`
		detectConflictingAppInstalled "$major" "$minor" "$minor_minor"
	fi
else
    #check for the upgrade scenario and remove the old app, if present
    if [ -e $myAlert ]
    then
        $myAlert TitleAcrobat Upgrade
        if [ $? -ne 0 ]; then
            echo "ERROR: Could not remove the old copy of Acrobat."
            exit -1
        fi
    else
        echo "ERROR:$myAlert not found."
    fi
fi

if [ $conflictingappinstalled == "true" ] 
then
    if [ $CLI_mode -eq 1 ]
    then
        echo "ERROR: The installation cannot proceed since a higher version of Acrobat already exists in your chosen destination folder."
    else
        echo "ERROR: The installation cannot proceed since a higher version of Acrobat already exists in your chosen destination folder."
        if [ -e $myAlert ]
        then
            $myAlert TitleAcrobat AcrobatExists
        else
            echo "ERROR:$myAlert not found."
        fi
    fi
    exit -1
else
	#write the current Acrobat version and track name to temp file. This info will be consumed by AcroServiceUpdater payload's postinstall script
	if [ -e /private/tmp/com.adobe.acrobat.rna.plist ]
	then
		rm -f /private/tmp/com.adobe.acrobat.rna.plist
	fi
	defaults write /private/tmp/com.adobe.acrobat.rna.plist MajorVersion $currentMajor
	defaults write /private/tmp/com.adobe.acrobat.rna.plist MinorVersion $currentMinor
	defaults write /private/tmp/com.adobe.acrobat.rna.plist MinorMinorVersion $currentMinorMinor
	defaults write /private/tmp/com.adobe.acrobat.rna.plist TrackName $trackName

	if [ -e "/Library/Preferences/com.adobe.acrobat.DC.WebResource.plist" ]
    then
		fullVersion=`defaults read /Library/Preferences/com.adobe.acrobat.DC.WebResource.plist tFullVersion`
		defaults write /private/tmp/com.adobe.acrobat.rna.plist tFullVersion $fullVersion
	fi
fi
