#!/bin/sh
# postflight

SCRIPTDIR="${0}"
PACKAGEDIR="${1}"
PLISTLOCATION="$PWD/Info"
PRODUCTNAME=$(defaults read "$PLISTLOCATION" "NIProductName")
PLISTNAME=$(defaults read "$PLISTLOCATION" "NIPlistName")
INSTALLDIR="${2}/${PRODUCTNAME}"

FAILED=FALSE

# fix potential permission issues in Application Support folder
chmod -R 775 "/Library/Application Support/Native Instruments"
chown -R root:admin "/Library/Application Support/Native Instruments"

if [ -e "/Library/Application Support/Native Instruments/Hardware/NIHardwareAgent.app" ]; then
    "$PWD/LoginItemHelper" -add "/Library/Application Support/Native Instruments/Hardware/NIHardwareAgent.app" -hide
    ERRORCODE=$?
    if [ $ERRORCODE != 0 ]; then
        echo "Error occured while adding NIHardwareAgent to LoginItems..."
        FAILED=TRUE
    fi
    open -a "/Library/Application Support/Native Instruments/Hardware/NIHardwareAgent.app"
    ERRORCODE=$?
    if [ $ERRORCODE != 0 ]; then
        echo "Cannot start NIHardwareAgent..."
        #FAILED=TRUE
    fi
fi

if [ -e "${PWD}/postflightFactoryContent" ]; then
    . "${PWD}/postflightFactoryContent"
fi

if [ -e "${PWD}/installerLogger" ]; then
    #include extra code for logging via source command (dot)
    source "${PWD}/installerLogger"
fi

if [ $FAILED = TRUE ]; then
    echo "At least one failure occurred in script '${SCRIPTDIR}' in package '${PACKAGEDIR}'."
    exit 1
fi
