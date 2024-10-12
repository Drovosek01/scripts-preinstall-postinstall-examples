#!/bin/zsh

umask 022

LOGDIRECTORY="/Library/Logs/Microsoft"
LOGFILE="$LOGDIRECTORY/autoupdate.log"

user_name=$(/usr/bin/defaults read /Library/Preferences/com.apple.loginwindow lastUserName)

# ensure we have a log directory before logging
/bin/mkdir -p "$LOGDIRECTORY"

mau_log()
{
	local message="$1"	
	local timestamp="$(/bin/date +%Y-%m-%d' '%T)"
	/bin/echo "$timestamp [Apple Installer - postinstall] <Info> $message" >> "$LOGFILE"
}

should_reopen_mau_gui()
{
	# test if MAU set the preference to relaunch the GUI. Delete once read.
	local mau_reopen_pref="$(/usr/bin/sudo -u "$user_name" /usr/bin/defaults read com.microsoft.autoupdate2 ReopenAfterGUIInstall)"
	/usr/bin/sudo -u "$user_name" /usr/bin/defaults delete com.microsoft.autoupdate2 ReopenAfterGUIInstall

	# cases where we want to reopen UI:
	# 1) if update is initiated from MAU UI (governed by ReopenAfterGUIInstall pref setting)
	# 2) Update pkg was opened from Finder (including open call from terminal. This will NOT have COMMAND_LINE_INSTALL set)
	# Other invocations result in COMMAND_LINE_INSTALL set to 1 and ReopenAfterGUIInstall pref value not set.
	if [[ "$mau_reopen_pref" == "1" || -z $COMMAND_LINE_INSTALL ]]
	then
		mau_log "Reopen UI after install. MAU UI install: $mau_reopen_pref COMMAND_LINER_INSTALL: $COMMAND_LINE_INSTALL"
		return 0
	fi

	mau_log "Do not reopen UI after install. MAU UI install: $mau_reopen_pref COMMAND_LINER_INSTALL: $COMMAND_LINE_INSTALL"
	return 1
}

mauApp="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app"
daemonApp="${mauApp}/Contents/MacOS/Microsoft Update Assistant.app"
bootstrapperApp="/Library/Application Support/Microsoft/MAU2.0/Microsoft AU Bootstrapper.app"

libraryDaemons="/Library/LaunchDaemons"
libraryHelpers="/Library/PrivilegedHelperTools"

legacyHelper="com.microsoft.autoupdate.helpertool"
legacyLaunchdPlist="com.microsoft.autoupdate.helpertool.plist"

helper="com.microsoft.autoupdate.helper"
bootstrapper_helper="com.microsoft.autoupdate.bootstrapper.helper"
launchdPlist="com.microsoft.autoupdate.helper.plist"
bootstrapper_launchdPlist="com.microsoft.autoupdate.bootstrapper.helper.plist"

helper_in_app="${mauApp}/Contents${libraryHelpers}/${helper}"
launchdPlist_in_app="${mauApp}/Contents${libraryDaemons}/${launchdPlist}"

# only attempt to replace MAU helper/plist and remove bootstrapper if they exist in the app on disk
if [[ -e "${helper_in_app}" && -e "${launchdPlist_in_app}" ]]
then
	mau_log "Cleaning up old installations"
	# unload ensures safe removal/replacement of launchd plists
	/bin/launchctl stop -wF com.microsoft.autoupdate.helpertool
	/bin/launchctl stop -wF com.microsoft.autoupdate.helper
	/bin/launchctl unload -wF "${libraryDaemons}/${legacyLaunchdPlist}"
	/bin/launchctl unload -wF "${libraryDaemons}/${launchdPlist}"

	/bin/rm -f "${libraryDaemons}/${legacyLaunchdPlist}"
	/bin/rm -f "${libraryHelpers}/${legacyHelper}"

	# VSO:2861403 & VSO:2861411
	# NSXPCConnection from Apple Foundation Framework will hold the connection and try to restart depends
	# on system memory load unless XPC Endpoint (in our case, PriviledgedHelper) is removed. We are seeing
	# crashes on XPC since MAU is trying to communicate with corrupted or previous PriviledgedHelper, instead of the
	# new one.
	/bin/rm -f "${libraryDaemons}/${launchdPlist}"
	/bin/rm -f "${libraryHelpers}/${helper}"
	
	# ensure clean installs of OS have these dirs before cp
	/bin/mkdir -p "${libraryDaemons}/"
	/bin/mkdir -p "${libraryHelpers}/"

	mau_log "Moving things into place"
	/bin/cp "${launchdPlist_in_app}" "${libraryDaemons}/"
	/bin/cp "${helper_in_app}" "${libraryHelpers}/"

	# Load new launchd plist config for the helper
	/bin/launchctl load -wF "${libraryDaemons}/${launchdPlist}"
fi

libraryLaunchAgents="/Library/LaunchAgents"
launchAgentPlist="com.microsoft.update.agent.plist"
launchAgentPlist_in_app="${mauApp}/Contents${libraryLaunchAgents}/${launchAgentPlist}"
if [[ -e "${launchAgentPlist_in_app}" ]]
then
	mau_log "Finishing up"
	/bin/launchctl stop com.microsoft.update.agent
	/bin/launchctl unload -wF "${libraryLaunchAgents}/${launchAgentPlist}"
	/bin/rm -f "${libraryLaunchAgents}/${launchAgentPlist}"
	/bin/mkdir -p "${libraryLaunchAgents}/"
	/bin/cp "${launchAgentPlist_in_app}" "${libraryLaunchAgents}/"

	mau_pid=$(/usr/bin/pgrep "Microsoft AutoUpdate")

	if [[ -n $mau_pid ]]
	then
		# MAU may have been launched by the user after pre-install killed the app. Try terminating again.
		/bin/kill -9 $mau_pid
		reopenArg="-r"
	fi
fi

parent_dir=`/usr/bin/dirname "$0"`
chain_clu="$parent_dir/chain_app"

# Find the PID of the installer process
installer_pid=$(/bin/ps -o pid,command -ax | /usr/bin/grep "Installer\.app/Contents/MacOS/Installer" | /usr/bin/awk '{print $1}')

if ! [[ -n $installer_pid ]]
then
	mau_log "Detected nil installer pid. Using alternate process for postinstall"
        installer_pid=$(/bin/ps -o pid,command -ax | grep '/bin/zsh ' | grep 'Scripts/com.microsoft.package.Microsoft_AutoUpdate.app' | grep 'postinstall' | /usr/bin/awk 'NR==1{print $1}' )
fi

if [[ -d "${mauApp}" ]]
then
        # Adding delay here to allow more time for ReopenAfterGUIInstall preference to be written
        sleep 5

        if should_reopen_mau_gui
        then
                reopenArg="-r"
        fi

        mau_log "Registering Microsoft Autoupdate as trusted app"
        /usr/bin/sudo -u $user_name /usr/bin/open -a "$chain_clu" --args "${reopenArg}" -p "$installer_pid" &
fi

if [[ -e "${bootstrapperApp}" ]]
then
	mau_log "Removing AutoUpdate Bootstrapper"
	/bin/rm -fr "${bootstrapperApp}"
	/bin/launchctl stop -wF com.microsoft.autoupdate.bootstrapper.helper
	/bin/launchctl unload -wF "${libraryDaemons}/${bootstrapper_launchdPlist}"
	/bin/rm -f "${libraryDaemons}/${bootstrapper_launchdPlist}"
	/bin/rm -f "${libraryHelpers}/${bootstrapper_helper}"
fi

# See if there is MAU preferences under /var/root - this is incorrect and should be removed as it may cause MAU to update from incorrect channel/method.
# Add Teams to Application dictionary, if exists, and is not registered already
teamsPath="/Applications/Microsoft Teams.app"
if [[ -e "${teamsPath}" ]]
then
       /usr/bin/sudo -u $user_name /usr/bin/defaults read com.microsoft.autoupdate2 Applications | grep -q "TEAMS10"

       if [ $? -gt 0 ]; then
              mau_log "Adding Teams to Applications dictionary"
              /usr/bin/sudo -u $user_name /usr/bin/defaults write com.microsoft.autoupdate2 Applications -dict-add "${teamsPath}" "{ 'Application ID' = 'TEAMS10'; LCID = 1033; }"
       fi

       /usr/bin/defaults read /Library/Preferences/com.microsoft.autoupdate2 ApplicationsSystem | grep -q "TEAMS10"

       if [ $? -gt 0 ]; then
              mau_log "Adding Teams to ApplicationsSystem dictionary"
              /usr/bin/defaults write /Library/Preferences/com.microsoft.autoupdate2 ApplicationsSystem -dict-add "${teamsPath}" "{ 'Application ID' = 'TEAMS10'; LCID = 1033; }"
       fi
fi

incorrect_root_mau_pref="/var/root/Library/Preferences/com.microsoft.autoupdate2.plist"
if [[ -e "${incorrect_root_mau_pref}" ]]
then
	mau_log "Found non user level Microsoft Autoupdate preference file. Removing."
	sudo rm -f ${incorrect_root_mau_pref}
fi

if ( /usr/bin/grep -q "${bootstrapperApp}" <<< $(/usr/bin/sudo -u $user_name /usr/bin/defaults read com.microsoft.autoupdate2 Applications) )
then
	mau_log "Removing AutoUpdate Bootstrapper dafaults entry"
	/usr/bin/sudo -u $user_name /usr/libexec/PlistBuddy -c "Delete :Applications:'${bootstrapperApp}'" ~/Library/Preferences/com.microsoft.autoupdate2.plist
fi

if ! ( /usr/bin/grep -q "${mauApp}" <<< $(/usr/bin/sudo -u $user_name /usr/bin/defaults read com.microsoft.autoupdate2 Applications) )
then
	mau_log "Adding defaults entry to User Pref"
	/usr/bin/sudo -u $user_name /usr/bin/defaults write com.microsoft.autoupdate2 Applications -dict-add "${mauApp}" "{ 'Application ID' = 'MSau04'; LCID = 1033 ; 'App Domain' = 'com.microsoft.office' ; }"
fi

if ! ( /usr/bin/grep -q "${mauApp}" <<< $(/usr/bin/defaults read /Library/Preferences/com.microsoft.autoupdate2.plist ApplicationsSystem) )
then
	mau_log "Adding defaults entry to System Pref"
	/usr/bin/defaults write /Library/Preferences/com.microsoft.autoupdate2 ApplicationsSystem -dict-add "${mauApp}" "{ 'Application ID' = 'MSau04'; LCID = 1033 ; 'App Domain' = 'com.microsoft.office' ; }"
fi

mau_log "Resetting IOC consecutive restore failure count"
/usr/bin/sudo -u $user_name /usr/bin/defaults write com.microsoft.autoupdate2 IOCRestoreFailCount 0

mau_log "Finished installation process for Microsoft AutoUpdate"

exit 0
