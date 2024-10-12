#!/bin/zsh

#  Chain to perform tasks after installer process has exited.

# Exit 1 if no args. At the minimum, chain_app requires a process id to monitor and wait for.
if [ $# -eq 0 ]
then
    exit 1
fi

# Parse args.
while getopts ":d:p:r" option
do
	case $option in
		  # Delay in seconds to wait until $PID quits.
		  d ) DELAY=$OPTARG ;;
		  # PID to wait on before executing $APPLICATION.
		  p ) PID=$OPTARG ;;
		  # Indication whether to reopen UI after installing
		  r ) REOPEN_UI=1 ;;
		  * ) break ;;
	esac
done
 
shift $((OPTIND - 1))
 
# Default $DELAY to 1 if not passed.
DELAY=${DELAY:-1}
 
# Set extra args to rest of arguments.
EXTRA_ARGS=$*
 
# Sleep until $PID quits. Even if no process id was passed in, should still attempt to register/run.
if [ -n "$PID" ]
then
	while [ $(/bin/ps -o pid -p"$PID" | /usr/bin/grep "$PID" | /usr/bin/awk '{print $1}') ]
	do
		/bin/sleep "$DELAY"
	done
fi
# Little extra delay to make sure installer process has truely exited.
/bin/sleep "$DELAY"

# Register daemon and ui as trusted apps.
mauApp="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app"
daemonApp="${mauApp}/Contents/MacOS/Microsoft Update Assistant.app"

register_trusted_cmd=(/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -R -f -trusted)
$register_trusted_cmd "${daemonApp}"
$register_trusted_cmd "${mauApp}"

/usr/bin/defaults delete com.microsoft.autoupdate2 LastUpdate

# Load Update Assistant
libraryLaunchAgents="/Library/LaunchAgents"
launchAgentPlist="${libraryLaunchAgents}/com.microsoft.update.agent.plist"

if [[ -e ${launchAgentPlist} ]]
then
	launchctl stop -wF com.microsoft.update.agent
	launchctl unload -wF ${launchAgentPlist}
	launchctl load -wF -S Aqua ${launchAgentPlist}
fi

mau_ignore_reopen_pref_managed="$(/usr/bin/defaults read /Library/Managed\ Preferences/com.microsoft.autoupdate2.plist IgnoreUIOpenAfterInstall)"
mau_ignore_reopen_pref_user="$(/usr/bin/defaults read com.microsoft.autoupdate2 IgnoreUIOpenAfterInstall)"

if [[ ${mau_ignore_reopen_pref_managed} -ne 1 ]] && [[ ${mau_ignore_reopen_pref_managed} != "1" ]] && [[ ${mau_ignore_reopen_pref_user} -ne 1 ]] && [[ ${mau_ignore_reopen_pref_user} != "1" ]]
then
        if [[ ${REOPEN_UI} -eq 1 ]]
        then
                /usr/bin/defaults write com.microsoft.autoupdate2 StartDaemonOnAppLaunch -bool YES
                /usr/bin/open "${mauApp}" --args -silent 1 &
        else
                /usr/bin/open "${mauApp}" --args --quitOnLaunch &
        fi
fi
 
exit $?
