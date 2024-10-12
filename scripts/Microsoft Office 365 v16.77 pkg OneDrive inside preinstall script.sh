#!/bin/bash

################################################
# Removes the Updater Daemon in preparation for
# installation and stores the pre-install app 
# bundle ID for telemetry purposes. 
# 
# Sends one telemetry point so we can compare 
# event counts from preinstall vs. postinstall
# to detect issues in the installation itself.
#################################################
base_dir="${PWD}"
source "${base_dir}/od_logging"
source "${base_dir}/od_service"
source "${base_dir}/od_migration"

# Returns true if there is no existing OneDrive install, or if there is, 
# the existing OneDrive is lower than this version being installed. Otherwise returns false.
function is_safe_to_install_pkg() {
  local existing_version=$(od_migration::app_version_at_dstroot)

  if [[ "${existing_version}" == "DoesNotExist" ]]; then
    # Return true, there is no OneDrive installed
    return 0
  fi

  local current_version=$(cat "${base_dir}/FullAppVersion")
  od_logging::log "Checking if installed version ${existing_version} is lower than or equal to version being installed ${current_version}"

  # Split version strings into arrays
  IFS='.' read -ra v1 <<< "$current_version"
  IFS='.' read -ra v2 <<< "$existing_version"

  # Compare version strings
  for i in "${!v1[@]}"; do
    # Prepend 10# to tell bash to treat the numbers as base 10 (decimal), not octal due to leading 0s
    let v1Dec=$((10#${v1[$i]}))
    let v2Dec=$((10#${v2[$i]}))

    if [[ ${v1Dec} -gt ${v2Dec} ]]; then
      return 0
    elif [[ ${v1Dec} -lt ${v2Dec} ]]; then
      return 1
    fi
  done

  # If all parts are equal, return true. Install proceeds when installing same version.
  return 0
}

od_logging::log "======================================="

PLIST_BUDDY_COMMAND="/usr/libexec/PlistBuddy ${DSTROOT}/OneDrive.app/Contents/info.plist -c"
STORE_BUNDLE_ID="com.microsoft.OneDrive-mac"

# Get the pre-install app bundle ID
app_bundle_id=$(od_migration::app_id_at_dstroot)

# parse out version from package
app_version=$(od_migration::package_app_version)

# Get the full version number of the existing app before installation - only if it's the store app
full_version="Non-Store App"
if [[ "${app_bundle_id}" == "${STORE_BUNDLE_ID}" ]]; then
  full_version=$(od_migration::app_version_at_dstroot)
fi

od_logging::log "AppBundleId:${app_bundle_id}"
od_logging::log "AppVersion:${app_version}"
od_logging::log "FullStoreVersion:$full_version"
echo "${app_bundle_id}" > "${TMPDIR}\PreInstallAppBundleId"
echo "${full_version}" > "${TMPDIR}\FullStoreVersion"

# Check if this version is lower than current installed version.
# If it is, we don't want to start any pre-install steps and just bail out.
is_safe_to_install_pkg
should_continue_preinstall=$?
if [ ${should_continue_preinstall} != 0 ]; then
  od_logging::log "Installed version is higher than version being installed, skipping preinstall steps."
  echo "A higher version of OneDrive is already installed on this machine. Skipping pre-install steps."
  exit 0
fi

od_service::unload_all_services

# OneDrive.app content needs to be owned by root:wheel to prevent EoP attacks.
# If a user has created content under the OneDrive.app path and the pkg installer runs,
# it keeps existing permissions when replacing it. This can result in a Daemon owned
# by a regular user, which an attacker can then replace with a malicious binary
# which we then launch as root. To solve this, delete any files/folders that are not owned 
# by root:wheel before installer runs. 
# If the file/folder is a symlink, the 'rm' command only deletes the symlink, not the target. 
# This behavior is desirable as the install will reinstate them.
found_non_root_file=0
delete_failed=0

if [[ "${app_bundle_id}" != "${STORE_BUNDLE_ID}" ]]; then
  while read x; do
    found_non_root_file=1
    if ! sudo rm -rf "${x}"; then
      delete_result=$?
      od_logging::log "Failed to delete non-root owned file/folder with: ${delete_result}"
      echo "Failed to delete non-root owned file folder with: ${delete_result}. Cannot proceed with install as it is unsafe to replace files not owned by root:wheel."
      delete_failed=1
      break;
    else
      od_logging::log "Removed non-root owned file/folder"
    fi
  done < <(find ${DSTROOT}/OneDrive.app ! -group wheel -or ! -user root)
fi

nohup ./OneDrivePkgTelemetry -command "${SCRIPT_NAME}" \
    -app_bundle_id "${app_bundle_id}" \
    -app_version "${app_version}" \
    -autoupdater_daemon_install_skipped "${skip_autoupdater_daemon_install}" \
    -standaloneupdater_daemon_install_skipped "${skip_standalone_daemon_install}" \
    -non_root_file_found "${found_non_root_file}" \
    -delete_failed "${delete_failed}" \
    -previous_app_bundle_id "${app_bundle_id}" </dev/null >/dev/null 2>&1 &

# Fail the install if we found a file not owned by root:wheel and we failed to install it.
# In this situation it is not safe to continue the install.
if [ $delete_failed -eq 1 ]; then
  exit 1
fi