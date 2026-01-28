#!/bin/bash

# **********************************************************
#             Copyright 2009-2012 Esko Software bvba
#                     All rights reserved
#  All programs and data are property of Esko Software bvba
# **********************************************************
#
# Pre Installation Procedure

# Helper function
function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

# Full folder specification where this file is 
where=${0%/*}
pushd "${where}" >/dev/null ; where=$(pwd) ; popd >/dev/null

status=1

# Check if existing version is higher, if so, do nothing
installedversion=$(/usr/sbin/pkgutil --pkg-info-plist ${INSTALL_PKG_SESSION_ID} 2>/dev/null | /usr/bin/plutil -extract pkg-version xml1 - -o - | /usr/bin/xmllint -xpath 'string(//plist/string)' -)
if [ $? -eq 0 ]
then
    if [ $(version ${installedversion}) -gt $(version 22.07) ]; then
        echo "Installed version: " ${installedversion} " > 22.07 : will not proceed executing here."
        # An exit code other than zero aborts the installation.
        exit 0
    fi
fi

sleep 2
dattim=$(date "+%Y%m%d%H%M%S")

# Log file
LOGFIL="${HOME}/Library/Logs/EskoLicenseServer_22.07_PreInstall.log"

echo "Esko License Server Pre_Installation" >"${LOGFIL}"
date "+%Y-%m-%d %H:%M:%S" >>"${LOGFIL}"

echo "" >>"${LOGFIL}"
"${where}/stop_lm" "${LOGFIL}"
if [ $? -ne 0 ]
then
  status=1
else
  status=0
fi

if [ $status -ne 0 ]
then
  echo "Finished with errors."
  exit 1
else
  echo "Finished."
  exit 0
fi
