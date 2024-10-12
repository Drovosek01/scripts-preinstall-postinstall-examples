#!/bin/bash

###########################################################################################
# Do not touch next line, it is auto updated by the build process.
# It will contain the installer version.
# It must be of format x.y.zz
MY_VERSION="1.1.7"
###########################################################################################

finalInstallationRoot="/Library/Application Support/Adobe/ARMDC/Application"
regPlistInstallationFolder="/Library/Application Support/Adobe/ARMDC/Registered Products"
helperAppName="Acrobat Update Helper.app"
helperUninstallerName="AcrobatUpdaterUninstaller"
containerName="Adobe Acrobat Updater.app"
libName="AcrobatUpdateHelperLib.dylib"
tempInstallRoot=$2
backupFolderName="Backup"
mydir=`pwd`
EDIT_REG_PLIST_FOR_HTTPS_CHANGE=1

function exitWithErrorCode
{
    echo "ERROR: Postinstall exited with error code $1."
    rm -rf $tempInstallRoot
    exit $1
}

function MoveContentsToBackup
{
    if [ ! -e "$tempInstallRoot/$backupFolderName" ]
    then
        exitWithErrorCode -1
    fi
    bundleName=$1
    newBundleName="$bundleName"
    baseName=`echo $bundleName | cut -d "." -f 1`
    extension=`echo $bundleName | cut -d "." -f 2`

    counter=1
    max_iteration=10

    if [ ! -e "$finalInstallationRoot/$bundleName" ]
    then
        return
    fi

    while [[ $counter -lt $max_iteration ]]
    do
        if [ -e "$tempInstallRoot/$backupFolderName/$newBundleName" ]
        then
            echo "$newBundleName exists in Backup folder. Retrying with a new name."
            sleep 1
            time_to_be_attached=`date "+%k-%M-%S"`
            newBundleName="$baseName""$time_to_be_attached"".$extension"
        else
            echo "Moving existing $bundleName to Backup as $newBundleName"
            mv "$finalInstallationRoot/$bundleName" "$tempInstallRoot/$backupFolderName/$newBundleName"
            if [ $? -ne 0 ]
            then
                echo "ERROR: Could not move existing $bundleName to Backup."
                exitWithErrorCode -1
            fi
            break
        fi
        counter=$((counter+1))
    done
}


myMajor=`echo $MY_VERSION | cut -d "." -f 1`
myFirstMinor=`echo $MY_VERSION | cut -d "." -f 2`
mySecondMinor=`echo $MY_VERSION | cut -d "." -f 3`

installed_version_higher="true"

installedVersion="0.0.0"

# Step 1 : Installing updater app at /Library/Application Support/Adobe/ARMDC/Application
##########

# Try to get the ARM Helper App existing version, and check whether need to update or not
if [ -e "$finalInstallationRoot/$helperAppName" ]
then
    if [ ! -e "$finalInstallationRoot/$helperAppName/Contents/Info.plist" ]
    then
        echo "ARM Helper not installed or curruped, will try to reinstall."
        installed_version_higher="false"
    else
        installedVersion=`defaults read "$finalInstallationRoot/$helperAppName/Contents/Info" CFBundleVersion`
        major=`echo $installedVersion | cut -d "." -f 1`
        firstMinor=`echo $installedVersion | cut -d "." -f 2`
        secondMinor=`echo $installedVersion | cut -d "." -f 3`

        if [ $major -eq $myMajor ]
        then
            if [ $myFirstMinor -eq $firstMinor ]
            then
                if [ $mySecondMinor -eq $secondMinor ]
                then
                    installed_version_higher="true"

                else
                    if [ $mySecondMinor -lt $secondMinor ]
                    then
                        installed_version_higher="true"
                    else
                        installed_version_higher="false"
                    fi
                fi
            else
                if [ $myFirstMinor -lt $firstMinor ]
                then
                    installed_version_higher="true"
                else
                    installed_version_higher="false"
                fi
            fi
        else
            if [ $myMajor -lt $major ]
            then
                installed_version_higher="true"
            else
                installed_version_higher="false"
            fi
        fi
    fi

    # Creating backup of installed files.
    if [ $installed_version_higher == "true" ]
    then
        echo "Existing $helperAppName at $finalInstallationRoot has a higher or equal version: $installedVersion. Skipping installation of files."
        rm -rf $tempInstallRoot
        exit 0
    else
        echo "Existing $helperAppName at $finalInstallationRoot has a lower version: $installedVersion. Moving it to backup folder."
        if [ ! -e "$tempInstallRoot/$backupFolderName" ]
        then
        mkdir -p "$tempInstallRoot/$backupFolderName"
        fi
        MoveContentsToBackup "$helperAppName"
		MoveContentsToBackup "$helperUninstallerName"
        MoveContentsToBackup "$containerName"
        MoveContentsToBackup "$libName"
    fi
fi


#Installing files to the required location

echo "Info: Installing updater files..."

updaterSrc="$tempInstallRoot/$helperAppName"
helperUninstallerSrc="$tempInstallRoot/$helperUninstallerName"
containerSrc="$tempInstallRoot/$containerName"
libSrc="$tempInstallRoot/$libName"

updaterDest="$finalInstallationRoot/$helperAppName"
helperUninstallerDest="$finalInstallationRoot/$helperUninstallerName"
containerDest="$finalInstallationRoot/$containerName"
libDest="$finalInstallationRoot/$libName"

installation_PrivilegedHelperToolsPath="/Library/PrivilegedHelperTools"
installation_LaunchDaemonPath="/Library/LaunchDaemons"

if [ ! -e "$updaterSrc" ] || [ ! -e "$helperUninstallerSrc" ] || [ ! -e "$containerSrc" ] || [ ! -e "$libSrc" ]
then
    echo "The files could not be installed correctly. Stopping..."
    exitWithErrorCode -1
fi

if [ ! -e "$finalInstallationRoot" ]
then
    mkdir -p "$finalInstallationRoot"
    chmod o+rx "$finalInstallationRoot"
fi

if [ ! -e "$finalInstallationRoot" ]
then
    echo "The destaination folder could not be created. Cancelling installation..."
    exitWithErrorCode -1
fi

echo "    Installing asset $updaterDest"
ditto -v "$updaterSrc" "$updaterDest"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install ARM Helper app."
    exitWithErrorCode -1
fi

echo "    Installing asset $helperUninstallerDest"
mv -f "$helperUninstallerSrc" "$helperUninstallerDest"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install ARM Helper uninstaller"
    exitWithErrorCode -1
fi

echo "    Installing asset $containerDest"
ditto -v "$containerSrc" "$containerDest"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install ARM container."
    exitWithErrorCode -1
fi

echo "    Installing asset $libDest"
mv -f "$libSrc" "$libDest"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install ARM Helper library"
    exitWithErrorCode -1
fi

# Step 2 : Installing registration plist of product at /Library/Application Support/Adobe/ARMDC/Registered Products
##########

#Make folder to keep the registration plist of products.

if [ ! -e "$regPlistInstallationFolder" ]
then
    mkdir -p "$regPlistInstallationFolder"
    chmod o+rx "$regPlistInstallationFolder"
fi

if [ ! -e "$regPlistInstallationFolder" ]
then
    echo "The destination folder for registration plist could not be created. Cancelling installation..."
    exitWithErrorCode -1
fi

# Step 3 : Creating registration file and product info file for ARMDC Agent self update in /Library/Application Support/Adobe/ARMDC/Registered Products folder and /Library/Application Support/Adobe/ARMDC/Application respectively.
##########

regPlistARMNextName="com.adobe.ARMDCHelper.plist"
regPlistARMNextSrc="$mydir/Tools/$regPlistARMNextName"
regPlistARMNextDst="$regPlistInstallationFolder/$regPlistARMNextName"

echo "Info: Installing ARMDC Agent update registration file..."

if [ ! -e "$regPlistARMNextSrc" ]
then
    echo "The registration file for ARMDC Agent could not be found. Cancelling installation..."
    exitWithErrorCode -1
fi

# use cp instead of mv - ADC-4293442.
echo "    Installing file $regPlistARMNextDst"
cp -f "$regPlistARMNextSrc" "$regPlistARMNextDst"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install registration file for ARMDC Agent. "
    exitWithErrorCode -1
fi

productInfoARMNextName="com.adobe.ARMDCProductInfo.plist"
productInfoARMNextDst="$finalInstallationRoot/$productInfoARMNextName"

echo "Info: Installing ARMDC Agent update product info file..."

if [ -e "$productInfoARMNextDst" ]
then
    echo "The product info file for ARMDC Agent already exists."
    iRandomValue=`/usr/libexec/PlistBuddy -c "Print :iRandom" "$productInfoARMNextDst"`
    retval=$?
    if [[ $iRandomValue -ge 1  && $iRandomValue -le 10000 ]]
    then
        echo "iRandom key exists and value in range."
    else
        iRandomValue=$(($RANDOM%10000+1))
        if [ $retval -ne 0 ]
        then
            echo "iRandom key does not exist. Creating..."
            /usr/libexec/PlistBuddy -c "Add :iRandom integer $iRandomValue" "$productInfoARMNextDst"
            retval=$?
            if [ $retval -ne 0 ]
            then
                echo "ERROR: Unable to create iRandom key in product info file for ARMDC Agent. "
            fi
        else
            echo "iRandom value not in range. Setting new value..."
            /usr/libexec/PlistBuddy -c "Set :iRandom $iRandomValue" "$productInfoARMNextDst"
            retval=$?
            if [ $retval -ne 0 ]
            then
                echo "ERROR: Unable to set new iRandom value in product info file for ARMDC Agent. "
            fi
        fi
    fi
else
    iRandomValue=$(($RANDOM%10000+1))
    /usr/libexec/PlistBuddy -c "Add :iRandom integer $iRandomValue" "$productInfoARMNextDst"
    
    retval=$?
    if [ $retval -ne 0 ]
    then
        echo "ERROR: Unable to install product info file for ARMDC Agent. "
    fi
fi

# Step 4 : Checking prerequisites for installing SMJobBless and Communicator at /Library/PrivilegedHelperTools
##########

toolName_SMJobBlessHelper="com.adobe.ARMDC.SMJobBlessHelper"
toolName_Communicator="com.adobe.ARMDC.Communicator"

echo "Info: Installing HelperTools..."

if [ ! -e "$containerSrc" ]
then
    echo "ERROR: Temp folder containing helper tools not found.  Installation failure."
    exitWithErrorCode -1
fi

if [ ! -e "$containerSrc/Contents/Library/LaunchServices/$toolName_SMJobBlessHelper" ]
then
    echo "ERROR: The updater helper tool missing.  Installation failure."
    exitWithErrorCode -1
fi

if [ ! -e "$containerSrc/Contents/Library/LaunchServices/$toolName_Communicator" ]
then
    echo "ERROR: The updater communicator tool missing.  Installation failure."
    exitWithErrorCode -1
fi


if [ ! -e "$containerSrc/Contents/Library/LaunchServices/SMJobBlessHelper-Launchd.plist" ]
then
    echo "ERROR: The updater helper tool plist missing.  Installation failure."
    exitWithErrorCode -1
fi

if [ ! -e "$containerSrc/Contents/Library/LaunchServices/ARMNextCommunicator-Launchd.plist" ]
then
    echo "ERROR: The updater communicator tool plist missing.  Installation failure."
    exitWithErrorCode -1
fi

if [ ! -e "$installation_PrivilegedHelperToolsPath" ]
then
    mkdir -pv "$installation_PrivilegedHelperToolsPath"
fi

if [ ! -e "$installation_LaunchDaemonPath" ]
then
    mkdir -pv "$installation_LaunchDaemonPath"
fi

# Killing com.adobe.ARM.SMJobBlessHelper and com.adobe.ARM.Communicator if they are already running..
# Intentionally not verifying the return status of kill command. We will not stop the installation in case it fails.

PID_Communicator=`ps -ef | grep -v grep | grep -i "$installation_PrivilegedHelperToolsPath/$toolName_Communicator" | awk '{print $2}'`

#Checking that PID is non zero and a number
if [[ ! -z "$PID_Communicator" ]] && [ "$PID_Communicator" -eq "$PID_Communicator" > /dev/null 2>&1  ]
then
kill -9 "$PID_Communicator"
fi

PID_SMJobBlessHelper=`ps -ef | grep -v grep | grep -i "$installation_PrivilegedHelperToolsPath/$toolName_SMJobBlessHelper" | awk '{print $2}'`

#Checking that PID is non zero and a number
if [[ ! -z "$PID_SMJobBlessHelper" ]] && [ "$PID_SMJobBlessHelper" -eq "$PID_SMJobBlessHelper" > /dev/null 2>&1 ]
then
kill -9 "$PID_SMJobBlessHelper"
fi

# Step 5 : Install the privileged tools in the system. Installing SMJobBless and Communicator at /Library/PrivilegedHelperTools
##########

echo "    Installing $toolName_SMJobBlessHelper"
mv -f "$containerSrc/Contents/Library/LaunchServices/$toolName_SMJobBlessHelper" "$installation_PrivilegedHelperToolsPath/"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install Helper tool for updates"
    exitWithErrorCode -1

fi

echo "    Installing $toolName_Communicator"
mv -f "$containerSrc/Contents/Library/LaunchServices/$toolName_Communicator" "$installation_PrivilegedHelperToolsPath/"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to install communicator tool for updates"
    exitWithErrorCode -1
fi


chmod 544 "$installation_PrivilegedHelperToolsPath/$toolName_SMJobBlessHelper"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to set permissions of Helper tool"
    exitWithErrorCode -1
fi

chmod 544 "$installation_PrivilegedHelperToolsPath/$toolName_Communicator"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to set permissions of communicator tool"
    exitWithErrorCode -1
fi


# Step 6 : Installing the plist required by SMJoblBless and Communicator at /Library/LaunchDaemons
##########
echo "Info: Installing HelperTool plists..."

mv -f "$containerSrc/Contents/Library/LaunchServices/SMJobBlessHelper-Launchd.plist" "$installation_LaunchDaemonPath/com.adobe.ARMDC.SMJobBlessHelper.plist"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to create daemon for the auto updates"
    exitWithErrorCode -1
else
    launchctl load "$installation_LaunchDaemonPath/com.adobe.ARMDC.SMJobBlessHelper.plist"
fi

mv -f "$containerSrc/Contents/Library/LaunchServices/ARMNextCommunicator-Launchd.plist" "$installation_LaunchDaemonPath/com.adobe.ARMDC.Communicator.plist"
retval=$?
if [ $retval -ne 0 ]
then
    echo "ERROR: Unable to create daemon for the auto updates"
    exitWithErrorCode -1
else
    launchctl load "$installation_LaunchDaemonPath/com.adobe.ARMDC.Communicator.plist"
fi



# Step 7 : Creating the scheduler
##########
myTool="$mydir/Tools/ARMInstallTool"

if [ ! -e $myTool ]
then
    echo "ERROR: $myTool does not exist. Installation failure."
    exitWithErrorCode -1
fi

#Run the ARMInstallTool to create the scheduler
$myTool CreateScheduler

retval=$?

if [ $retval -eq 1 ]	#Failed to create the scheduler
then
    echo "Failed to create the scheduler"
    exitWithErrorCode -1
fi

#Modifying the registration files in /Library/Application Support/Adobe/ARMDC/Registered Products folder to https and moving to /Library/Application Support/Adobe/ARMDC/Registered Products folder

if [ $EDIT_REG_PLIST_FOR_HTTPS_CHANGE -eq 1 ]
then
    $myTool ModifyRegFiles
    retval=$?

    if [ $retval -ne 0 ]
    then
        echo "Failed to modify files at path /Library/Application Support/Adobe/ARMDC/Registered Products"
        exitWithErrorCode -1;
    fi
fi

echo "Installation successful"


# Step 8 : Cleaning the temp install location
##########

rm -rf $tempInstallRoot

# Step 9 : Cleanup Old installed copy of ARMDC
##########

cleanerTool="$mydir/Tools/AcrobatUpdaterUninstaller"
cleanerFileList="$mydir/Tools/cleanupFileList.txt"

if [ ! -e $cleanerTool ]
then
    echo "WARNING: $cleanerTool does not exist. Cleanup operation skipped."
exit 0
fi

if [ ! -e $cleanerFileList ]
then
    echo "WARNING: $cleanerFileList does not exist."
fi

$cleanerTool "com.adobe.ARM.31012015"   # Actually run the cleaner tool
retval=$?

if [ $retval -eq 1 ]
then
    echo "WARNING:  $cleanerTool returned [ $retval ]"
fi
# Cleanup done

###########
# ALL DONE
###########

echo "SUCCESS: Postinstall exited with error code 0."
exit 0
