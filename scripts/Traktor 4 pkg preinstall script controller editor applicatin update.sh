#!/bin/sh
#preflightApplicationUpdate
#reads InstallDir from plist and creates symlink in tmp

#Find out where .app is installed to
SCRIPTDIR="${0}"
PACKAGEDIR="${1}"
FAILED=FALSE
PLISTLOCATION="${PWD}/Info"
PRODUCTNAME=$(defaults read "${PLISTLOCATION}" "NIProductName")
PLISTNAME=$(defaults read "${PLISTLOCATION}" "NIPlistName")
APPFILENAME=$(defaults read "${PLISTLOCATION}" "NIAppFileName")
PKGNAME=$(basename "${PACKAGEDIR}" .pkg)
DEFAULTLOCATION=$(defaults read "${PLISTLOCATION}" "IFPkgFlagDefaultLocation")
INSTALLDIR=$("${PWD}/pathhelper" read "/Library/Preferences/${PLISTNAME}" "InstallDir")

echo "==[preflightApplicationUpdate ]=="
echo "Default Location: ${DEFAULTLOCATION}"
echo "cwd: ${PWD}"
echo "Script Dir: ${SCRIPTDIR}"
echo "Package Folder: ${PACKAGEDIR}"
echo "Product Name: ${PRODUCTNAME}"
echo "Plist Name: ${PLISTNAME}"
echo "PKG Name: ${PKGNAME}"
echo "PlistLocation: ${PLISTLOCATION}"
echo "================================="

if [ ! -e "${INSTALLDIR}" ]; then
    echo "Directory from previous installation not existing"
    if [[ ${PRODUCTNAME} == *Service* || ${PRODUCTNAME} == *Controller* ]]; then
        echo "[$PRODUCTNAME]"
        echo "Creating folders for ${PRODUCTNAME} in /Applications/Native Instruments/${PRODUCTNAME}"
        INSTALLDIR="/Applications/Native Instruments/${PRODUCTNAME}"
        if [ ! -e "${INSTALLDIR}" ]; then
            mkdir -p "${INSTALLDIR}"
            chmod 775 "/Applications/Native Instruments/"
            chmod -R 775 "${INSTALLDIR}"
        fi
    else
        echo "installdir not existing and product not service center or controller editor (product not installed)"
        FAILED=TRUE
    fi
else
    echo "Installation folder existing in /Library/Preferences/${PLISTNAME}: ${INSTALLDIR}"
    echo "creating softlink: ${DEFAULTLOCATION} -> ${INSTALLDIR}"
    ln -s "${INSTALLDIR}" "${DEFAULTLOCATION}"

    if [ -e "${PWD}/preflightReaktorApplication" ]; then
        . "${PWD}/preflightReaktorApplication"
    fi

    # if Traktor 2 or Traktor Pro 3 --> backup Traktor.app
    if [ "$PRODUCTNAME" = 'Traktor 2' -o "$PRODUCTNAME" = 'Traktor Pro 3' ]; then
        BINARYPATH="${INSTALLDIR}/${APPFILENAME}.app"
        BACKUPPATH="${INSTALLDIR}/Backup"

        if [ -e "${BINARYPATH}" ]; then
            VERSIONNUMBER=$(defaults read "${INSTALLDIR}/${APPFILENAME}.app/Contents/Info" "CFBundleShortVersionString")
            BACKUP_BINARYPATH="${BACKUPPATH}/${APPFILENAME} ${VERSIONNUMBER}.app"

            if [ ! -e "${BACKUPPATH}" ]; then
                mkdir "$BACKUPPATH"
                chmod -R 775 "${BACKUPPATH}"
            fi

            if [ ! -e "${BACKUP_BINARYPATH}" ]; then
                mv "${BINARYPATH}" "${BACKUP_BINARYPATH}"
                chmod -R 775 "${BACKUP_BINARYPATH}"
            fi
        fi
    else
        rm -rf "${INSTALLDIR}/${APPFILENAME}.app"
    fi
fi
if [ $FAILED = TRUE ]; then
    echo "At least one failure occurred in script '${SCRIPT_NAME}' in package '${PACKAGEDIR}'."
    exit 1
fi
