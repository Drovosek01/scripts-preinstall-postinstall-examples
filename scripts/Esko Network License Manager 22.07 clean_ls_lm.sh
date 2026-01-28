#!/bin/bash

# **********************************************************
#             Copyright 2009-2013 Esko Software bvba
#                     All rights reserved
#  All programs and data are property of Esko Software bvba
# **********************************************************
#
# Clean FLEXnet Licensing Service and License Manager
#
#  P1 = Source folder
#  P2 = Log file

VERSION=11.18.3

# Full folder specification where this file is 
where=${0%/*}
pushd "${where}" >/dev/null ; where=$(pwd) ; popd >/dev/null

# Parameters
TARGET_PATH="$1"
LOGFIL="$2"

#----------------------------------------------------------------------
# SERVER CLEAN LS
#----------------------------------------------------------------------

SERVICE_DST="/Library/Application Support/FLEXnet Publisher/Service/${VERSION}"

status=0
if [ -d "${SERVICE_DST}" ]
then
  echo "Cleaning FLEXnet Licensing Server ${VERSION} service folder ..." >>"${LOGFIL}"
  rm -r -v "${SERVICE_DST}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
fi
if [ $status -ne 0 ]
then
  echo "ERROR - Error occurred during cleaning of FLEXnet" >>"${LOGFIL}"
  echo "        Licensing Server ${VERSION} service files." >>"${LOGFIL}"
  exit 1
fi

#----------------------------------------------------------------------
# SERVER CLEAN LM
#----------------------------------------------------------------------

FNP_LM_DSTDIR="/Library/Application Support/FLEXnet Publisher/Manager"
FNP_LM_BINDIR="${FNP_LM_DSTDIR}/${VERSION}"

echo Cleaning FLEXnet License Manager ${VERSION} service ...  >>"${LOGFIL}"

status=0
if [ -d "${FNP_LM_BINDIR}" ]
then
  rm -r -v "${FNP_LM_BINDIR}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
fi

if [ $status -ne 0 ]
then
  echo "ERROR - Error occurred during cleaning of FLEXnet" >>"${LOGFIL}"
  echo "        License Manager ${VERSION} service files." >>"${LOGFIL}"
  exit 1
fi
exit 0
