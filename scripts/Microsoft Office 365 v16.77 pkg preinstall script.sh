#!/bin/zsh

LOGDIRECTORY="/Library/Logs/Microsoft"
LOGFILE=$LOGDIRECTORY/autoupdate.log

# ensure we have a log directory before logging
/bin/mkdir -p $LOGDIRECTORY

mau_log()
{
	message=$1	
	timestamp=$(/bin/date +%Y-%m-%d' '%T)
	echo "$timestamp [Apple Installer - preinstall] <Info> $message" >> $LOGFILE
}

mau_log "Starting installation process for Microsoft AutoUpdate"

for executable in "Microsoft AutoUpdate" "Microsoft Update Assistant" "Microsoft AU Daemon" "Microsoft AU Bootstrapper" "com.microsoft.autoupdate.helper" "com.microsoft.autoupdate.helpertool" "com.microsoft.autoupdate.bootstrapper.helper"
do
	mau_log "Closing $executable"
	/usr/bin/pgrep "$executable" | /usr/bin/xargs /bin/kill -9
done

# when a user installs make sure we disable the update agent to prevent
# unwanted interactions during install (MAU replaces this automatically)
/bin/launchctl stop com.microsoft.update.agent
/bin/launchctl unload /Library/LaunchAgents/com.microsoft.update.agent.plist

# Detect and fix Microsoft Application Support folder permission
microsoft_folder="/Library/Application Support/Microsoft"

# Make sure Microsoft folder exists to start with, before attempting to verify ownership and permission
if [ -e ${microsoft_folder} ]
then
	# If the folder ownership string is empty, this means folder ownership / group is set incorrectly
	ms_folder_permission=$( /usr/bin/stat -f "%A" "${microsoft_folder}" )
	ms_folder_ownership=$( /bin/ls -al "${microsoft_folder}" | /usr/bin/grep '[ 	]\.[ 	]*$' |  /usr/bin/grep 'root[ 	]*wheel' )
	if [ "${ms_folder_ownership}" = "" ]
	then
		# Fix the ownership / group ownership
		sudo chown root "${microsoft_folder}"
		sudo chgrp wheel "${microsoft_folder}"
	fi

	if [ "${ms_folder_permission}" != "755" ]
	then
		sudo chmod 755 "${microsoft_folder}"
	fi
fi

exit 0
