#!/bin/bash
set -e

echo "----------------------------------------"
echo "Find installed ArchiCAD ${AC_VERSION}"
echo "----------------------------------------"

#TMPFOLDER=xxx where xxx should be defined in the script calling this one, the folder name used during the installation process in the Applications folder
#APXFOLDER=yyy where yyy should be defined in the script calling this one, the folder name within the Archicad XX/Add-Ons folder containing the APX file and the related content
#AC_VER=zzz where zzz is the Archicad version (24, 25, 26, etc. an exact number) to be able to decide which content goes to which Archicad folder

#########################################
# Definitions
#########################################
FINDFILE="com.graphisoft.AC*${AC_VERSION}*.plist"
FINDINSTALLER="com.graphisoft.installers.ARCHICAD*${AC_VERSION}.*.plist"
FINDAPX="GDL DateTime"
INSTALL_PATH="/Applications"


#########################################
# Delete Root Installed Bundle
#########################################
if [ -d "$INSTALL_PATH/$TMPFOLDER" ]
then
	rm -Rf "/tmp/$TMPFOLDER"
	cp -fr "$INSTALL_PATH/$TMPFOLDER" "/tmp"
	sudo rm -Rf "$INSTALL_PATH/$TMPFOLDER"
fi
#add extra logic here if other files need to be copied as well

#########################################
# Apps array
#########################################
unset FOUNDAPP FOUNDACCP


#########################################
# Check preferences file
#########################################
unset FOUNDPLIST FOUNDACP
#unset FINDRESULT
#FINDRESULT=$(find "$HOME/Library/Preferences" -name "$FINDFILE")
#for file in ${FINDRESULT}; do
#	echo $file
#	FOUNDPLIST[FOUNDACP++]="$file"        # or however you want to process each file
#done

while IFS= read -r -d $'\0' file; do
	FOUNDPLIST[FOUNDACP++]="$file"        # or however you want to process each file
done < <(find "$HOME/Library/Preferences" -iname "$FINDFILE" -print0)

if [ $FOUNDACP ]
then
	for ((i = 0; i <= $FOUNDACP-1; i++)); do
		echo "Preferences found: ${FOUNDPLIST[$i]}"
	done

	# Read preferences file
	unset FOUNDEXE FOUNDACC
	for ((i = 0; i <= $FOUNDACP-1; i++)); do
		unset ACFOLDERPATH
		ACFOLDERPATH=$(/usr/libexec/PlistBuddy  -c "Print :'Last Started Path'" "${FOUNDPLIST[$i]}" 2>/dev/null || printf '0')
		if [ "$ACFOLDERPATH" != "0" ]
		then
			FOUNDEXE[$FOUNDACC]="$ACFOLDERPATH"
			echo "Preferences app path: ${FOUNDEXE[$FOUNDACC]}"
			let FOUNDACC=FOUNDACC+1
		fi
	done

	# Check exe file
	if [ $FOUNDACC ]
	then
		for ((i = 0; i <= $FOUNDACC-1; i++)); do
			if [ -d "${FOUNDEXE[$i]}" ]
			then
				FOLDER="$( cd "$( dirname "${FOUNDEXE[$i]}" )" && pwd )"
				FOUNDAPP[$FOUNDACCP]="$FOLDER"
				echo "Preferences app parent: ${FOUNDAPP[$FOUNDACCP]}"
				let FOUNDACCP=FOUNDACCP+1
			fi
		done
	fi
else
	echo "ArchiCAD preferences plist file not found"
fi


#########################################
# Check installers file
#########################################
unset FOUNDINSPLIST FOUNDACI
#unset FINDRESULT
#FINDRESULT=$(find "/Users/Shared/GRAPHISOFT" -name "$FINDINSTALLER")
#for file in ${FINDRESULT}; do
#	echo $file
#	FOUNDINSPLIST[FOUNDACI++]="$file"        # or however you want to process each file
#done

while IFS= read -r -d $'\0' file; do
	FOUNDINSPLIST[FOUNDACI++]="$file"        # or however you want to process each file
done < <(find "/Users/Shared/GRAPHISOFT" -iname "$FINDINSTALLER" -print0)

if [ $FOUNDACI ]
then
	for ((i = 0; i <= $FOUNDACI-1; i++)); do
		echo "Installer found: ${FOUNDINSPLIST[$i]}"
	done

	# Read installers files
	for ((i = 0; i <= $FOUNDACI-1; i++)); do
		unset ACFOLDERPATH
		ACFOLDERPATH=$(/usr/libexec/PlistBuddy  -c "Print :'InstallLocation'" "${FOUNDINSPLIST[$i]}")
		if [ "$ACFOLDERPATH" ]
		then
			echo "Installer location: $ACFOLDERPATH"

			# Check exist folder in preferences
			unset EXIST_IN_PREF
			EXIST_IN_PREF=0
			for ((j = 0; j <= $FOUNDACCP-1; j++)); do
				if [ "${FOUNDAPP[$j]}" ==  "$ACFOLDERPATH" ]
				then
					echo "Found app folder in preferences: $ACFOLDERPATH"
					EXIST_IN_PREF=1
					break
				fi
			done

			if [ $EXIST_IN_PREF == 0 ]
			then
				if [ "${AC_VERSION}" != "*" ]
				then
					unset EXEPATH
					EXEPATH="$ACFOLDERPATH/ARCHICAD $AC_VERSION.app"
					if [ -d "$EXEPATH" ]
					then
						FOUNDAPP[$FOUNDACCP]="$ACFOLDERPATH"
						echo "Installer app parent: ${FOUNDAPP[$FOUNDACCP]}"
						let FOUNDACCP=FOUNDACCP+1
					fi
				else
					if [ -d "$ACFOLDERPATH" ]
					then
						FOUNDAPP[$FOUNDACCP]="$ACFOLDERPATH"
						echo "Installer app parent: ${FOUNDAPP[$FOUNDACCP]}"
						let FOUNDACCP=FOUNDACCP+1
					fi
				fi
			fi
		fi
	done
else
	echo "ArchiCAD installer plist file not found"
fi


#########################################
# Check result
#########################################
if [ $FOUNDACCP ]
then
	echo "ArchiCAD application found: $FOUNDACCP"
else
	echo "Not found ArchiCAD path"
	exit 1
fi


#########################################
# Find Addons Directory
#########################################
unset FOUNDAPX FOUNDADD
for ((i = 0; i <= $FOUNDACCP-1; i++)); do
	if [ -d "${FOUNDAPP[$i]}" ]
	then
		echo "ArchiCAD folder path: ${FOUNDAPP[$i]}"

		#Find Addon folder with names
		unset FOUND_ADDONFOLDER
		if [ -d "${FOUNDAPP[$i]}/Add-Ons" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Add-Ons/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Extensões" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Extensões/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Doplnky ArchiCADu" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Doplnky ArchiCADu/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/ArchiCAD-laajennukset" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/ArchiCAD-laajennukset/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Extensions" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Extensions/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Kiegészítök" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Kiegészítök/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Kiegészítők" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Kiegészítők/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/애드온" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/애드온/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Dodatki" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Dodatki/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Расширения ArchiCAD" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Расширения ArchiCAD/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Extensiones ArchiCAD" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Extensiones ArchiCAD/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		elif [ -d "${FOUNDAPP[$i]}/Add-On'lar" ]
		then
			FOUNDAPX[$FOUNDADD]="${FOUNDAPP[$i]}/Add-On'lar/$APXFOLDER"
			let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
		else
			echo "Search '$FINDAPX.apx'"
			unset SUBAPXFOLDER
			SUBAPXFOLDER="$(find "${FOUNDAPP[$i]}" -type d -mindepth 2 -maxdepth 3 -name "$FINDAPX" )"
			echo "First check without apx $SUBAPXFOLDER"
			if [ -d "$SUBAPXFOLDER" ]
			then
				SUBAPXFOLDER=$(cd "$(dirname "$SUBAPXFOLDER/../../../")"; pwd)
				FOUNDAPX[$FOUNDADD]="$SUBAPXFOLDER/$APXFOLDER"
				let FOUND_ADDONFOLDER=FOUND_ADDONFOLDER+1
				echo "Founded ${FOUNDAPX[$FOUNDADD]}"
			fi
		fi

		echo "Addon folder found: $FOUND_ADDONFOLDER"
		if [ $FOUND_ADDONFOLDER ]
		then
			echo "Addon Install path: ${FOUNDAPX[$FOUNDADD]}"

			if [ -f "${FOUNDAPX[$FOUNDADD]}" ]
			then
				sudo rm -f "${FOUNDAPX[$FOUNDADD]}"
			else
				if [ -d "${FOUNDAPX[$FOUNDADD]}" ]
				then
					echo "Directory Exist: ${FOUNDAPX[$FOUNDADD]}"
					sudo rm -Rf "${FOUNDAPX[$FOUNDADD]}"
				fi
			fi

			sudo mkdir "${FOUNDAPX[$FOUNDADD]}"
			#sudo cp -fr "/tmp/${TMPFOLDER}" "${FOUNDAPX[$FOUNDADD]}"
			sudo cp -a "/tmp/${TMPFOLDER}/${AC_VER}/." "${FOUNDAPX[$FOUNDADD]}"
			#add extra copy logic here based on what is prepared in the top of the script when copying to tmp folder
			sudo chown -R root:wheel "${FOUNDAPX[$FOUNDADD]}"
			#sudo chmod -R u=rwx,go=u-w "${FOUNDAPX[$FOUNDADD]}"
			sudo chmod -R 777 "${FOUNDAPX[$FOUNDADD]}"

			#force delete folder BE CAREFUL with this
			echo "doing cleanup of old / forced folders"

			old_ifs=$IFS
			IFS=$'\n'
			ADDONSROOT="$(dirname "${FOUNDAPX[$FOUNDADD]}")"
			echo "Addons folder: ${ADDONSROOT}"
			echo "Folder to look for: ${FORCE_DELETE_FOLDER}"
			FOLDERSTODELETE="${ADDONSROOT}/${FORCE_DELETE_FOLDER}"
			unset FOLDERSTODELETE
			FOLDERSTODELETE=$(find "${ADDONSROOT}" -maxdepth 1 -name "${FORCE_DELETE_FOLDER}")
			echo "Folders to delete:"
			echo "${FOLDERSTODELETE}"
			if [ ${#FOLDERSTODELETE[@]} -gt 0 ]
			then
				for j in ${FOLDERSTODELETE}; do
					if [ -d "${j}" ]
					then
						sudo rm -Rf "${j}"
					fi
				done
			fi
			IFS=$old_ifs

			let FOUNDADD=FOUNDADD+1
		fi
	fi
done

if [ $FOUNDADD ]
then
	for ((i = 0; i < $FOUNDADD; i++)); do
		echo "Addon installed to: ${FOUNDAPX[$i]}"
	done
else
	echo "Could not find ArchiCAD Addon Folder"
	exit 1
fi


#########################################
# End without Error
#########################################
exit 0
