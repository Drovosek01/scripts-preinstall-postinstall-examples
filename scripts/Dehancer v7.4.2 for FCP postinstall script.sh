#!/usr/bin/env bash

#
# User installation
# DEST_DIR="$HOME/Movies/Motion Templates.localized/Effects.localized/Film Emulation"
#

#
# System installation
#
DEST_DIR="/Library/Application Support/Final Cut Pro/Templates.localized/Effects.localized/Film Emulation"

PLUGIN_NAME="Dehancer Pro v7"
PLUGIN_ID="com.dehancer.film_pro_fcp.v7"
DEHANCER_INSTALLER_APP_TARGET="Dehancer Pro FCP v7"
DEHANCER_INSTALLER_APP_TARGET_PLUGINKIT="DehancerProFCP_XPC.pluginkit"

PLUGINKIT_APP_PATH="/Library/Plug-Ins/FxPlug/${DEHANCER_INSTALLER_APP_TARGET}.app"
PLUGINKIT_PATH="${PLUGINKIT_APP_PATH}/Contents/PlugIns/${DEHANCER_INSTALLER_APP_TARGET_PLUGINKIT}"

TMP_DIR="/tmp/${PLUGIN_ID}"

BACKUP_DIR="${TMP_DIR}/${PLUGIN_NAME}.old"

INSTALL_LOG_FILE="${TMP_DIR}/install.log"

reset_logs() {
  echo "Logs generated at: $(LANG=en_US date '+%Y-%m-%d %H:%M:%S')"> "${INSTALL_LOG_FILE}"
}

log() {
  echo "$1" >> "${INSTALL_LOG_FILE}"
}

fail_on_error() {
  retval=$1
  comment="$2"
  if [[ $retval -gt 0 ]]; then
    log "$comment. Error code: $retval"
    exit 1
  fi
}

reset_logs

sudo mkdir -p "$DEST_DIR"
fail_on_error $? "Could not create directory '${DEST_DIR}'"

backup_done=""
if [[ -d "$DEST_DIR/$PLUGIN_NAME" ]]; then
  log "Found previous version of the motion template at '$DEST_DIR/$PLUGIN_NAME'"

  sudo mv "$DEST_DIR/$PLUGIN_NAME" "${BACKUP_DIR}"
  fail_on_error $? "Could not backup the previous motion template: ${retval}"

  backup_done=true
fi

sudo mv "${TMP_DIR}/${PLUGIN_NAME}" "$DEST_DIR"
fail_on_error $? "Template installation failed"

if [[ $backup_done ]]; then
  sudo rm -r "${BACKUP_DIR}"
fi

log "PLUGIN: '$DEHANCER_INSTALLER_APP_TARGET'"
log "PLUGINKIT: '$PLUGINKIT_PATH'"

sudo /usr/bin/pluginkit -a "$PLUGINKIT_PATH"
fail_on_error $? "Could not update pluginkit $PLUGINKIT_PATH"

allps=$(/usr/bin/pluginkit -mADv -p FxPlug | grep "${DEHANCER_INSTALLER_APP_TARGET}")

if [[ -z "$allps" ]]; then
  log "${DEHANCER_INSTALLER_APP_TARGET} is not registered as ${PLUGINKIT_PATH}. Try to open ${PLUGINKIT_APP_PATH}"
  /usr/bin/open -W "${PLUGINKIT_APP_PATH}"
  sudo /usr/bin/pluginkit -a "$PLUGINKIT_PATH"
else
  log "${DEHANCER_INSTALLER_APP_TARGET} is registered in ${PLUGINKIT_PATH}"
fi
