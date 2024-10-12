#!/bin/bash

################################################
# Functions to migrate OneDrive Store to Standalone through Installer
#################################################

# Prevent double inclusion
[[ ${OD_MIGRATION_INCL:-} -eq 1 ]] && return || readonly OD_MIGRATION_INCL=1

base_dir=${base_dir:-"${PWD}"}
source "${base_dir}/od_logging"

APP_INSTALL_PATH="${DSTROOT}/OneDrive.app"
PLISTBUDDY_COMMAND="/usr/libexec/PlistBuddy"
READ_INFOPLIST_COMMAND="/usr/libexec/PlistBuddy ${APP_INSTALL_PATH}/Contents/info.plist -c"
STORE_BUNDLE_ID="com.microsoft.OneDrive-mac"

# LaunchAgent related
LAUNCHAGENTS_FOLDER="/Library/LaunchAgents"
LAUNCH_AGENT_NAME="com.microsoft.OneDriveMigrationLauncher"
OPEN_AT_LOGIN_PLIST_FILE="${LAUNCH_AGENT_NAME}.plist"
LAUNCH_AGENT_XML=$(cat << EOT
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>
<string>${LAUNCH_AGENT_NAME}</string>
<key>Program</key>
<string>${DSTROOT}/OneDrive.app/Contents/MacOS/OneDrive</string>
<key>RunAtLoad</key>
<true/>
</dict>
</plist>
EOT)


STORE_GROUP_DEFAULTS_PLIST_SUBPATH=Library/Group\ Containers/UBF8T346G9.OneDriveSyncClientSuite/Library/Preferences/UBF8T346G9.OneDriveSyncClientSuite.plist
STANDALONE_GROUP_DEFAULTS_PLIST_SUBPATH=Library/Group\ Containers/UBF8T346G9.OneDriveStandaloneSuite/Library/Preferences/UBF8T346G9.OneDriveStandaloneSuite.plist
BREADCRUMB_FILE_SUBPATH=Library/Application\ Support/OneDrive/MASMigrated

# -------------------------------------
# Echos App version from the package
# Returns:
#   Application version (AA.BBB.CCCC.DDDD)
# -------------------------------------
function od_migration::package_app_version() {
    # parse out version from package
    cat "${base_dir}/AppVersion"
}

FAIL_INVALID_FORMAT_VERSION="InvalidVersionFormat"
FAIL_APP_NOT_EXIST="DoesNotExist"
# -------------------------------------
# Echos Full Version of the currently installed OneDrive at DSTROOT
# Returns:
#   Application version (AA.BBB.CCCC.DDDD)
#   When the version string is not in a valid format: returns $FAIL_INVALID_FORMAT_VERSION
# -------------------------------------
function od_migration::app_version_at_dstroot() {
    # Full version number is a combination of CFBundleVersion and CFBundleShortVersionString
    # CFBundleVersion = <Concatenated Product Major and Product Minor>.<Build Major>.<Build Minor>
    # CFBundleShortVersionString = <Product Major>.<Product Minor>.<Build Major>
    # Full version string = <Product Major>.<Product Minor>.<Build Major>.<Build Minor>
    # e.g.
    # CFBundleVersion: 18044.0301.0005
    # CFBundleShortVersionString: 18.044.0301
    # Resulting full_version: 18.044.0301.0005
    if [ -f ${APP_INSTALL_PATH}/Contents/info.plist ]; then
        local bundle_version=$(${READ_INFOPLIST_COMMAND} "print:CFBundleVersion")
        local short_version=$(${READ_INFOPLIST_COMMAND} "print:CFBundleShortVersionString")

        # Debug builds can have the username appended after a space, so remove it here if it exists
        bundle_version=$(echo ${bundle_version} | cut -f 1 -d ' ')

        # Take the Build Minor from the CFBundleVersion to append to CFBundleShortVersionString
        if [[ $bundle_version =~ \.([0-9]+)$ ]]; then
            bundle_version=${BASH_REMATCH[1]}
            full_version="$short_version.$bundle_version"
        else
            od_logging::log "CFBundleVersion not in expected format: ${bundle_version}"
            full_version=${FAIL_INVALID_FORMAT_VERSION}
        fi
        echo ${full_version}
    else
        echo ${FAIL_APP_NOT_EXIST}
    fi
}

FAIL_TO_GET_BUNDLEID="FailToGetBundleId"
# -------------------------------------
# Echos App bundle id of currently installed OneDrive at DSTROOT
# Arguments:
#   od_log "$@"
# Returns:
#   bundle id of installed app
#   when the app exists, but fails to read the id: returns $FAIL_TO_GET_BUNDLEID
#   when the app doesn't exist: returns $FAIL_APP_NOT_EXIST
# -------------------------------------
function od_migration::app_id_at_dstroot() {
    local app_bundle_id=${FAIL_APP_NOT_EXIST}

    test -d "${APP_INSTALL_PATH}"
    if [ $? -eq 0 ]; then
        app_bundle_id=$(${READ_INFOPLIST_COMMAND} "print:CFBundleIdentifier")
        if [ $? -ne 0 ]; then
            app_bundle_id=${FAIL_TO_GET_BUNDLEID}
        fi
    fi

    private_app_path=$(od_logging::remove_private_info_app_path "$APP_INSTALL_PATH")
    od_logging::log "${private_app_path} bundle id: ${app_bundle_id}"
    echo ${app_bundle_id}
}

################################################
# If the given plist file path exists, checks
# whether it contains account information
# with the three pre-requisite keys for migration.
# Arguments:
#   Path to plist file to check
# Returns:
#   0 (success) for true
#   1 (failure) for false
#################################################
function od_migration::meets_pre_reqs() {
    local plist_filepath=$1
    if [ -f "${plist_filepath}" ]; then
        # Check given plist file for AccountInfos
        local matches=($(${PLISTBUDDY_COMMAND} -c Print "${plist_filepath}" | grep -o -a "AccountInfo_[a-zA-Z0-9]*"))
        if [[ ! -z $matches ]]; then
            # Loop through accounts and see if any are
            # actually configured with the pre-requisites
            for i in ${matches[@]}; do
                ${PLISTBUDDY_COMMAND} -c "Print :$i:UserFolder" "${plist_filepath}" &> /dev/null
                local hasUserFolder=$?
                ${PLISTBUDDY_COMMAND} -c "Print :$i:ScopeIdToMountPointPathCache" "${plist_filepath}" &> /dev/null
                local hasScopeIdMountPoint=$?
                ${PLISTBUDDY_COMMAND} -c "Print :$i:HasShownFirstRunExperience" "${plist_filepath}" &> /dev/null
                local hasHasShownFRE=$?
                if [ $hasUserFolder -eq 0 ] && [ $hasScopeIdMountPoint -eq 0 ] && [ $hasHasShownFRE -eq 0 ]; then
                    # If pre-requisites were found, return success
                    od_logging::log "Migration pre-requisites are found."
                    return 0
                fi
            done
        fi
    fi

    od_logging::log "Migration pre-requisites are not found."
    # Return failure code if no account info found
    return 1
}

################################################
# If the given plist file path exists, checks
# whether it contains account information.
# Arguments:
#   Path to plist file to check
# Returns:
#   0 (success) for true
#   1 (failure) for false
#################################################
function od_migration::has_account_info() {
    local plist_filepath=$1
    if [ -f "${plist_filepath}" ]; then
        # Check given plist file for AccountInfos
        local matches=($(${PLISTBUDDY_COMMAND} -c Print "${plist_filepath}" | grep -o -a "AccountInfo_[a-zA-Z0-9]*"))
        if [[ ! -z $matches ]]; then
            # Loop through accounts and see if any are
            # actually configured with HasShownFirstRunExperience
            for i in ${matches[@]}; do
                od_logging::log "Getting HasShownFRE value from ${i}"
                ${PLISTBUDDY_COMMAND} -c "Print :$i:HasShownFirstRunExperience" "${plist_filepath}" &> /dev/null
                if [ $? -eq 0 ]; then
                    # If HasShownFirstRunExperience was found, return success
                    od_logging::log "Migration found an active account info."
                    return 0
                fi
            done
        fi
    fi

    od_logging::log "Migration did not find an active account info."
    # Return failure code if no account info found
    return 1
}

################################################
# Determines whether the user will be migrated
# from the Store to Standalone version of
# OneDrive once OneDrive launches based on
# existence of account information and
# breadcrumb files.
# Arguments:
#   Username for user who will be potentially
#   migrated
# Returns:
#   0 (success) for true
#   1 (failure) for false
#################################################
function od_migration::will_be_store_migrated() {
    local user_home=$(eval "echo ~$1")

    # First check if breadcrumb file exists - if it does,
    # this means we've already attempted migration for
    # Store --> Standalone so we won't be attempting again.
    if [ -f "${user_home}/${BREADCRUMB_FILE_SUBPATH}" ]; then
        return 1
    fi

    # Next, check if we already have Standalone account info.
    # If we do, we won't attempt to migrate to standalone as
    # it would overwrite the existing settings.
    od_migration::has_account_info "${user_home}/${STANDALONE_GROUP_DEFAULTS_PLIST_SUBPATH}"
    local has_standalone_account_info=$?

    # Finally check if the Store settings meet the migration pre-requisites
    od_migration::meets_pre_reqs "${user_home}/${STORE_GROUP_DEFAULTS_PLIST_SUBPATH}"
    local store_meets_pre_reqs=$?

    if [ $store_meets_pre_reqs -eq 0 ] && [ $has_standalone_account_info -eq 1 ]; then
        return 0
    else
        return 1
    fi
}

################################################
# Create LaunchAgent property list file for migration
# Arguments:
#   Username for user who will be potentially migrated
# Returns:
#   0 (success) for true
#   1 (failure) for false
#################################################
function od_migration::create_launch_agent() {
    od_logging::log "Creating migration LaunchAgent for user"

    local user_home=$(eval "echo ~$1")
    mkdir "${user_home}${LAUNCHAGENTS_FOLDER}" &> /dev/null
    echo "${LAUNCH_AGENT_XML}" > "${user_home}${LAUNCHAGENTS_FOLDER}/${OPEN_AT_LOGIN_PLIST_FILE}"
    [ ! -f "${user_home}${LAUNCHAGENTS_FOLDER}/${OPEN_AT_LOGIN_PLIST_FILE}" ]
    return $?
}

################################################
# Write the version under store group defaults settings
# Arguments:
#   Username for user who will be potentially migrated
# Returns:
#   PlistBuddy exit code
#################################################
function od_migration::write_store_version() {
    od_logging::log "Writing Store version to plist as CurrentVersion for user"

    local user_home=$(eval "echo ~$1")
    local store_version=$2
    local store_group_defaults_plist="${user_home}/${STORE_GROUP_DEFAULTS_PLIST_SUBPATH}"
    # Overwirte existing CurrentVersion in the Group Containers plist
    /usr/libexec/PlistBuddy -c "Delete :CurrentVersion" \
    -c "Add CurrentVersion string '$full_store_version'" "${store_group_defaults_plist}"

    # return whether CurrentVersion exists
    /usr/libexec/PlistBuddy -c "Print :CurrentVersion" "${store_group_defaults_plist}" &> /dev/null
}
