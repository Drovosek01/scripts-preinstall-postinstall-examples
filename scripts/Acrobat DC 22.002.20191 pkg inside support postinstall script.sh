#!/bin/bash

function url_encode {
    local LC_ALL=C
    url=$1
    len=${#url}
    for (( i = 0 ; i < $len ; i++ )) ; do
        char=${url:i:1}
        case $char in
            [a-zA-Z0-9.-/]) encodedUrl=$encodedUrl$char;;
            *) encodedUrl=$encodedUrl%20
        esac
    done
}

encodedUrl=""
AcrobatPath=$2
TMP_DIR="/tmp/com.adobe.acrobat.DC"

# create SLStore folder for licensing
mkdir -p -m 777 "/Library/Application Support/Adobe/SLStore"

if [ $HOME 2>/dev/null ]
then
	mkdir -p -m 777 "$HOME/Library/Logs"
fi

# does serialization init.
mydir=`pwd`
Tool="$mydir/Tools/AcroAppTool.app/Contents/MacOS/AcroAppTool"
if [ -e "$mydir/Tools/AcroAppTool.app/Contents/MacOS/AcroAppTool" ]
then
	# Ignore user context and always invoke as root. This is needed by the serialization code.
	$Tool "$AcrobatPath" "OOBE"
	
	retval=$?
	if [ $retval -ne 0 ]
	then
		exit -1
	fi

else
	echo "cannot find $Tool. Installation failure"
	exit -1
fi

# validate if /Library/ColorSync/Profiles exists. If not, create it.
if [ ! -e "/Library/ColorSync/Profiles" ]
then
	mkdir -p "/Library/ColorSync/Profiles"
fi

# make a symlink to our profiles folder
if [ -e "/Library/Application Support/Adobe/Color/Profiles" ]
then
	if [ -e "/Library/ColorSync/Profiles/Profiles" ]
	then
		rm -rf "/Library/ColorSync/Profiles/Profiles"
	fi
	
	ln -s "/Library/Application Support/Adobe/Color/Profiles" "/Library/ColorSync/Profiles/Profiles"
fi

# make a symlink to our recommended folder
if [ -e "/Library/Application Support/Adobe/Color/Profiles/Recommended" ]   
then
	if [ -e "/Library/ColorSync/Profiles/Recommended" ]
	then
		rm -rf "/Library/ColorSync/Profiles/Recommended"
	fi
	
	ln -s "/Library/Application Support/Adobe/Color/Profiles/Recommended" "/Library/ColorSync/Profiles/Recommended"
fi

# Ignore user context and always invoke as root. This is needed to install add-in inside word.
$Tool "$AcrobatPath" "WordAddIn" "/Library/Application Support/Adobe/MACPDFM/DC/linkCreation.dotm"
retval=$?
if [ $retval -ne 0 ]
then
    echo "unable to install pdfmaker word add-in"
fi

# Ignore user context and always invoke as root. This is needed to install add-in inside powerpoint.
$Tool "$AcrobatPath" "PowerpointAddIn" "/Library/Application Support/Adobe/MACPDFM/DC/SaveAsAdobePDF.ppam"
retval=$?
if [ $retval -ne 0 ]
then
	echo "unable to install pdfmaker powerpoint add-in"
fi

# Excel Add-In for MAC
$Tool "$AcrobatPath" "ExcelAddIn" "/Library/Application Support/Adobe/MACPDFM/DC/SaveAsAdobePDF.xlam"
retval=$?
if [ $retval -ne 0 ]
then
echo "unable to install pdfmaker excel add-in"
fi

# Take a backup of the MacPDFM.framework for Co-Ex support
rm -rf "/Library/Application Support/Adobe/MACPDFM/DC/MacPDFM.framework"
ditto "/Library/Application Support/Adobe/MACPDFM/MacPDFM.framework" "/Library/Application Support/Adobe/MACPDFM/DC/MacPDFM.framework"
retval=$?
if [ $retval -ne 0 ]
then
    echo "unable to take a backup of MacPDFM.framework to /Library/Application Support/Adobe/MACPDFM/DC folder"
fi

#Remove the older unusable FF-Ext unsupported by Mozilla since Firefox-57.
rm -rf "/Library/Application Support/Mozilla/Extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/web2pdfextension@web2pdf.adobedotcom"
retval=$?
if [ $retval -ne 0 ]
then
    echo "Could not remove the older Firefox extension from /Library/Application Support/Mozilla/Extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384} folder"
fi

# Take a backup of the new FF ext for Co-Ex support
ditto "/Library/Application Support/Mozilla/Extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/web2pdfextension.17@acrobat.adobe.com.xpi" "/Library/Application Support/Mozilla/Extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/.DC/web2pdfextension.17@acrobat.adobe.com.xpi"
retval=$?
if [ $retval -ne 0 ]
then
    echo "unable to take a backup of web2pdfextension.17@acrobat.adobe.com.xpi to Mozilla/Extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/.DC folder"
fi

ditto "/Library/Application Support/Mozilla/NativeMessagingHosts/com.adobe.acrobat.firefox_webcapture.json" "/Library/Application Support/Mozilla/NativeMessagingHosts/.DC/com.adobe.acrobat.firefox_webcapture.json"
retval=$?
if [ $retval -ne 0 ]
then
    echo "unable to take a backup of com.adobe.acrobat.firefox_webcapture.json to /Library/Application Support/Mozilla/NativeMessagingHosts/.DC folder"
fi

ditto "/Library/Application Support/Adobe/WebExtnUtils/NativeMessagingHost.app" "/Library/Application Support/Adobe/WebExtnUtils/DC/NativeMessagingHost.app"
retval=$?
if [ $retval -ne 0 ]
then
    echo "unable to take a backup of NativeMessagingHost.app to /Library/Application Support/Adobe/WebExtnUtils/DC folder"
fi

ditto "/Library/Application Support/Adobe/WebExtnUtils/WCFirefox_x86_64Extn.dylib" "/Library/Application Support/Adobe/WebExtnUtils/DC/WCFirefox_x86_64Extn.dylib"
retval=$?
if [ $retval -ne 0 ]
then
    echo "unable to take a backup of WCFirefox_x86_64Extn.dylib to /Library/Application Support/Adobe/WebExtnUtils/DC folder"
fi

# Copy Native Host JSON for google chrome.
ditto "/Library/Application Support/Adobe/Acrobat/DC/Chrome/NativeMessagingHost/com.adobe.acrobat.chrome_webcapture.json" "/Library/Google/Chrome/NativeMessagingHosts/com.adobe.acrobat.chrome_webcapture.json"
retval=$?
if [ $retval -ne 0 ]
then
echo "unable to copy Native Host JSON for google chrome to /Library/Google/Chrome/NativeMessagingHosts"
fi


#check if upgradeTempFile.plist exist, if yes, read the reader app path from it and uninstall that
USER_NAME=`last -1 | cut -d " " -f 1`
UPGRADE_TMP_PLIST="/Users/$USER_NAME/Library/Application Support/Adobe/com.adobe.ARMDCHelper/upgradeTempFile.plist"
if [  -e "$UPGRADE_TMP_PLIST" ]
then
    echo "Reader to Acrobat upgrade case...Removing Reader app used to upgrade to Acrobat..."
    readerAppPath=`defaults read "$UPGRADE_TMP_PLIST" InstalledProductRoot`
    rm -rf "$readerAppPath"
    retval=$?
    if [ $retval -ne 0 ]
    then
        echo "ERROR:Unable to remove the Reader app from $readerAppPath"
    fi

    #check if the reader app being removed has the pdf ownership in browser, if yes, pass-on the ownership to Acrobat being installed
    currWebBrowserUsePath=`defaults read "/Library/Preferences/com.adobe.acrobat.pdfviewer" WebBrowserUsePath`
    url_encode "$readerAppPath"
    readerAppUrl="file://localhost$encodedUrl/"
    if [ "$currWebBrowserUsePath" == "$readerAppUrl" ]
    then
        echo "Transfering pdf ownership in browser from Reader to Acrobat..."
        if [ -e $TMP_DIR/acrobat.plist ]
        then
            AcrobatInstallPath=`defaults read $TMP_DIR/acrobat AcrobatInstallDir`
            AcrobatUrl=`defaults read $TMP_DIR/acrobat AcrobatInstallPath`

            cp -r "$AcrobatInstallPath/Adobe Acrobat.app/Contents/Support/Browser/AdobePDFViewer.plugin" "/Library/Internet Plug-Ins/"
            cp -r "$AcrobatInstallPath/Adobe Acrobat.app/Contents/Support/Browser/AdobePDFViewerNPAPI.plugin" "/Library/Internet Plug-Ins/"

            defaults write /Library/Preferences/com.adobe.acrobat.pdfviewer WebBrowserUsePath $AcrobatUrl
        fi
    fi
fi

if [ -e $TMP_DIR/acrobat.plist ]
then
    # check if application.pkg is already installed or not, if not, we'll defer the deletion of acrobat.plist to application payload's postinstall action
    AcrobatUrl=`defaults read $TMP_DIR/acrobat AcrobatInstallPath`
    if [ ! -z $AcrobatUrl ]
    then
        /bin/rm "$TMP_DIR/acrobat.plist"
        /bin/rmdir "$TMP_DIR"
    fi
fi


###
# Try to rectify OOBE folder permissions

function checkUpdateOOBEFolderPermission
{
    #echo "Checking permissions of folder : $1"

    needToUpdatePermissions=0
    OOBEFolderToCheck="$1"
    userName=`echo $OOBEFolderToCheck | cut -d'/' -f3`

    if [ -e "$OOBEFolderToCheck" ]
    then

        fileOwnerName=`stat -f '%Su' "$OOBEFolderToCheck"`
        #echo $fileOwnerName

        filePermission=`stat -f %p "$OOBEFolderToCheck" |cut -c 3`
        #echo $filePermission

        if [ "$fileOwnerName" == "root" ] && [ "$userName" != "root" ]
        then
            needToUpdatePermissions=1
        fi

        if [ "$filePermission" != "7" ]
        then
            needToUpdatePermissions=1
        fi

        if [ "$needToUpdatePermissions" -eq 1 ]
        then
            echo " Updating permissions of $OOBEFolderToCheck"
            chmod -h 777 "$OOBEFolderToCheck"
        fi

    fi
}

echo "Checking permissions of OOBE Folder"

lastLoggedInUser=`last -1 | cut -d " " -f 1`
lastLoggedInUserOOBEFolder="/Users/$lastLoggedInUser/Library/Application Support/Adobe/OOBE"
checkUpdateOOBEFolderPermission "$lastLoggedInUserOOBEFolder"

userDirCount=0
for dir in /Users/* ;do
    needToUpdatePermissions=0
    userDirCount=`expr $userDirCount + 1`
    OOBEFolderToCheck="$dir/Library/Application Support/Adobe/OOBE"

    checkUpdateOOBEFolderPermission "$OOBEFolderToCheck"

    if [ "$userDirCount" -eq 20 ]
    then
        break;
    fi
done

exit 0
