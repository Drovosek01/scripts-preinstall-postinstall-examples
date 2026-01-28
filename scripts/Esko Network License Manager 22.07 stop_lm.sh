#!/bin/bash

# **********************************************************
#             Copyright 2009-2012 Esko Software bvba
#                     All rights reserved
#  All programs and data are property of Esko Software bvba
# **********************************************************
#
# Stop License Manager service
#  P1 = Log file

# Full folder specification where this file is 
where=${0%/*}
pushd "${where}" >/dev/null ; where=$(pwd) ; popd >/dev/null

# Parameters
LOGFIL="$1"

status=1

# Locations

LM_LIC_DIR="/Library/Application Support/FLEXnet Publisher/Manager/License File"
LM_LIC_FIL="${LM_LIC_DIR}/licenses.dat"

echo "Looking for a running FLEXnet License Manager service ..." >>"${LOGFIL}"
task=$(ps auxww | grep ".*/lmgrd" | grep -v grep)
if [ "${task}" = "" ]
then
  echo ""
  echo "There is no FLEXnet License Manager (lmgrd) running." >>"${LOGFIL}" 2>&1
else
  echo ""
  echo "A running FLEXnet License Manager (lmgrd) was found:" >>"${LOGFIL}" 2>&1
  folder=$(ps -Aww -o command | grep ".*/lmgrd" | grep -v grep)
  folder=$(echo ${folder} | sed "s/\/lmgrd.*//")
  echo "${folder}/lmgrd" >>"${LOGFIL}" 2>&1
  echo "Stopping the FLEXnet License Manager service ..." >>"${LOGFIL}" 2>&1
  "${folder}/lmutil" lmdown -c "${LM_LIC_FIL}" -q >>"${LOGFIL}" 2>&1
fi

status=0

if [ $status -ne 0 ]
then
  echo "ERROR - Error occurred during stop of FLEXnet License Manager service."
  exit 1
else
  exit 0
fi
