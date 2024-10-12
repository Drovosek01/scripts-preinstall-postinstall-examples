#!/bin/bash
set -e

echo "----------------------------------------"
echo "Find installed ArchiCAD ${AC_VERSION}"
echo "----------------------------------------"


#########################################
# Definitions
#########################################
FINDFILE="com.graphisoft.AC*${AC_VERSION}*.plist"
FINDINSTALLER="com.graphisoft.installers.ARCHICAD*${AC_VERSION}.*.plist"


#########################################
# Apps array
#########################################
unset FOUNDAPP FOUNDACCP


#########################################
# Check preferences file
#########################################
unset FOUNDPLIST FOUNDACP
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
	echo "Not found ArchiCAD preferences plist file"
fi


#########################################
# Check installers file
#########################################
unset FOUNDINSPLIST FOUNDACI
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
	for ((i = 0; i <= $FOUNDACCP-1; i++)); do
		echo "App Folder: ${FOUNDAPP[$i]}"
	done
else
	echo "Not found ArchiCAD path"
	exit 1
fi


#########################################
# End without Error
#########################################
exit 0
