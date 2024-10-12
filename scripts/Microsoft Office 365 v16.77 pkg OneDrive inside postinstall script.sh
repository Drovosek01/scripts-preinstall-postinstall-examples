#!/bin/bash

delay_load_arg="${1}"
base_dir="${PWD}"
source "${base_dir}/od_logging"
source "${base_dir}/od_service"
source "${base_dir}/od_migration"

ONEDRIVE_BUNDLE_ID="com.microsoft.OneDrive"
TEST_PKG_DIR="Test/SecondaryBinary"

# allow delayed load of Standalone agent
delayed_load_arg="${1}"
if [ -z "${LOGIN_USERNAME}" ]; then
    LOGIN_USERNAME=${USER}
    if [ "${LOGIN_USERNAME}" == "root" ] || [ -z "${LOGIN_USERNAME}" ]; then
        LOGIN_USERNAME=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)
    fi
fi

function od_replace_store() {
    # Relocate the installed application
    od_logging::log "Waiting until the application ${app_version} is fully installed"
    installed_location=
    retry_count=0

    # Skip replacing the OneDrive.app if the current app is non-signed and this is not a migration test run
    codesign --display -r- ${DSTROOT}/OneDrive.app 2>&1 | grep "certificate leaf = H\"" > /dev/null
    if [[ $? -eq 0 ]] && [[ ! ${PACKAGE_PATH} =~ .*${TEST_PKG_DIR}.* ]]; then
        od_logging::log "Non-signed app exists, skip replacement"
        installed_location="${DSTROOT}/OneDrive.app"
    fi

    if [[ -z "${installed_location}" ]]; then
        app_count=$(find "${DSTROOT}" -maxdepth 2 -name OneDrive.app | wc -l)
        if [[ ${app_count} -gt 1 ]]; then
            od_logging::log "Multiple OneDrive clients are found; locate one installed by the installer"
            while [[ -z "${installed_location}" && ${retry_count} -lt 120 ]]; do
                od_logging::log "Trying to identify the installed app"
                sleep 1
                installed_location=$(mdfind "kMDItemCFBundleIdentifier == ${ONEDRIVE_BUNDLE_ID} && kMDItemVersion == ${app_version}" | grep "${DSTROOT}" | head -n 1)
                ((retry_count++))
            done
            od_logging::log "Found OneDrive client"
        else
            od_logging::log "OneDrive client found. Check its version to see whether it is the target version for this installer."
            version_string=$(defaults read "${DSTROOT}/OneDrive.app/Contents/Info.plist" CFBundleShortVersionString)
            if [[ "${version_string}" == "${app_version}" ]]; then
                
                od_logging::log "Current version exists."
                installed_location="${DSTROOT}/OneDrive.app"
            else
                od_logging::log "Current version has not been installed. A higher version client is already installed."
            fi
        fi
    fi

    if [[ ! -z "${installed_location}" ]]; then
        if [ ${installed_location} == "/Applications/OneDrive.app" ]; then
            od_logging::log "Installed Location: ${installed_location}"
        else
            od_logging::log "Installed Location is custom and private."
        fi
        
        if [ ${DSTROOT} == "/Applications" ]; then
            od_logging::log "Designated Location: ${DSTROOT}/OneDrive.app"
        else
            od_logging::log "Designated Location is custom and private."
        fi

        if [[ "${installed_location}" != "${DSTROOT}/OneDrive.app" ]]; then
            local user_home=`eval "echo ~$1"`

            echo Replacing App
            # Remove any existing app in the Trash since this blocks moving
            sudo rm -rf "$user_home/.Trash/OneDrive.app"
            sudo mv "${DSTROOT}/OneDrive.app" "$user_home/.Trash"

            # Run open command on non-existent app to let MacOS register that the old version has been removed.
            # This is because of a caching issue where MacOS uses the old bundle ID from the replaced app for the new app.
            open "${DSTROOT}/OneDrive.app" > /dev/null 2>&1
            mkdir -p "${DSTROOT}"
            sudo mv -f "${installed_location}" "${DSTROOT}/OneDrive.app"
            # Remove if installed location is empty after move
            installed_dir=$(dirname ${installed_location})
            num_nonhiden_files=`find ${installed_dir} -mindepth 1 -maxdepth 1 -not -name ".*" | wc -l | xargs`
            if [ ${num_nonhiden_files} -eq 0 ]; then
                sudo rm -rf ${installed_dir}
            fi
        fi
    else
        od_logging::log "OneDrive client with the target version could not be located."
    fi
}

# parse out version from package
app_version=$(od_migration::package_app_version)

# Any daemon running may indicate that OneDrive is updating
# Do not perform migration in that case
od_service::is_any_daemon_running
skip_store_migration=$?

if [ ${skip_store_migration} != 0 ]; then
    if [[ "${PACKAGE_PATH}" == *.pkg ]]; then
        od_replace_store
    else
        od_logging::log "PACKAGE_PATH is in an unexpected location."
    fi
fi

# Unload the services if registered, and remove the old launchd property list file
od_service::unload_all_services

# Install and load all the services
od_service::install_load_autoupdaterdaemon
od_service::install_load_standaloneupdater "${delayed_load_arg}"
od_service::install_load_standaloneupdaterdaemon
od_service::install_load_syncreporter

create_launch_agent_attempts=0
create_launch_agent_failures=0
store_version_write_attempts=0
store_version_write_failures=0
if [ ${skip_store_migration} != 0 ]; then
    # Set OneDrive to open at login by creating a plist file under ~/Library/LaunchAgents for each user
    # only if the user is going to be migrated to Standalone from Store once OneDrive launches.
    # The existence of the plist file creates a launchd entry that will be disabled upon OneDrive launch
    # in order to revert to using the user's preference
    user_accounts=$(dscl . list /Users | grep -v '^_\|root\|daemon\|nobody')
    while read -r user; do
        if od_migration::will_be_store_migrated "${user}"; then
            create_launch_agent_attempts=$((create_launch_agent_attempts+1))
            od_migration::create_launch_agent "${user}"
            if [ $? -ne 0 ]; then
                create_launch_agent_failures=$((create_launch_agent_failures+1))
                od_logging::log "Failed to create the launch agent file for user"
            fi
        fi

        # If we got a Store version from preinstall, write it to the CurrentVersion value in Group Containers plist for Store app
        full_store_version=$(cat "${TMPDIR}\FullStoreVersion")
        if [[ $? -eq 0 && "${full_store_version}" != "Non-Store App" ]]; then
            store_version_write_attempts=$((store_version_write_attempts+1));
            od_migration::write_store_version "${user}" "${full_store_version}"

            if [[ $? -ne 0 ]]; then
                store_version_write_failures=$((store_version_write_failures+1));
                od_logging::log "Failed to write Store version to plist for user"
            fi
        fi
    done <<< "$user_accounts"
fi

# Check if the service is registered properly
od_service::is_daemon_installed ${AUTOUPDATER_DAEMON_BUNDLE_ID}
autoupdater_daemon_installed=$?
od_service::is_daemon_installed ${STANDALONEUPDATER_DAEMON_BUNDLE_ID}
standaloneupdater_daemon_installed=$?
od_service::is_service_installed ${STANDALONEUPDATER_AGENT_BUNDLE_ID}
standaloneupdater_agent_installed=$?

app_bundle_id=$(od_migration::app_id_at_dstroot)

# Retrieve PreInstall App Bundle ID
previous_app_bundle_id=$(cat "${TMPDIR}\PreInstallAppBundleId")

od_logging::log "AutoUpdaterDaemonInstalled:${autoupdater_daemon_installed}"
od_logging::log "StandaloneUpdaterDaemonInstalled:${standaloneupdater_daemon_installed}"
od_logging::log "StandaloneUpdaterAgentInstalled:${standaloneupdater_agent_installed}"
od_logging::log "AutoUpdaterDaemonInstallSkipped:${skip_autoupdater_daemon_install}"
od_logging::log "StandaloneUpdaterDaemonInstallSkipped:${skip_standalone_daemon_install}"
od_logging::log "PreviousAppBundleId:${previous_app_bundle_id}"
od_logging::log "AppBundleId:${app_bundle_id}"
od_logging::log "AppVersion:${app_version}"
od_logging::log "UpdateTier:${tier_setting}"
od_logging::log "LaunchAgentAttempts:${create_launch_agent_attempts}"
od_logging::log "LaunchAgentFailures:${create_launch_agent_failures}"
od_logging::log "StoreVersionWriteAttempts:${store_version_write_attempts}"
od_logging::log "StoreVersionWriteFailures:${store_version_write_failures}"

# Give read and execute permission to log directory so OneDrive can see contents
sudo chmod a+rx /Library/Logs/Microsoft/OneDrive
# Give read permission to each file within log directory so OneDrive can read them
sudo find /Library/Logs/Microsoft/OneDrive -type f -exec chmod a+r {} \;

nohup ./OneDrivePkgTelemetry -command "${SCRIPT_NAME}" \
    -app_bundle_id "${app_bundle_id}" \
    -autoupdater_daemon_installed "${autoupdater_daemon_installed}" \
    -standaloneupdater_daemon_installed "${standaloneupdater_daemon_installed}" \
    -standaloneupdater_agent_installed "${standaloneupdater_agent_installed}" \
    -autoupdater_daemon_install_skipped "${skip_autoupdater_daemon_install}" \
    -standaloneupdater_daemon_install_skipped "${skip_standalone_daemon_install}" \
    -app_version "${app_version}" \
    -previous_app_bundle_id "${previous_app_bundle_id}" \
    -attempted_launch_agents "${create_launch_agent_attempts}" \
    -failed_launch_agents "${create_launch_agent_failures}" \
    -store_version_write_attempts "${store_version_write_attempts}" \
    -store_version_write_failures "${store_version_write_failures}" </dev/null >/dev/null 2>&1 &
