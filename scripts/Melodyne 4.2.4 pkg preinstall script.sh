#!/bin/sh
#

PRODUCT_NAME="Melodyne"

cele_rescp()
{
  _SRC="${CELEMONY_RESOURCES_DIR}/${1}"
  _DSTDIR="${CELEMONY_APPSUPPORT_DIR}/${2}"
  _DSTNAME="${3}"

  if [ ! -f "${_SRC}" ]; then
    _SRC=${0%/*}/${1}
  fi

  if [ -f "${_SRC}" ]; then
    mkdir -p "${_DSTDIR}"
    cp "${_SRC}" "${_DSTDIR}/${_DSTNAME}"
    chmod ugo+r "${_DSTDIR}/${_DSTNAME}"
  fi
}

##
## MAIN
##

# INSTALL_PKG_SESSION_ID
# SCRIPT_NAME

_PACKAGE_PATH="$1"
_DEFAULT_LOCATION="$2"
_TARGET_VOLUME="$3"

VERSION=4.2.4.001
MAJOR_VERSION=${VERSION%%.*}

CELEMONY_PACKAGE_DIR="${_PACKAGE_PATH%/*}"

CELEMONY_RESOURCES_DIR=
for _RESROOT in "${CELEMONY_PACKAGE_DIR}"
do
  if [ -d "${_RESROOT}" ]; then
    CELEMONY_RESOURCES_DIR="${_RESROOT}/.celemony"
  fi
done

CELEMONY_APPSUPPORT_DIR="/Library/Application Support/Celemony"

cele_rescp "Celemony.license" "Licenses" "Celemony.license"
cele_rescp "Productinfo.plist" "Productinfo" "${PRODUCT_NAME}.plist"
if [ -r /tmp/CELEMONY_SERIAL_NUMBER ]; then
	read CELEMONY_SERIAL_NUMBER < /tmp/CELEMONY_SERIAL_NUMBER
	mkdir -p "${CELEMONY_APPSUPPORT_DIR}/Productinfo"
	cat << EOF > "${CELEMONY_APPSUPPORT_DIR}/Productinfo/${PRODUCT_NAME}.plist"
{
	serialNumber = "${CELEMONY_SERIAL_NUMBER}";
}
EOF
	rm -f /tmp/CELEMONY_SERIAL_NUMBER
fi

rm -rf "${CELEMONY_APPSUPPORT_DIR}/Bundles/${PRODUCT_NAME}CoreCarbon-${MAJOR_VERSION}."*".sbb"
rm -rf "${CELEMONY_APPSUPPORT_DIR}/Bundles/${PRODUCT_NAME}CoreCocoa-${MAJOR_VERSION}."*".sbb"

exit 0
