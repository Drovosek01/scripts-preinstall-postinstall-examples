#!/bin/bash

# **********************************************************
#             Copyright 2009-2012 Esko Software bvba
#                     All rights reserved
#  All programs and data are property of Esko Software bvba
# **********************************************************
#
# Install FLEXnet Licensing Service and License Manager
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

# Source
FNP_LS_DIR="${TARGET_PATH}/FNP_Distribution/${VERSION}/FNPLicensingServer"
FNP_LM_DIR="${TARGET_PATH}/FNP_Distribution/${VERSION}/FNPLicenseManager"

#----------------------------------------------------------------------
# SERVER INSTALL LS
#----------------------------------------------------------------------

# Adapt to full folder specifications
pushd "${FNP_LS_DIR}" >/dev/null ; FNP_LS_DIR=$(pwd) ; popd >/dev/null

SERVICE="${FNP_LS_DIR}/FNPLicensingService"

# Check that service is available
if [ ! -f "$SERVICE" ]
then
  echo "ERROR - Unable to locate source for service to install." >>"${LOGFIL}"
  exit 1
fi

SERVICE_DST="/Library/Application Support/FLEXnet Publisher/Service/${VERSION}"

# Install FLEXnet Licensing Server service
# Could have been installed by other vendor
echo "Installing FLEXnet Licensing Server ${VERSION} service ..." >>"${LOGFIL}"
status=0
if [ ! -d "${SERVICE_DST}" ]
then
  echo "Creating FLEXnet Licensing Server ${VERSION} service folder ..." >>"${LOGFIL}"
  mkdir -p -v "${SERVICE_DST}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
else
  echo "FLEXnet Licensing Server ${VERSION} service folder already exists." >>"${LOGFIL}"
fi
if [ ! -f "${SERVICE_DST}/FNPLicensingService" ]
then
  echo "Copying FLEXnet Licensing Server ${VERSION} service files ..." >>"${LOGFIL}"
  cp -v "${SERVICE}" "${SERVICE_DST}/FNPLicensingService" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
  chown -v root:admin "${SERVICE_DST}/FNPLicensingService" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
  chmod -v -v 4755 "${SERVICE_DST}/FNPLicensingService" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
else
  echo "FLEXnet Licensing Server ${VERSION} service already exists." >>"${LOGFIL}"
fi

if [ $status -ne 0 ]
then
  echo "ERROR - Error occurred during installation of FLEXnet" >>"${LOGFIL}"
  echo "        Licensing Server ${VERSION} service files." >>"${LOGFIL}"
  exit 1
fi

# Handle Trusted Storage area
# Could have been installed by other vendor
echo "Configuring Trusted Storage area ..." >>"${LOGFIL}"
TS_PATH="/Library/Preferences/FLEXnet Publisher"
set +e
if [ -d "${TS_PATH}" ]
then
  echo "Trusted Storage area already exists." >>"${LOGFIL}"
else
  echo "Creating Trusted Storage area ..." >>"${LOGFIL}"
  mkdir -p -v "${TS_PATH}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ]
  then
    echo "ERROR - Error occurred during creation of Trusted Storage area." >>"${LOGFIL}"
    exit 1
  fi
fi

echo "Setting permissions on Trusted Storage area ..." >>"${LOGFIL}"
chmod 777 "${TS_PATH}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ]
then
  echo "ERROR - Unable to set permissions on Trusted Storage area." >>"${LOGFIL}"
  echo ${TS_PATH} >>"${LOGFIL}"
  exit 1
fi

echo "Configuring Replicated Anchor area ..." >>"${LOGFIL}"
RA_PATH="/Library/Preferences/.com.flexnetlicensing"
set +e
if [ -d "${RA_PATH}" ]
then
  echo "Replicated Anchor area already exists." >>"${LOGFIL}"
else
  echo "Creating Replicated Anchor area ..." >>"${LOGFIL}"
  mkdir -p "${RA_PATH}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ]
  then
    echo "ERROR - Error occurred during creation of Replicated Anchor area." >>"${LOGFIL}"
    echo ${RA_PATH} >>"${LOGFIL}"
    exit 1
  fi
fi

echo "Setting permissions on Replicated Anchor area ..." >>"${LOGFIL}"
chmod 777 "${RA_PATH}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ]
then
  echo "ERROR - Unable to set permissions on Replicated Anchor area." >>"${LOGFIL}"
  echo ${RA_PATH} >>"${LOGFIL}"
  exit 1
fi

echo "Configuring Temporary area ..." >>"${LOGFIL}"
TM_PATH="/tmp/FLEXnet"
set +e
if [ -d "${TM_PATH}" ]
then
  echo "Temporary area already exists." >>"${LOGFIL}"
else
  echo "Creating Temporary area ..." >>"${LOGFIL}"
  mkdir -p "${TM_PATH}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ]
  then
    echo "ERROR - Error occurred during creation of Temporary area." >>"${LOGFIL}"
    echo ${TM_PATH} >>"${LOGFIL}"
    exit 1
  fi
fi

echo "Setting permissions on Temporary area ..." >>"${LOGFIL}"
chmod 777 "${TM_PATH}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ]
then
  echo "ERROR - Unable to set permissions on Temporary area." >>"${LOGFIL}"
  echo ${TM_PATH} >>"${LOGFIL}"
  exit 1
fi

#----------------------------------------------------------------------
# SERVER INSTALL LM
#----------------------------------------------------------------------

pushd "${FNP_LM_DIR}" >/dev/null ; FNP_LM_DIR=$(pwd) ; popd >/dev/null
FNP_LM_DSTDIR="/Library/Application Support/FLEXnet Publisher/Manager"
FNP_LM_BINDIR="${FNP_LM_DSTDIR}/${VERSION}"
FNP_LM_LICDIR="${FNP_LM_DSTDIR}/License File"
FNP_LM_LOGDIR="${FNP_LM_DSTDIR}/Log File"

echo Installing FLEXnet License Manager ${VERSION} service ...  >>"${LOGFIL}"

# Create destination folders
echo "Checking and creating folders ..." >>"${LOGFIL}"
status=0
if [ ! -d "${FNP_LM_BINDIR}" ]
then
  mkdir -p -v -m 777 "${FNP_LM_BINDIR}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
fi
if [ ! -d "${FNP_LM_LICDIR}" ]
then
  mkdir -p -v -m 777 "${FNP_LM_LICDIR}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
fi
if [ ! -d "${FNP_LM_LOGDIR}" ]
then
  mkdir -p -v -m 777 "${FNP_LM_LOGDIR}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
fi

# Previous installations
chmod 777 "${FNP_LM_BINDIR}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chmod 777 "${FNP_LM_LICDIR}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chmod 777 "${FNP_LM_LOGDIR}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi

if [ $status -ne 0 ]
then
  echo "ERROR - Error occurred during creation of destination folder" >>"${LOGFIL}"
  echo "        for FLEXnet License Manager ${VERSION} service." >>"${LOGFIL}"
  exit 1
fi

LICFIL="${FNP_LM_LICDIR}/licenses.dat"
if [ ! -f "${LICFIL}" ]
then
  status=0
  echo "Initializing license file ..." >>"${LOGFIL}"
  cp -v "${FNP_LM_DIR}/licenses_initlm.dat" "${LICFIL}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
  chmod -v -v 666 "${LICFIL}" >>"${LOGFIL}" 2>&1
  if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
  if [ $status -ne 0 ]
  then
    echo "ERROR - Default license file could not be installed." >>"${LOGFIL}"
    exit 1
  fi
fi

# Previous installations
chmod 666 "${LICFIL}" 2>&1

USAGEFIL="${FNP_LM_LICDIR}/usagedisplaygroups.dat"
status=0
echo "Initializing usage display groups data file ..." >>"${LOGFIL}"
cp -f -v "${FNP_LM_DIR}/usagedisplaygroups.dat" "${USAGEFIL}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chmod -v -v 777 "${USAGEFIL}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
if [ $status -ne 0 ]
then
  echo "ERROR - Default usage display groups data file could not be installed." >>"${LOGFIL}"
exit 1
fi

# Installing files
status=0

echo "Installing files ..." >>"${LOGFIL}"
cp -v "${FNP_LM_DIR}/esko" "${FNP_LM_BINDIR}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
cp -v "${FNP_LM_DIR}/esko_LIBFNP.dylib" "${FNP_LM_BINDIR}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
cp -v "${FNP_LM_DIR}/lmgrd" "${FNP_LM_BINDIR}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
cp -v "${FNP_LM_DIR}/lmutil" "${FNP_LM_BINDIR}" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi

# Adapting permissions
echo "Adapting permissions of files ..." >>"${LOGFIL}"
chmod -v -v 775 "${FNP_LM_BINDIR}/esko" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chmod -v -v 775 "${FNP_LM_BINDIR}/lmgrd" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chmod -v -v 775 "${FNP_LM_BINDIR}/lmutil" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chmod -v -v 775 "${FNP_LM_BINDIR}/esko_libFNP.dylib" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi

# Adapting owner
echo "Adapting owner of files ..." >>"${LOGFIL}"
chown -v root:admin "${FNP_LM_BINDIR}/esko" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chown -v root:admin "${FNP_LM_BINDIR}/lmgrd" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chown -v root:admin "${FNP_LM_BINDIR}/lmutil" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi
chown -v root:admin "${FNP_LM_BINDIR}/esko_libFNP.dylib" >>"${LOGFIL}" 2>&1
if [ $? -ne 0 ] ; then status=$(($status+1)) ; fi

if [ $status -ne 0 ]
then
  echo "ERROR - Error occurred during installation of files." >>"${LOGFIL}"
  exit 1
fi

exit 0
