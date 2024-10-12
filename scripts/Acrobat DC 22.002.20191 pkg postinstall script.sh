#!/bin/bash

# SUCCESS is 0
function default_python_exists()
{
    if ! command -v python &> /dev/null
    then
        return 1
    fi
    return 0
}

# SUCCESS is 0 - when machine OS version >= 12.3
function use_acro_python()
{
    current_os_major_version=$(sw_vers -productVersion 2>&1 | sed 's/\([0-9]*\)\.\([0-9]*\).*/\1/')
    current_os_minor_version=$(sw_vers -productVersion 2>&1 | sed 's/\([0-9]*\)\.\([0-9]*\).*/\2/')
    required_major_version=12
    required_minor_version=3
   if [[
            ($current_os_major_version -gt $required_major_version) ||
            (($current_os_major_version -eq $required_major_version) && ($current_os_minor_version -ge $required_minor_version))
    ]]
    then
        echo "Mac OS version [$mac_os_version] is equal/higher than 12.3."

        if [[ -e "$PYTHON_MARKER_FILE" ]];
        then
            installed_python=`command -v python`
            if ! default_python_exists ; then
                echo "Marker file found, but default python not found [$installed_python]."
            else
                echo "Marker file found, will use default python. [$installed_python]"
            fi
            return 1
        fi

        if [[ -e "$ACRO_PYTHON3_TOOL" ]]; then
            echo "Will use own copy of python3."
            return 0
        fi 
    fi

    return 1
}

function exitWithErrorCode
{
    echo "ERROR: Postinstall exited with error code $1."
    exit $1
}

function url_encode {
        local LC_ALL=C
        url=$1
        len=${#url}
        for (( i = 0 ; i < $len ; i++ )) ; do
            char=${url:i:1}
            case $char in
                [a-zA-Z0-9.-/]) encodedUrl=$encodedUrl$char;;
                *) encodedUrl=$encodedUrl%`echo -n "$char"|xxd -c1 -ps`
            esac
        done
}

AcrobatPath=$2

TMP_DIR="/tmp/com.adobe.acrobat.DC"
browserinstalled="False"
# url encode it
encodedUrl=""
url_encode "$AcrobatPath"
BRANCH_NAME="DC"
BRANCH_NAME_LOWER_CASE=`echo "$BRANCH_NAME" | awk '{print tolower($0)}'`

# add appropriate prefix and suffix
        
AcrobatUrl="file://localhost$encodedUrl/Adobe%20Acrobat.app/"

if [ -e $TMP_DIR/acrobat.plist ]
then
	browserinstalled=`defaults read $TMP_DIR/acrobat WebBrowserInstalled`
    if [ $? -ne 0 ]; then
        browserinstalled="False"
    fi
fi

if [ $browserinstalled == "True" ]	#browser plug in installed
then
	# update the plist file if the plug-in version matches our version.
	if [ -e "/Library/Internet Plug-Ins/AdobePDFViewer.plugin/Contents/Info.plist" ]
	then
		updatePlistPath=0
		myMajor="22"
		myFirstMinor="002"
		mySecondMinor="20191"

		pluginVersion=`defaults read "/Library/Internet Plug-Ins/AdobePDFViewer.plugin/Contents/Info" CFBundleVersion`
		pluginMajor=`echo $pluginVersion | cut -d "." -f 1`
		
		if [ $pluginMajor -eq $myMajor ]
		then
			pluginFirstMinor=`echo $pluginVersion | cut -d "." -f 2`
			
			if [ $pluginFirstMinor -eq $myFirstMinor ]
			then
				pluginSecondMinor=`echo $pluginVersion | cut -d "." -f 3`
				
				if [ $pluginSecondMinor -eq $mySecondMinor ]
				then
					updatePlistPath=1
				fi
			fi
		fi

		if [ $updatePlistPath -eq 1 ]
		then
			echo "creating pdfviewer.plist for $AcrobatUrl"
			defaults write /Library/Preferences/com.adobe.acrobat.pdfviewer WebBrowserUsePath $AcrobatUrl
		else
			echo "Skipping update of pdfviewer.plist. Existing browser plug-in is of a mismatched version: $pluginVersion"
		fi
	fi

    /bin/rm "$TMP_DIR/acrobat.plist"
    /bin/rmdir "$TMP_DIR"

else
	# create the plist file for the browser plug-in
	defaults write $TMP_DIR/acrobat AcrobatInstallPath $AcrobatUrl
    defaults write $TMP_DIR/acrobat AcrobatInstallDir "$AcrobatPath"
	/bin/chmod -R 777 "$TMP_DIR"
fi

# AcroAppTool work (create Alias to the uninstaller app and change the icon of the application's parent folder)
mydir=`pwd`
myAlert="$mydir/Tools/AcroInstallAlert.app/Contents/MacOS/AcroInstallAlert"
Tool="$mydir/Tools/AcroAppTool.app/Contents/MacOS/AcroAppTool"
if [ -e $Tool ]
then

	if [ $COMMAND_LINE_INSTALL ]
	then
		installMode="CLIMode"
	else
		installMode="GUIMode"
	fi

	#creating alias for Uninstaller.app.
	aliasDestPath="$AcrobatPath""/"
	if [ -e "$aliasDestPath""Acrobat Uninstaller" ]
	then
		/bin/rm -rf "$aliasDestPath""Acrobat Uninstaller"
	fi

	orig_perms=`stat -f %p "$aliasDestPath" | cut -c 3-6`
	/bin/chmod 777 "$aliasDestPath"

	#format: AcroApp <Acrobat Path> "Alias" <Target Folder> <in Folder> <alias name>
	$Tool "$AcrobatPath" "Alias" "$AcrobatPath/Adobe Acrobat.app/Contents/Helpers/Acrobat Uninstaller.app" "$aliasDestPath" "Acrobat Uninstaller"

	retval=$?
	if [ $retval -ne 0 ]
	then
		echo "Error encountered while creating the Uninstaller alias, creating symlink..."
		#creating symbolic link for Uninstaller.app
		ln -sFf "$AcrobatPath/Adobe Acrobat.app/Contents/Helpers/Acrobat Uninstaller.app" "$aliasDestPath""Acrobat Uninstaller"
	
		if [ $? -ne 0 ]; then
        		echo "Error encountered while creating the Uninstaller symlink."
		fi
	fi

	/bin/chmod $orig_perms "$aliasDestPath"

	# changes the icon of the application's parent folder.
	$Tool "$AcrobatPath" "Icon" "$installMode"
	
	retval=$?
	if [ $retval -ne 0 ]
	then
		echo "Error encountered while changing the icon of Application folder $AcrobatPath"
	fi

else
	echo "cannot find $Tool. Installation failure"
	exit -1
fi


#if pdfadmin settings already exist on the system, merge into it, else just copy it to the correct location.
PDFADMIN_DOMAIN="com.adobe.PDFAdminSettings"
EXT="plist"
PREFERENCES_FOLDER="/Library/Preferences"
TMP_PLIST_FOLDER=`pwd`/Resources
MERGEPLIST_TOOL=`pwd`/Tools/mergeplists.py
FEATURELOCKDOWN_DOMAIN="com.adobe.Acrobat.Pro"
ACRO_PYTHON3_TOOL="/Library/Application Support/Adobe/Acrobat/Frameworks/Python3.framework/Versions/3.8/bin/python3"
PYTHON_MARKER_FILE="/Library/Application Support/Adobe/Acrobat/Frameworks/python_marker"

if [[ -e "$MERGEPLIST_TOOL" ]]
then
    if  use_acro_python ; 
    then
        "$ACRO_PYTHON3_TOOL" "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$PDFADMIN_DOMAIN.$EXT" -o "$PREFERENCES_FOLDER/$PDFADMIN_DOMAIN.$EXT" -k "AdobePDFSettings"
    else
        "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$PDFADMIN_DOMAIN.$EXT" -o "$PREFERENCES_FOLDER/$PDFADMIN_DOMAIN.$EXT" -k "AdobePDFSettings"
    fi
	
	if [[ $? -ne 0 ]]
	then
		echo "Could not install PDFAdminSettings"
		exit -1	
	fi

    if  use_acro_python ; 
    then
        "$ACRO_PYTHON3_TOOL" "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$PDFADMIN_DOMAIN.$EXT" -o "$PREFERENCES_FOLDER/$PDFADMIN_DOMAIN.$EXT" -k "AdobePDFSettingsPath"
    else
        "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$PDFADMIN_DOMAIN.$EXT" -o "$PREFERENCES_FOLDER/$PDFADMIN_DOMAIN.$EXT" -k "AdobePDFSettingsPath"
    fi

	if [[ $? -ne 0 ]]
	then
		echo "Could not install PDFAdminSettings"
		exit -1	
	fi

# Adding the ARM entry in /etc/defaults/AdobeARMOverrides.plist file and at /Library/Application Support/Adobe/ARMDC/AdobeARMOverrides.plist file

OVERRIDE_FOLDER_NEW="/Library/Application Support/Adobe/ARMDC"
OVERRID_FILE="AdobeARMOverrides"
TMP_OVERRID_FILE="$BRANCH_NAME_LOWER_CASE.ARMOverrides"

echo "Updating AdobeARMOverride.plist for $BRANCH_NAME_LOWER_CASE"
if [ -e "$TMP_PLIST_FOLDER/$TMP_OVERRID_FILE.$EXT" ]
then

    #Check if /Library/Application Support/Adobe/ARMDC folder exists. If not create it
    if [ ! -e "$OVERRIDE_FOLDER_NEW" ]
    then
        mkdir -pv "$OVERRIDE_FOLDER_NEW"
        retval=$?

        if [ $retval -ne 0 ]
        then
            echo "ERROR: Unable to create $OVERRIDE_FOLDER_NEW. Exiting "
            exitWithErrorCode -1
        fi
    fi

    echo "Creating AdobeARMOverride.plist file in $OVERRIDE_FOLDER_NEW"
    if  use_acro_python ; 
    then
        "$ACRO_PYTHON3_TOOL" "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$TMP_OVERRID_FILE.$EXT" -o "$OVERRIDE_FOLDER_NEW/$OVERRID_FILE.$EXT" -k "ARM"
    else
        "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$TMP_OVERRID_FILE.$EXT" -o "$OVERRIDE_FOLDER_NEW/$OVERRID_FILE.$EXT" -k "ARM"
    fi

    if [[ $? -ne 0 ]]
    then
    echo "ERROR: Could not update the AdobeARMOverride file."
    exit -1
    fi

    if  use_acro_python ; 
    then
        "$ACRO_PYTHON3_TOOL"  "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$TMP_OVERRID_FILE.$EXT" -o "$OVERRIDE_FOLDER_NEW/$OVERRID_FILE.$EXT" -k "com.adobe.ARMDCHelper"
    else
        "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$TMP_OVERRID_FILE.$EXT" -o "$OVERRIDE_FOLDER_NEW/$OVERRID_FILE.$EXT" -k "com.adobe.ARMDCHelper"
    fi

    if [[ $? -ne 0 ]]
    then
    echo "ERROR: Could not update the AdobeARMOverride file."
    exit -1
    fi

fi

if [[ -e  "$TMP_PLIST_FOLDER"/"$FEATURELOCKDOWN_DOMAIN"."$EXT" ]]
then
    if  use_acro_python ; 
    then
        "$ACRO_PYTHON3_TOOL" "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$FEATURELOCKDOWN_DOMAIN.$EXT" -o "$PREFERENCES_FOLDER/$FEATURELOCKDOWN_DOMAIN.$EXT" -k "DC"
    else
        "$MERGEPLIST_TOOL" -i "$TMP_PLIST_FOLDER/$FEATURELOCKDOWN_DOMAIN.$EXT" -o "$PREFERENCES_FOLDER/$FEATURELOCKDOWN_DOMAIN.$EXT" -k "DC"    
    fi

	if [[ $? -ne 0 ]]
	then
		echo "Could not install the featurelockdown plist"
		exit -1
    else
        echo "Successfully installed the featurelockdown plist."
        $Tool "$AcrobatPath" "WordAddInFeatureLockdown"

        retval=$?
        if [ $retval -ne 0 ]
        then
            echo "Error encountered while copying the WordAddin related featurelockdown keys to Word pref file"
        fi
    fi
fi

else
	echo "ERROR: Could not find the mergeplist tool, exiting."
	exit -1
fi


# Install the registration plist
AcrobatAppPath="$AcrobatPath/Adobe Acrobat.app"
ProductRegistrationPlistPath="/Library/Application Support/Adobe/ARMDC/Registered Products"
FeatureLockDownInstallPath="/Library/Application Support/Adobe/Acrobat/DC/Preferences"

if [ ! -e "$AcrobatAppPath" ]
then
    echo "ERROR: Application $AcrobatAppPath not found.  Installation failure."
    exitWithErrorCode 501
fi


echo "Info: Installing ProductRegistration plist.. "
if [ ! -e "$ProductRegistrationPlistPath" ]
then
    mkdir -pv "$ProductRegistrationPlistPath"
fi


mydir=`pwd`
productRegistrationPlist="$mydir/Resources/com.adobe.acrobat.$BRANCH_NAME_LOWER_CASE.plist"
serviceRegistrationPlist="$mydir/Resources/com.adobe.acrobat.servicesupdater.$BRANCH_NAME_LOWER_CASE.plist"
serviceRegistrationPlistDestname="com.adobe.acrobat.servicesupdater.$BRANCH_NAME_LOWER_CASE.plist"

if [ ! -e "$productRegistrationPlist" ]
then
    echo "The registration file for Acrobat could not be found. Cancelling installation..."
    exitWithErrorCode -1
fi

if [ ! -e "$serviceRegistrationPlist" ]
then
    echo "The registration file for Acrobat service could not be found. Cancelling installation..."
    exitWithErrorCode -1
fi

# write the acrobat install location to its product-registration plist and also in service updater product registration
sed -in "s|@INSTALL_DIR@|$AcrobatPath|g" $productRegistrationPlist
sed -in "s|@INSTALL_DIR@|$AcrobatPath|g" $serviceRegistrationPlist

cp -f "$productRegistrationPlist" "$ProductRegistrationPlistPath/"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install ProductRegistration plist for updates"
    exitWithErrorCode 506
fi

echo "Info: Installing FeatureLockDown file... "
if [ ! -e "$FeatureLockDownInstallPath" ]
then
    mkdir -pv "$FeatureLockDownInstallPath"
fi

FeatureLockDownFile="$mydir/Resources/FeatureLockDown"
cp -f "$FeatureLockDownFile" "$FeatureLockDownInstallPath/"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install FeatureLockDown file for updates"
    exitWithErrorCode 506
fi

cp -f "$serviceRegistrationPlist" "$ProductRegistrationPlistPath/$serviceRegistrationPlistDestname"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install Acrobat Service Registration plist for updates"
    exitWithErrorCode 506
fi


#set the default url handler
$myAlert "TitleAcrobat" "URLSchemeHandler"
retval=$?
if [ $retval -ne 0 ]
then
    echo "Something went wrong in setting the default url scheme handler"
fi

#TEMP

#Removing override from /etc/defaults folder

OVERRIDE_ETC_DEFAULTS="/etc/defaults/AdobeARMOverrides.plist"
if [  -e "$OVERRIDE_ETC_DEFAULTS" ]
then
    echo "TEMP:: Removing override from /etc/defaults folder"
    rm -f "$OVERRIDE_ETC_DEFAULTS"
    retval=$?
    if [ $retval -ne 0 ]
    then
        echo "Unable to remove override from /etc/defaults folder."
    fi
fi

#TEMP

### Enable verbose logging for Beta track

if [ $BRANCH_NAME_LOWER_CASE == "beta" ]
then

USER_NAME=`last -1 | cut -d " " -f 1`

if [ -e "/Users/$USER_NAME/Library/Preferences" ]
then
    echo "Enabling verbose logging for $USER_NAME "

    defaults write "/Users/$USER_NAME/Library/Preferences/com.adobe.ARMDC.plist" LogLevel -int 1
    defaults write "/Users/$USER_NAME/Library/Preferences/com.adobe.ARMDCHelper.plist" LogLevel -int 1

    chown $USER_NAME "/Users/$USER_NAME/Library/Preferences/com.adobe.ARMDC.plist"
    chown $USER_NAME "/Users/$USER_NAME/Library/Preferences/com.adobe.ARMDCHelper.plist"
else
    echo "Could not find the user name of the current user. Not enabling the verbose logging"
fi

fi

###

echo "SUCCESS: Postinstall exited with error code 0."
exit 0
