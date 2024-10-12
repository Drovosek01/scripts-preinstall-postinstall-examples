#!/bin/zsh
APPNAME="Microsoft Word"
LOGDIRECTORY="/Library/Logs/Microsoft"
LOGFILE="$LOGDIRECTORY/preinstall.log"

# Ensure we have a log directory before logging
/bin/mkdir -p "$LOGDIRECTORY"

# Logs a string of text to the default log file
function write_log()
{
	message="$1"	
	timestamp=$(/bin/date +%Y-%m-%d' '%T)
	echo "$timestamp [Apple Installer - preinstall] <Info> $message" >> $LOGFILE
}

# Tests whether the app to be updated is closed - returns 1 if closed, or 0 if running
function is_app_closed()
{
	/usr/bin/pgrep -q "$1"
}

# Send the app a signal to forcibly close the process
function forcibly_close_app()
{
	/usr/bin/pkill -HUP "$APPNAME"
}

# Main routine

# Ensure we only terminate apps if MAU is not Installing with IOC. IOC install is indicated by install target location other than /Applications in $2
if [[ $2 == /Applications* ]]
then
	is_app_closed "$APPNAME"
	if [[ $? == 0 ]]; then
		# We need to force close the app
		write_log "Attempting to update $APPNAME, but the app is currently running. Forcibly closing. Package path: $PACKAGE_PATH"
		forcibly_close_app
	fi
fi
	
exit 0
