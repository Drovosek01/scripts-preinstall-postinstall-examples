#!/bin/bash

oldInstallDir="/Library/HQServer"
installDir="/Library/HQueueServer"
sourceDir=${installDir}
plistFile="com.sidefx.hqserver.plist"
hqserverPlist="/Library/LaunchDaemons/${plistFile}"
PY_VER=3.11
pythonFramework="${installDir}/Frameworks/Python.framework/Versions/${PY_VER}"
python="${pythonFramework}/bin/python3"

# In case an old HQueue installation needs to be backed up.
parentDir="$(dirname "$installDir")"
baseName="$(basename "$installDir")"
currentDateTime=`date +"%Y-%m-%d_%T"`
backupDir="${parentDir}/${baseName}.${currentDateTime}.bak"

# Set paths required to run the Python binary contained in HQueue.
export DYLD_LIBRARY_PATH="${pythonFramework}:${DYLD_LIBRARY_PATH}"

stopHQ()
{
    if [ -f "${hqserverPlist}" ]; then
        echo "Stopping HQueue Server..."
        launchctl unload -F "${hqserverPlist}" &> /dev/null
    fi
}

backupOldHQ()
{
    if [ -d "${oldInstallDir}" ]; then
	echo ""
	echo "Backing up old HQueue Server installation..."

	# Move old HQueue installation to backup directory.
	sudo mv "${oldInstallDir}" "${backupDir}"
    fi
}

installHQ()
{
    echo "Installing HQueue files..."

    # Unpack the HQueue tarball.
    cd "${installDir}"
    tar xzvf hqueue.tar.gz

    sudo mkdir -p "${installDir}/job_logs"
    sudo mkdir -p "${installDir}/db"
    hqroot="${installDir}/hqserver"
    sudo ${python} ${hqroot}/manage.py makeconfig
    sudo ${python} ${hqroot}/manage.py migrate

    if [ -d "${backupDir}" ]; then
	sudo ${python} ${hqroot}/manage.py port "${backupDir}"
    fi

    # Change the log file path in the configuration file.
    sed -i "" \
	"s:file.*=.*hqserver.log:file = /Library/Logs/HQueueServer/hqserver.log:g" \
	"${installDir}/hqserver.ini"
    mkdir -p /Library/Logs/HQueueServer

    # Backup existing HQueue Server plist file if it is the old
    # HQueue Python 2 plist file.
    if [ -f "${hqserverPlist}" ]; then
	grep -q paster "${hqserverPlist}"
	if [ $? = 0 ]; then
	    sudo cp ${hqserverPlist} ${hqserverPlist}.${currentDateTime}.bak
	fi
    fi

    # Install the launchd plist file.
    sed "s:%%INSTALL_DIR%%:${installDir}:g" "${installDir}/${plistFile}" \
	> "${hqserverPlist}"
    sed -i "" "s:%%PYTHON_FRAMEWORK%%:${pythonFramework}:g" ${hqserverPlist}
}

startHQ()
{
    echo "Starting HQueue..."

    cd "${installDir}"

    # Start HQueue.
    launchctl load -F ${hqserverPlist} &> /dev/null

    if [ $? != 0 ]; then
	echo "
	Failed to start the HQueue server.
	"
	$? = 0
    else
	echo "
	Successfully installed HQueue.  The server is now running.
	To view the HQueue interface, go to 
	    http://localhost:5000
	"
    fi
}

cleanUp()
{
    # Remove installation tarball.
    rm -rf "${installDir}/hqueue.tar.gz"

    # Remove plist template file.
    rm -f "${installDir}/${plistFile}"
}

stopHQ
backupOldHQ
installHQ
startHQ
cleanUp

echo "Done Installing HQueue Server"

exit 0

