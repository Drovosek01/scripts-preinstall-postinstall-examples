#!/bin/sh

LOGLOCATION="/private/var/log/Native Instruments"


if [ ! -d "${LOGLOCATION}" ]; then
	mkdir "${LOGLOCATION}"
	chmod 775 "${LOGLOCATION}"
fi

# get timestamp from tmp file for naming log
TIMESTAMP=`cat /private/var/tmp/ni_timestamp`

TIME=`date`

# parse mpkg name from packagedir path
TMP=`pwd`

#cd "${PACKAGEDIR}"
#cd ../../..

MPKGPATH=`pwd`
MPKGNAME="${MPKGPATH##*/}"

VERSIONNUMBER=`defaults read "${MPKGPATH}/Info" "CFBundleShortVersionString"`

#generate filename with versionnumber
#generate dmgname with versionnumber
SHORTVERSIONNUMBER=""
LONGVERSIONNUMBER=""
if [ "${VERSIONNUMBER}" ]; then

	V1=`expr "${VERSIONNUMBER}" : '\([0-9]*\)'`
	V2=`expr "${VERSIONNUMBER}" : '[0-9]*\.\([0-9]*\)'`
	V3=`expr "${VERSIONNUMBER}" : '[0-9]*\.[0-9]*\.\([0-9]*\)'`
	V4=`expr "${VERSIONNUMBER}" : '[0-9]*\.[0-9]*\.[0-9]*[\.(RC ]*\([0-9]*\)'`

	SHORTVERSIONNUMBER=" ${V1}.${V2}.${V3}"
	LONGVERSIONNUMBER=${VERSIONNUMBER}
	LONGVERSIONNUMBER=${LONGVERSIONNUMBER// /}
	LONGVERSIONNUMBER=${LONGVERSIONNUMBER//./}
	LONGVERSIONNUMBER=${LONGVERSIONNUMBER//R/}
	LONGVERSIONNUMBER=${LONGVERSIONNUMBER//C/}
	LONGVERSIONNUMBER=${LONGVERSIONNUMBER//(/}
	LONGVERSIONNUMBER=${LONGVERSIONNUMBER//)/}
	LONGVERSIONNUMBER="_${LONGVERSIONNUMBER}"
fi

PRODUCT="${PRODUCTNAME// /_}"
LOGNAME="${PRODUCT// Driver/}${LONGVERSIONNUMBER}_Mac_${TIMESTAMP}"

PACKAGEDIR=`defaults read "${MPKGPATH}/Info" "CFBundleIdentifier"`
cd "$TMP"

if [ "${PLISTNAME}" ]; then 
	INSTPATH=$("${MPKGPATH}/pathhelper" read "/Library/Preferences/${PLISTNAME}" "InstallDir")
fi

# write time to plist first
defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "Time" "${TIME}" 

#if [ "${INSTPATH}" ]; then
#	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "InstallationPath" "${INSTPATH}"
#fi

#if [ "${PRODUCTNAME}" ]; then
#	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductName" "${PRODUCTNAME}"
#fi
if [ "${PLISTNAME}" -a "${PLISTNAME}" != "/Library/Preferences/com.native-instruments.*Content" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist PListName" "${PLISTNAME}"
fi
if [ "${SNO}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist SNO" "${SNO}"
fi

if [ "${INSTPATH}" -a "${PRODUCTNAME}" ]; then
	if [[ "$MPKGPATH" == *Application* ]] || [[ "$MPKGPATH" == *Documentation* ]]; then
		defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist InstallDir" "${INSTPATH}" 
	fi
fi
if [ "${CONTENTVERSION}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist ContentVersion" "${CONTENTVERSION}"
fi
if [ "${SNO_CIRCLE}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "SNOCircle" "${SNO_CIRCLE}"
fi
if [ "${SC_INSTALLDIR}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "SCInstallDir" "${SC_INSTALLDIR}"
fi
if [ "${CONTENTDIR}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist ContentDir" "${CONTENTDIR}"
fi
if [ "${KORECONTENTDIR}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist Kore2 ContentDir" "${KORECONTENTDIR}"
fi
if [ "${CONTENTPLIST}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ContentPlist PListName" "${CONTENTPLIST}"
fi
if [ "${LIBRARYID}" -a "${PRODUCTNAME}" ]; then
	# if Kontakt Sound Content
	if [ "${CONTENTPLIST}" == "/Library/Preferences/com.native-instruments.Content" ]; then
		defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ContentPlist k2lib${LIBRARYID}" "${PRODUCTNAME}"
	elif [ "${CONTENTPLIST}" == "/Library/Preferences/com.native-instruments.Reaktor Content" -o "${CONTENTPLIST}" == "/Library/Preferences/com.native-instruments.Maschine Content" ]; then
		defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ContentPlist lib_${PRODUCTNAME}" "${PRODUCTNAME}"
	fi
fi
if [ "${LIBRARYHU}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist HU" "${LIBRARYHU}"
fi
if [ "${LIBRARYJDX}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist JDX" "${LIBRARYJDX}"
fi
if [ "${LIBRARYVISIBILITY}" ]; then
	defaults write "${LOGLOCATION}/${LOGNAME}" "${PACKAGEDIR##*/}" -dict-add "ProductPlist LibraryVisibility" "${LIBRARYVISIBILITY}"
fi

if [ -e "${LOGLOCATION}/${LOGNAME}.plist" ]; then
	chmod 775 "${LOGLOCATION}/${LOGNAME}.plist"
fi

