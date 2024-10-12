#!/bin/sh
#
#  Preupgrade script for MacOS X installer
#
#  Environment variables:
#
#    $SCRIPT_NAME .... The name of this script
#    PACKAGE_PATH .... The pathname for the installer package (same as $1)
#    INSTALLER_TEMP .. Temp directory for installation
#    $RECEIPT_PATH ... 
#
PKGPATH="$1"
DEST_DIR="$2"
VOLUME="$3"
ROOT_DIR="$4"

log () {
  if [ -n "$SCHRODINGER_INSTALLER_DEBUG" ]; then
    echo $* >> ~/installation.log
  fi
}

log $0 "$@"

