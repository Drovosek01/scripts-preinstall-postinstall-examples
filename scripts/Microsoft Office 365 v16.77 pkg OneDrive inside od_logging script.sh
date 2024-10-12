#!/bin/bash

################################################
# Contains utility functions for logging
#################################################

[[ ${OD_LOGGING_INCL:-} -eq 1 ]] && return || readonly OD_LOGGING_INCL=1

# Logging related
LOG_DIRECTORY="/Library/Logs/Microsoft/OneDrive"
LOG_FILEPATH="${LOG_DIRECTORY}/PkgInstaller.log"

# Ensure a log directory exists before logging
mkdir -p ${LOG_DIRECTORY}
chmod -R +r ${LOG_DIRECTORY}

SENSITIVE_STRINGS=(
    "$HOME"
    "$USER"
)

SENSITIVE_STRINGS_REPLACEMENTS=(
    "%HOME%"
    "%USERNAME%"
)

# -------------------------------------
# Logs a message to OneDrive installer log
# Usage:
#   od_log "$@"
# -------------------------------------
function od_logging::log() {
    local message=${@:-"please add a message"}
    local timestamp="$(date +%Y-%m-%d' '%T)"
    echo "$timestamp [OneDrive-${SCRIPT_NAME}] ${message}" >> "${LOG_FILEPATH}"
}

function od_logging::remove_private_info() {
    local text=$1
    local obfuscated_text=$1

    len=${#SENSITIVE_STRINGS[@]}

    found_sensitive_path=0

    for (( i=0; i<$len; i++ ))
    do
        if grep -q -i "${SENSITIVE_STRINGS[$i]}" <<< "$obfuscated_text"; then 
            found_sensitive_path=1
            obfuscated_text=`echo $obfuscated_text | sed "s#${SENSITIVE_STRINGS[$i]}#${SENSITIVE_STRINGS_REPLACEMENTS[$i]}#gi"`
        fi
    done

    if [ $found_sensitive_path -eq 0 ]; then
        obfuscated_text="%PRIVATE%"
    fi

    echo $obfuscated_text
}

function od_logging::remove_private_info_app_path() {
    local text=$1
    local obfuscated_text=$1

    if [[ $text == /Applications/OneDrive.app* ]]; then
        obfuscated_text=$text
    else
        obfuscated_text="%PRIVATE%"
    fi

    echo $obfuscated_text
}