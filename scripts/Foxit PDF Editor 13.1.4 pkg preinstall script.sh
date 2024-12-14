#!/bin/bash
mydir=`pwd`
FoxitInstallAlert="$mydir/FoxitInstallAlert.app/Contents/MacOS/FoxitInstallAlert"
postinstall="$mydir/postinstall"
ApplicationDateRootPath="Library/Application Support/Foxit Software/"
ApplicationName="Editor"
OldReaderName="Foxit PDF Reader"

newVersion=13.1.4.62748

# Obtain the current logged-in user's username through the HOME environment variable
user_from_home=$(basename "${HOME}")

# Check if the user exists
if id -u "${user_from_home}" >/dev/null 2>&1; then
  currentuser="${user_from_home}"
else
  # If the user does not exist, try using other methods to obtain the current logged-in user's username
  # Use the stat command to get the owner of /dev/console as the current logged-in user
  currentuser=$(stat -f "%Su" /dev/console)
fi

#set if or not patch
bPatch=false
if [[ $bPatch == false ]] && [[ ! -e "$FoxitInstallAlert" ]]; then
    echo "$FoxitInstallAlert does not exist. Installation failure."
    exit -1
fi

#get app version
oldAppName="Foxit PDF Editor"
plistfile="/Applications/Foxit PDF Editor.app/Contents/Info.plist"
if [ ! -e "$plistfile" ]; then
plistfile="/Applications/Foxit PhantomPDF.app/Contents/Info.plist"
oldAppName="Foxit PhantomPDF"
fi

echo "oldAppName: ${oldAppName}"

if [ -e "$plistfile" ]
then
	Version=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "${plistfile}")
	echo "oldversion: $Version"

    #set postinstall oldversionfromPreinstall
    echo "set postinstall oldversion"
    sed -i "" "s/oldversionvalue=\"\"/oldversionvalue=${Version}/g" postinstall

	su - "${currentuser}" -c ""$FoxitInstallAlert" /version ${newVersion} /oldversion "$Version""
	retval=$?

	echo "retval=$retval"
	if [ $retval -eq 1 ]
	then
	echo "FoxitInstallAlert fail"
	exit -1
	fi
fi

#if big version,need to auto activate use code after install; begin
exitSetSerial=$(grep "activateSerial=1" "$postinstall")
echo "exitSetSerial: $exitSetSerial"
if [ ! -n "$exitSetSerial" ] && [ -n "$Version" ]; then
    oldBigVersion=${Version%%.*}
    echo "oldBigVersion:$oldBigVersion"
    newBigVersion=${newVersion%%.*}
    echo "newBigVersion:$newBigVersion"
    #e.g.(4.1.0.0 -> 4·1)
    registerVersion=${Version%.*}
    registerVersion=${registerVersion%.*}
    registerVersion=${registerVersion/./·}
    echo "registerVersion:$registerVersion"
    if [[ $newBigVersion -gt $oldBigVersion ]]; then
        cd ~/Library/Preferences/
        echo `pwd`
        echo "newVersion is a big version"
        echo "get code"
        plistfile="com.foxit-software.${oldAppName}.plist"
        if [ -f "com.foxit-software.Foxit.PDF.Editor.plist" ];then
            plistfile="com.foxit-software.Foxit.PDF.Editor.plist"
        fi
        SerialnumKey="HKEY_LOCAL_MACHINE.SOFTWARE.Foxit Software.${oldAppName} ${registerVersion}.Register.Serialnum"
        Serialnum=$(/usr/libexec/PlistBuddy -c "Print \"${SerialnumKey}\"" "${plistfile}")
        echo "Serialnum: $Serialnum"
        if [ -n "$Serialnum" ]; then
            sed -i "" "s/activateSerial=0/activateSerial=1/g" "$postinstall"
            sed -i "" "s/{serial}/$Serialnum/g" "$postinstall"
            echo "set Serialnum 1 for postinstall"
        fi
    fi
fi
#end

# set continue version 1
continueVersion=0
# move old application data to new path
ApplicationDataType="Continuous"
if [ $continueVersion -eq 0 ]; then
    ApplicationDataType="Classic"
fi
cd
if [ ! -d "${ApplicationDateRootPath}${ApplicationDataType}" ]; then
    su - "${currentuser}" -c "mkdir -p \"${ApplicationDateRootPath}${ApplicationDataType}\""
fi
find "${ApplicationDateRootPath}" -maxdepth 1 -mindepth 1 -type d | while IFS= read -r dir
do
  file=$(basename "$dir")
  echo ${file}
    if [[ "${file}" != "Continuous" ]] && [[ "${file}" != "Classic" ]] && [[ "${file}" != "${OldReaderName}" ]]; then
      if [ ! -d "${ApplicationDateRootPath}${ApplicationDataType}/${file}" ]; then
        cp -Rpf "${ApplicationDateRootPath}${file}" "${ApplicationDateRootPath}${ApplicationDataType}/"
      fi
    fi
done
cd -
if [ -f "/Applications/Foxit PhantomPDF.app/Contents/fpmmkey.txt" ]; then
NewKeyfilePath=/usr/local/share/foxit/Foxit\ PDF\ Editor/Licenses/
if [ ! -d "${NewKeyfilePath}" ]; then
    mkdir -p "${NewKeyfilePath}"
fi
su - "${currentuser}" -c "mv -v /Applications/Foxit\ PhantomPDF.app/Contents/fpmmkey.txt ${NewKeyfilePath}"
fi


#unload updateService
if [ -e "/Library/LaunchDaemons/com.foxit.PDFEditorUpdateService.plist" ]; then
Launchctl unload /Library/LaunchDaemons/com.foxit.PDFEditorUpdateService.plist
fi

#unload and delete oldupdateService
if [ -e "/Library/LaunchDaemons/com.foxit.PhantomPDFUpdateService.plist" ]; then
Launchctl unload /Library/LaunchDaemons/com.foxit.PhantomPDFUpdateService.plist
rm -rf  /Library/LaunchDaemons/com.foxit.PhantomPDFUpdateService.plist
fi

#delete discard path
if [ -d "/Library/Application Support/Foxit Software/FoxitService/FoxitPhantomPDFUpdateService.app" ]; then
rm -rf "/Library/Application Support/Foxit Software/FoxitService/FoxitPhantomPDFUpdateService.app"
fi
if [ -d "/Library/Application Support/Foxit Software/FoxitService/FoxitPDFEditorUpdateService.app" ]; then
rm -rf "/Library/Application Support/Foxit Software/FoxitService/FoxitPDFEditorUpdateService.app"
fi
FoxitServicePath="/Library/Application Support/Foxit Software/FoxitService"
if [ -d "${FoxitServicePath}" ];then
  if [ "$(ls -A "${FoxitServicePath}")" = "" ]; then
    rm -rf "${FoxitServicePath}"
  fi
fi

rm -rf /Applications/Foxit\ PhantomPDF.app

#set if or not patch
bPatch=false
if [ ${bPatch} == false ]; then
    rm -rf /Applications/Foxit\ PDF\ Editor.app
    rm -rf "/Library/PDF Services/Save as Foxit PDF.app"
    cd ~/
    rm -rf "./Library/PDF Services/Save as Foxit PDF.app"
    cd -
fi

#delete old addin
declare -a files=("/Users/${currentuser}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Startup.localized/Word/FoxitPDF Editor Add-in.dotm"
                "/Users/${currentuser}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Startup.localized/Excel/FoxitPDF Editor Add-in.xlam"
                "/Users/${currentuser}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Startup.localized/Powerpoint/FoxitPDF Editor Add-in.ppam"
                "/Users/${currentuser}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Startup.localized/Word/Word Addin.dotm"
                "/Users/${currentuser}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Startup.localized/Excel/Excel Addin.xlam"
                "/Users/${currentuser}/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Startup.localized/Powerpoint/PowerPoint Addin.ppam"
)

for filePath in "${files[@]}"
do
    echo "filepath: ${filePath}"
    if [ -e "$filePath" ]; then
         echo "rm ${filePath}"
         rm -rf "$filePath"
    fi
done

exit 0
