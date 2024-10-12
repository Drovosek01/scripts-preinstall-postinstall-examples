#!/usr/bin/env bash
# Script to run application file

if [ -e /private/tmp/com.adobe.acrobat.rna.plist ]
then
	currentAppVersionMajor=`defaults read /private/tmp/com.adobe.acrobat.rna MajorVersion`
	currentAppVersionMinor=`defaults read /private/tmp/com.adobe.acrobat.rna MinorVersion`
	currentAppVersionMinorMinor=`defaults read /private/tmp/com.adobe.acrobat.rna MinorMinorVersion`
	tFullVersion=`defaults read /private/tmp/com.adobe.acrobat.rna tFullVersion`
	trackName=`defaults read /private/tmp/com.adobe.acrobat.rna TrackName`

	rm -f /private/tmp/com.adobe.acrobat.rna.plist
else
	echo "Error: Couldn't find /private/tmp/com.adobe.acrobat.rna.plist to read current Acrobat version being installed."
fi


if [ -f "/tmp/webinstaller/AcroServicesUpdater.app/Contents/MacOS/AcroServicesUpdater" ];
then
	/tmp/webinstaller/AcroServicesUpdater.app/Contents/MacOS/AcroServicesUpdater
	rm -rf /tmp/webinstaller
	exit 0
else
	exit 1
fi
