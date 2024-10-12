#!/bin/bash

################################################
# Functions to unload/load Updater related agents and daemons
#################################################

# Prevent double inclusion
[[ ${OD_SERVICE_INCL:-} -eq 1 ]] && return || readonly OD_SERVICE_INCL=1

base_dir=${base_dir:-"${PWD}"}
source "${base_dir}/od_logging"

if [ "${LOGIN_USERNAME}" == "root" ] || [ -z "${LOGIN_USERNAME}" ]; then
    LOGIN_USERNAME=${USER}
    if [ "${USER}" == "root" ]; then
        LOGIN_USERNAME=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)
    fi
fi

# Logging related
LAUNCHDAEMONS_FOLDER="/Library/LaunchDaemons"
LAUNCHAGENTS_FOLDER="/Library/LaunchAgents"
ONEDRIVE_BUNDLE_ID="com.microsoft.OneDrive"

PLISTBUDDY_COMMAND="/usr/libexec/PlistBuddy"

# AutoUpdater related
AUTOUPDATER_DAEMON_BUNDLE_ID="com.microsoft.OneDriveUpdaterDaemon"
AUTOUPDATER_DAEMON_PLIST_FILE="${LAUNCHDAEMONS_FOLDER}/${AUTOUPDATER_DAEMON_BUNDLE_ID}.plist"
AUTOUPDATER_DAEMON_BINARY="${DSTROOT}/OneDrive.app/Contents/OneDriveUpdaterDaemon.xpc/Contents/MacOS/OneDriveUpdaterDaemon"
AUTOUPDATER_DAEMON_LOG="/Library/Logs/Microsoft/OneDrive/OneDriveUpdaterDaemon.log"

# Standalone Updater related
STANDALONEUPDATER_DAEMON_BUNDLE_ID="com.microsoft.OneDriveStandaloneUpdaterDaemon"
STANDALONEUPDATER_DAEMON_PLIST_FILE="${LAUNCHDAEMONS_FOLDER}/${STANDALONEUPDATER_DAEMON_BUNDLE_ID}.plist"
STANDALONEUPDATER_DAEMON_BINARY="${DSTROOT}/OneDrive.app/Contents/StandaloneUpdaterDaemon.xpc/Contents/MacOS/StandaloneUpdaterDaemon"
STANDALONEUPDATER_DAEMON_LOG="/Library/Logs/Microsoft/OneDrive/OneDriveStandaloneUpdaterDaemon.log"

STANDALONEUPDATER_AGENT_BUNDLE_ID="com.microsoft.OneDriveStandaloneUpdater"
STANDALONEUPDATER_AGENT_PLIST_FILE="${LAUNCHAGENTS_FOLDER}/${STANDALONEUPDATER_AGENT_BUNDLE_ID}.plist"
STANDALONEUPDATER_AGENT_BINARY="${DSTROOT}/OneDrive.app/Contents/StandaloneUpdater.app/Contents/MacOS/OneDriveStandaloneUpdater"

# SyncReporter related
SYNCREPORTER_AGENT_BUNDLE_ID="com.microsoft.SyncReporter"
SYNCREPORTER_AGENT_PLIST_FILE="${LAUNCHAGENTS_FOLDER}/${SYNCREPORTER_AGENT_BUNDLE_ID}.plist"
SYNCREPORTER_AGENT_BINARY="${DSTROOT}/OneDrive.app/Contents/SyncReporter.app/Contents/MacOS/SyncReporter"

# -------------------------------------
# Unload all the daemons and agents
# -------------------------------------
function od_service::unload_all_services() {
    od_logging::log "Unload all OneDrive services"
    if [ ${skip_autoupdater_daemon_install} != 0 ]; then
        od_service::unload_service ${AUTOUPDATER_DAEMON_BUNDLE_ID} ${AUTOUPDATER_DAEMON_PLIST_FILE}
    fi

    if [ ${skip_standalone_daemon_install} != 0 ]; then
        od_service::unload_service ${STANDALONEUPDATER_DAEMON_BUNDLE_ID} ${STANDALONEUPDATER_DAEMON_PLIST_FILE}
        od_service::unload_service ${STANDALONEUPDATER_AGENT_BUNDLE_ID} ${STANDALONEUPDATER_AGENT_PLIST_FILE}
    fi
}

# -------------------------------------
# Unload a specific service from both system and user level
# Arguments:
#   service_id: Service ID to unload
#   service_plist_file: Full path to the property list file for the service
# -------------------------------------
function od_service::unload_service() {
    local service_id=$1
    local service_plist_file=$2
    if sudo launchctl list ${service_id} &> /dev/null; then
        od_logging::log "Unload ${service_id} at ${service_plist_file} in sudo"
        sudo launchctl unload ${service_plist_file}
    fi

    if sudo -u "${LOGIN_USERNAME}" launchctl list ${service_id} &> /dev/null; then
        od_logging::log "Unload ${service_id} at ${service_plist_file}"
        sudo -u "${LOGIN_USERNAME}" launchctl unload ${service_plist_file}
    fi

    if [ -e ${service_plist_file} ]; then
        od_logging::log "Remove ${service_plist_file}"
        sudo rm -f ${service_plist_file}
    fi
}

# -------------------------------------
# Install and load AutoUpdater Daemon
# Returns:
#   launchctl load exit code
# -------------------------------------
function od_service::install_load_autoupdaterdaemon() {
    if [ ${skip_autoupdater_daemon_install} != 0 ]; then
        sudo ${PLISTBUDDY_COMMAND} -c "clear dict" \
            -c "Add :Label string \"${AUTOUPDATER_DAEMON_BUNDLE_ID}\"" \
            -c "Add :ProgramArguments array" \
            -c "Add :Program string \"${AUTOUPDATER_DAEMON_BINARY}\"" \
            -c "Add :MachServices dict" \
            -c "Add :MachServices:${AUTOUPDATER_DAEMON_BUNDLE_ID} bool YES" \
            -c "Add :StandardOutPath string ${AUTOUPDATER_DAEMON_LOG}" \
            -c "Add :StandardErrorPath string ${AUTOUPDATER_DAEMON_LOG}" \
            ${AUTOUPDATER_DAEMON_PLIST_FILE}

        od_logging::log "---------------------------------"
        od_logging::log "Loading ${AUTOUPDATER_DAEMON_BUNDLE_ID} in sudo"

        label=$(sudo defaults read ${AUTOUPDATER_DAEMON_PLIST_FILE} Label)
        od_logging::log "OneDriveUpdaterDaemon Label: ${label}"

        program_arguments=$(sudo defaults read ${AUTOUPDATER_DAEMON_PLIST_FILE} ProgramArguments)
        od_logging::log "OneDriveUpdaterDaemon ProgramArguments: ${program_arguments}"

        program=$(sudo defaults read ${AUTOUPDATER_DAEMON_PLIST_FILE} Program)
        private_program=$(od_logging::remove_private_info_app_path "$program")
        od_logging::log "OneDriveUpdaterDaemon Program: ${private_program}"

        mach_services=$(sudo defaults read ${AUTOUPDATER_DAEMON_PLIST_FILE} MachServices)
        od_logging::log "OneDriveUpdaterDaemon MachServices: ${mach_services}"

        standard_out_path=$(sudo defaults read ${AUTOUPDATER_DAEMON_PLIST_FILE} StandardOutPath)
        od_logging::log "OneDriveUpdaterDaemon StandardOutPath: ${standard_out_path}"

        standard_err_path=$(sudo defaults read ${AUTOUPDATER_DAEMON_PLIST_FILE} StandardErrorPath)
        od_logging::log "OneDriveUpdaterDaemon StandardErrorPath: ${standard_err_path}"

        if ! sudo launchctl load ${AUTOUPDATER_DAEMON_PLIST_FILE}; then
            od_logging::log "Loading the updater daemon failed with $?"
        fi

        od_logging::log "---------------------------------"
    fi
}

# -------------------------------------
# Install and load SyncReporter Agent
# Arguments:
#   delay_load_arg: whether to load the plist or not
# Returns:
#   launchctl load exit code
# -------------------------------------
function od_service::install_load_syncreporter() {
    # We want to run the reporter after update has a chance to complete. Given
    # this is installed/loaded as an update is happening, schedule the reporter
    # to run 1hr later with StartCalendarInterval.
    hours=$(date +%H)

    if [ $hours -eq 23 ]; then
        hours=0
    else
        hours=$((hours+1))
    fi

    minutes=$(date +%M)

    ${PLISTBUDDY_COMMAND} -c "clear dict" \
        -c "Add :Label string \"${SYNCREPORTER_AGENT_BUNDLE_ID}\"" \
        -c "Add :ProgramArguments array" \
        -c "Add :Program string \"${SYNCREPORTER_AGENT_BINARY}\"" \
        -c "Add :RunAtLoad bool NO" \
        -c "Add :StartCalendarInterval array" \
            -c "Add :StartCalendarInterval:0 dict" \
                -c "Add :StartCalendarInterval:0:Hour integer ${hours}" \
                -c "Add :StartCalendarInterval:0:Minute integer ${minutes}" \
        ${SYNCREPORTER_AGENT_PLIST_FILE}

    od_logging::log "---------------------------------"
    od_logging::log "Loading ${SYNCREPORTER_AGENT_PLIST_FILE} as current user"

    label=$(sudo defaults read ${SYNCREPORTER_AGENT_PLIST_FILE} Label)
    od_logging::log "SyncReporter Label: ${label}"

    program_arguments=$(sudo defaults read ${SYNCREPORTER_AGENT_PLIST_FILE} ProgramArguments)
    od_logging::log "SyncReporter ProgramArguments: ${program_arguments}"

    program=$(sudo defaults read ${SYNCREPORTER_AGENT_PLIST_FILE} Program)
    private_program=$(od_logging::remove_private_info_app_path "$program")
    od_logging::log "SyncReporter Program: ${private_program}"

    run_at_load=$(sudo defaults read ${SYNCREPORTER_AGENT_PLIST_FILE} RunAtLoad)
    od_logging::log "SyncReporter RunAtLoad: ${run_at_load}"

    start_interval=$(sudo defaults read ${SYNCREPORTER_AGENT_PLIST_FILE} StartInterval)
    od_logging::log "SyncReporter StartInterval: ${start_interval}"

    if [[ "${delayed_load_arg}" != "delay_load" ]]; then
        if [[ ! -z "${LOGIN_USERNAME}" && "${LOGIN_USERNAME}" != "root" ]]; then
            if ! sudo -u "${LOGIN_USERNAME}" launchctl load ${SYNCREPORTER_AGENT_PLIST_FILE}; then
                od_logging::log "Loading the SyncReporter Agent failed with $?"
            fi
        fi
    fi

    od_logging::log "---------------------------------"
}

# -------------------------------------
# Install and load Standalone Updater Agent
# Arguments:
#   delay_load_arg: whether to load the plist or not
# Returns:
#   launchctl load exit code
# -------------------------------------
function od_service::install_load_standaloneupdater() {
    if [ ${skip_standalone_daemon_install} != 0 ]; then
        local delayed_load_arg="${1}"
        ${PLISTBUDDY_COMMAND} -c "clear dict" \
            -c "Add :Label string \"${STANDALONEUPDATER_AGENT_BUNDLE_ID}\"" \
            -c "Add :ProgramArguments array" \
            -c "Add :Program string \"${STANDALONEUPDATER_AGENT_BINARY}\"" \
            -c "Add :RunAtLoad bool YES" \
            -c "Add :StartInterval integer 86400" \
            ${STANDALONEUPDATER_AGENT_PLIST_FILE}

        od_logging::log "---------------------------------"
        od_logging::log "Loading ${STANDALONEUPDATER_AGENT_PLIST_FILE} as current user"

        label=$(sudo defaults read ${STANDALONEUPDATER_AGENT_PLIST_FILE} Label)
        od_logging::log "OneDriveStandaloneUpdater Label: ${label}"

        program_arguments=$(sudo defaults read ${STANDALONEUPDATER_AGENT_PLIST_FILE} ProgramArguments)
        od_logging::log "OneDriveStandaloneUpdater ProgramArguments: ${program_arguments}"

        program=$(sudo defaults read ${STANDALONEUPDATER_AGENT_PLIST_FILE} Program)
        private_program=$(od_logging::remove_private_info_app_path "$program")
        od_logging::log "OneDriveStandaloneUpdater Program: ${private_program}"

        run_at_load=$(sudo defaults read ${STANDALONEUPDATER_AGENT_PLIST_FILE} RunAtLoad)
        od_logging::log "OneDriveStandaloneUpdater RunAtLoad: ${run_at_load}"

        start_interval=$(sudo defaults read ${STANDALONEUPDATER_AGENT_PLIST_FILE} StartInterval)
        od_logging::log "OneDriveStandaloneUpdater StartInterval: ${start_interval}"

        if [[ "${delayed_load_arg}" != "delay_load" ]]; then
            if [[ ! -z "${LOGIN_USERNAME}" && "${LOGIN_USERNAME}" != "root" ]]; then
                if ! sudo -u "${LOGIN_USERNAME}" launchctl load ${STANDALONEUPDATER_AGENT_PLIST_FILE}; then
                    od_logging::log "Loading the Standalone Updater Agent failed with $?"
                fi
            fi
        fi

        od_logging::log "---------------------------------"
    fi
}

# -------------------------------------
# Install and load Standalone Updater Daemon
# Returns:
#   launchctl load exit code
# -------------------------------------
function od_service::install_load_standaloneupdaterdaemon() {
    if [ ${skip_standalone_daemon_install} != 0 ]; then
        sudo ${PLISTBUDDY_COMMAND} -c "clear dict" \
            -c "Add :Label string \"${STANDALONEUPDATER_DAEMON_BUNDLE_ID}\"" \
            -c "Add :ProgramArguments array" \
            -c "Add :Program string \"${STANDALONEUPDATER_DAEMON_BINARY}\"" \
            -c "Add :MachServices dict" \
            -c "Add :MachServices:${STANDALONEUPDATER_DAEMON_BUNDLE_ID} bool YES" \
            -c "Add :StandardOutPath string ${STANDALONEUPDATER_DAEMON_LOG}" \
            -c "Add :StandardErrorPath string ${STANDALONEUPDATER_DAEMON_LOG}" \
            ${STANDALONEUPDATER_DAEMON_PLIST_FILE}

        od_logging::log "---------------------------------"
        od_logging::log "Loading ${STANDALONEUPDATER_DAEMON_PLIST_FILE} in sudo"

        label=$(sudo defaults read ${STANDALONEUPDATER_DAEMON_PLIST_FILE} Label)
        od_logging::log "OneDriveStandaloneUpdaterDaemon Label: ${label}"

        program_arguments=$(sudo defaults read ${STANDALONEUPDATER_DAEMON_PLIST_FILE} ProgramArguments)
        od_logging::log "OneDriveStandaloneUpdaterDaemon ProgramArguments: ${program_arguments}"

        program=$(sudo defaults read ${STANDALONEUPDATER_DAEMON_PLIST_FILE} Program)
        private_program=$(od_logging::remove_private_info_app_path "$program")
        od_logging::log "OneDriveStandaloneUpdaterDaemon Program: ${private_program}"

        mach_services=$(sudo defaults read ${STANDALONEUPDATER_DAEMON_PLIST_FILE} MachServices)
        od_logging::log "OneDriveStandaloneUpdaterDaemon MachServices: ${mach_services}"

        standard_out_path=$(sudo defaults read ${STANDALONEUPDATER_DAEMON_PLIST_FILE} StandardOutPath)
        od_logging::log "OneDriveStandaloneUpdaterDaemon StandardOutPath: ${standard_out_path}"

        standard_err_path=$(sudo defaults read ${STANDALONEUPDATER_DAEMON_PLIST_FILE} StandardErrorPath)
        od_logging::log "OneDriveStandaloneUpdaterDaemon StandardErrorPath: ${standard_err_path}"
        
        if ! sudo launchctl load ${STANDALONEUPDATER_DAEMON_PLIST_FILE}; then
            od_logging::log "Loading the Standalone Updater Daemon failed with $?"
        fi

        od_logging::log "---------------------------------"
    fi
}

# -------------------------------------
# Check whether a certain agent is installed
# Arguments:
#   agent_bundle_id: Bundle ID of the agent
# Returns:
#   0 (success) for true
#   1 (failure) for false
# -------------------------------------
function od_service::is_service_installed() {
    local agent_bundle_id=$1
    sudo -u "${LOGIN_USERNAME}" launchctl list ${agent_bundle_id} &> /dev/null
}

# -------------------------------------
# Check whether a certain daemon is installed
# Arguments:
#   daemon_bundle_id: Bundle ID of the daemon
# Returns:
#   0 (success) for true
#   1 (failure) for false
# -------------------------------------
function od_service::is_daemon_installed() {
    local daemon_bundle_id=$1
    sudo launchctl list ${daemon_bundle_id} &> /dev/null
}

# -------------------------------------
# Check whether AutoUpdater Daemon is installed
# Returns:
#   0 (success) for true
#   1 (failure) for false
# -------------------------------------
function od_service::is_autoupdaterdaemon_installed() {
    od_service::is_daemon_installed ${AUTOUPDATER_DAEMON_BUNDLE_ID}
    return $?
}

# -------------------------------------
# Check whether a Daemon is currently running
# Arguments:
#   daemon_bundle_id: Bundle ID of the daemon
# Returns:
#   0 (success) for true
#   1 (failure) for false
# -------------------------------------
function od_service::is_daemon_running() {
    local daemon_bundle_id=$1
    # when a process is running launchctl list puts pid at the beginning of the output
    local pid_re="^[0-9]+[[:blank:]]"
    local launchctl_output=$(sudo launchctl list | grep ${daemon_bundle_id})
    if [[ ${launchctl_output} =~ ${pid_re} ]]; then
        od_logging::log "${daemon_bundle_id} is running"
        return 0
    else
        od_logging::log "${daemon_bundle_id} is not running"
        return 1
    fi
}

# Variables indicating whether daemon install should be skipped
# Skip installations when the daemon is running because it may indicate possible update
od_service::is_daemon_running ${AUTOUPDATER_DAEMON_BUNDLE_ID}
skip_autoupdater_daemon_install=$?
od_service::is_daemon_running ${STANDALONEUPDATER_DAEMON_BUNDLE_ID}
skip_standalone_daemon_install=$?

# -------------------------------------
# Check whether any Daemon is currently running
# Returns:
#   0 (success) when a daemon is found to be running
#   1 (failure) otherwise
# -------------------------------------
function od_service::is_any_daemon_running() {
    [ ${skip_autoupdater_daemon_install} == 0 ] || [ ${skip_standalone_daemon_install} == 0 ]
    return $?
}
