#!/bin/bash

installation_path=$2

function exitWithErrorCode
{
rm -rf $installation_path
echo "ERROR: Preinstall exited with error code $1."
exit $1
}

function verifyOwnershipOfDirectory
{
    directoryPath=$1
    INFO=( $(stat -L -f "%Sp %u"  $directoryPath) )
    
    PERM=${INFO[0]}
    OWNER=${INFO[1]}
    othersWritePerm=$(echo $PERM | cut -c 9)
    if ([[ $OWNER -ne 0 || $othersWritePerm == "w" ]])
    then
        echo "ERROR: Installation directory $directoryPath has unexpected ownerships"
        exitWithErrorCode -1
    fi

}

mydir=`pwd`
myTool="$mydir/Tools/ARMInstallTool"

if [ ! -e $myTool ]
then
	echo "ERROR: $myTool does not exist. Installation failure."
	exitWithErrorCode -1
fi

timeout=20	# This is the timeout for which running app will be checked
interval=2    # This is the interval at which running app will be checked repeatedly until timeout occurs or the app is found not running
helperBinaryName="Acrobat Update Helper"
helperBundleID="com.adobe.ARMDCHelper"

#Run the ARMInstallTool to check if the Acrobat Update Helper.app is already running.
echo "Checking if $helperBinaryName is running"

$myTool CheckAppRunning "$helperBinaryName" "$helperBundleID" $timeout $interval
retval=$?		

if [ $retval -eq 1 ]	#if the Acrobat Update Helper.app was not stopped till timeout
then
	echo "Acrobat Update Helper was found running. Cannot proceed.."
	exitWithErrorCode -1
fi

if [ $retval -eq 255 ]	#Denotes error in passing arguments
then
	echo "Error in parsing arguments. The arguments passed are CheckAppRunning $helperBinaryName $helperBundleID $timeout $interval"
	exitWithErrorCode -1
fi

installation_path=$2
rm -rf "$installation_path"

if [ ! -e "$installation_path" ]
then
    mkdir "$installation_path" # do not use with -p so to that we get error if folder somehow exists.
    if [ $? -ne 0 ]; then
        echo "ERROR: Installation directory cannot be created. Installation failure."
        exitWithErrorCode -1
    fi
    chmod go= "$installation_path" # remove all permissions for group members and world.
    verifyOwnershipOfDirectory "$installation_path" # should be owned by root(uid=0) and others should have no write permission over it.
    rm -rf "$installation_path/*"   # make sure that the folder is empty
    if [ $? -ne 0 ]; then
           echo "ERROR: Installation directory cannot be emptied. Installation failure."
           exitWithErrorCode -1
    fi
else
    echo "ERROR: Installation directory $installation_path already exists. Installation failure."
    exitWithErrorCode -1
fi

exit 0
