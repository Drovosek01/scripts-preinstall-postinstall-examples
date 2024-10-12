#!/bin/sh
# deletes symlink in tmp folder
# for CE, moves the tmp folders to INSTALLDIR (Catalina symlinking issue)

#Find out where symlink is created
SCRIPTDIR="${0}"
PACKAGEDIR="${1}"
PLISTLOCATION="$PWD/Info"
PRODUCTNAME=$(defaults read "$PLISTLOCATION" "NIProductName")
PLISTNAME=$(defaults read "$PLISTLOCATION" "NIPlistName")
PKGNAME=$(basename "$PACKAGEDIR" .pkg)
APPFILENAME=$(defaults read "$PLISTLOCATION" "NIAppFileName")
DEFAULTLOCATION=$(defaults read "${PLISTLOCATION}" "IFPkgFlagDefaultLocation")
INSTALLDIR=$("${PWD}/pathhelper" read "/Library/Preferences/${PLISTNAME}" "InstallDir")

echo "==[postflightApplicationUpdate]=="
echo "Installdir: ${INSTALLDIR}"
echo "Package Folder: ${PACKAGEDIR}"
echo "Product Name: ${PRODUCTNAME}"
echo "Plist Name: ${PLISTNAME}"
echo "PKG Name: ${PKGNAME}"
echo "================================="

DEFAULT_INSTALLDIR="/Applications/Native Instruments/${PRODUCTNAME}"

if [[ $PRODUCTNAME == *Service* || $PRODUCTNAME == *Controller* ]]; then
    INSTALLDIR="/Applications/Native Instruments/${PRODUCTNAME}"
    echo "Moving: ${DEFAULTLOCATION} -> ${INSTALLDIR}"
    mv "${DEFAULTLOCATION}"/* "${INSTALLDIR}"
    # cleaning up empty DEFAULTLOCATION
    rm -rf "${DEFAULTLOCATION}"
fi

if ! "${PWD}/pathhelper" writedir "/Library/Preferences/${PLISTNAME}" "InstallDir" "${INSTALLDIR}"; then
    echo "** FAILED pathhelper writedir **"
    FAILED=TRUE
fi

if [ -e "${PWD}/postflightReaktorApplication" ]; then
    #include extra code via source command (dot)
    source "${PWD}/postflightReaktorApplication"
fi

# remove symlink

rm -rf "${DEFAULTLOCATION}"

if [ -e "${PWD}/installerLogger" ]; then
    #include extra code for logging via source command (dot)
    source "${PWD}/installerLogger"
fi
