#!/bin/sh
#writes InstallDir to plist

SCRIPTDIR="${0}"
PACKAGEDIR="${1}"
PLISTLOCATION="$PWD/Info"
PRODUCTNAME=$(defaults read "$PLISTLOCATION" "NIProductName")
PLISTNAME=$(defaults read "$PLISTLOCATION" "NIPlistName")
INSTALLDIR="${2}/${PRODUCTNAME}"
CONTENTVERSION=$(defaults read "$PLISTLOCATION" "NIContentVersion")

#either use SNO plugin in installer for Kore soundpacks or use dummy SNOs below for Kontakt and Reaktor!
if [ -e "${PWD}/postflightWriteSNO" ]; then
    #include extra code via source command (dot)
    . "${PWD}/postflightWriteSNO"
fi

if [ -e "${PWD}/postflightApplicationKontaktPlayer" ]; then
    #include extra code via source command (dot)
    . "${PWD}/postflightApplicationKontaktPlayer"
fi

if [ -e "${PWD}/postflightApplicationReaktorPlayer" ]; then
    #include extra code via source command (dot)
    . "${PWD}/postflightApplicationReaktorPlayer"
fi

FAILED=FALSE

if ! "${PWD}/pathhelper" writedir "/Library/Preferences/${PLISTNAME}" "InstallDir" "${INSTALLDIR}"; then
    echo "** FAILED pathhelper writedir **"
    FAILED=TRUE
else
    #exception for Reaktor 5 plist - should go into Reaktor 6 code!
    if [ "$PRODUCTNAME" = "Reaktor 5" ]; then
        "${PWD}/pathhelper" writedir "/Library/Preferences/${PLISTNAME}" "SystemContentDir" "$INSTALLDIR/Library"
        defaults write "/Library/Preferences/${PLISTNAME}" "ContentVersion" "$CONTENTVERSION"
    fi

    if [ -e "/Applications/Native Instruments" ]; then
        chmod -R 775 "/Applications/Native Instruments"
    fi
fi

# start SC with product id if SNO_CIRCLE is written to plist
if [ "$PRODUCTNAME" != "Service Center" -a "$PRODUCTNAME" != "Controller Editor" ]; then
    SC_INSTALLDIR=$("${PWD}/pathhelper" read "/Library/Preferences/com.native-instruments.ServiceCenter" "InstallDir")
    echo "${SC_INSTALLDIR}" >/tmp/inst_tmp
fi

if [ -e "${PWD}/installerLogger" ]; then
    #include extra code for logging via source command (dot)
    source "${PWD}/installerLogger"
fi

if [ $FAILED = TRUE ]; then
    echo "At least one failure occurred in script '${SCRIPTDIR}' in package '${PACKAGEDIR}'."
    exit 1
fi
