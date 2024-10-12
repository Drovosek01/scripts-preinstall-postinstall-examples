#!/bin/sh
#preflight

SCRIPTDIR="${0}"
PACKAGEDIR="${1}"
PLISTLOCATION="$PWD/Info"
PRODUCTNAME=$(defaults read "$PLISTLOCATION" "NIProductName")
PLISTNAME=$(defaults read "$PLISTLOCATION" "NIPlistName")
INSTALLDIR="${2}/${PRODUCTNAME}"

killall -TERM NIHardwareAgent
ERRORCODE=$?

if [ $ERRORCODE != 0 ]; then
    echo "Killing NIHardwareAgent failed."
fi

exit 0
