#!/bin/bash

strEnvVarName="setenv.lightmap.HDRLS_HOME_V5"

# Check if the env var is currently set, if it is it needs unloading before any changes are applied
nCurRunCount=$(sudo -u $USER launchctl list | grep $strEnvVarName | wc -c)
if [ $nCurRunCount -gt 0 ]
then
	sudo -u $USER launchctl unload /Library/LaunchAgents/$strEnvVarName.plist
fi

sudo cp /Applications/HDRLightStudio.app/Contents/Resources/$strEnvVarName.plist /Library/LaunchAgents/

sudo -u $USER launchctl load /Library/LaunchAgents/$strEnvVarName.plist

exit 0
