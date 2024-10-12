#!/bin/bash
#
# The Following variables are available in this script as per Apple Documentation
# http://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/SoftwareDistribution/Install_Operations/Install_Operations.html
#
# $1: Full path to the installation package the Installer application is processing.
# $2: Full path to the installation destination
# $3: Installation volume (or mountpoint) to receive the payload
# $4: The root directory for the system:
# $SCRIPT_NAME: Filename of the operation executable
# $PACKAGE_PATH: Full path to the installation package
# $INSTALLER_TEMP: Scratch directory used by Installer to place its temporary work files
# $RECEIPT_PATH: Full path to a temporary directory containing the operation executable

function getDirAbsolute()
{
	pushd . > /dev/null
	if [ -d "${1}" ]; then
		cd "${1}"
	fi
	pwd
	popd > /dev/null
}

thisScriptDir="`getDirAbsolute \`dirname \"${0}\"\``"
thisScriptDir=${thisScriptDir:="."}

export UnixDefaultsCmd="/usr/bin/defaults"

export VERSION_PLIST="${thisScriptDir}/VerTarget"

export UPDATE_VERSION=`${UnixDefaultsCmd} read "${VERSION_PLIST}" UpdateVersion`

export RUNAS="/usr/bin/sudo -u $USER"

export installLocation="${2}"

function updateAppIcon() 
{
    local appPath="${1}"
    if [ "1" == "0" ] && [ -d "${appPath}" ];
    then
        echo "Update application icon!"
        find /private/var/folders/ -name com.apple.dock.iconcache -exec rm {} \;
        killall -TERM Dock
    else
        echo "No need to update the applicaiton icon!"
    fi   
}

function applyPatch()
{
    local PRODUCT_MAPPING="/tmp/_adsk_${UPDATE_VERSION}/acupdt_rone"
    if [ ! -L "${PRODUCT_MAPPING}" ]; 
    then
        echo "The product mapping link does not exist!!"
        exit 1
    fi

    local ACAD_RealPath=`readlink - n ${PRODUCT_MAPPING}`
    local oldBundleIdentifier=`${UnixDefaultsCmd} read "${ACAD_RealPath}/Contents/Info.plist" CFBundleIdentifier`
    local ACAD_RootPath=`dirname "${ACAD_RealPath}"`
    echo "The root path of product is ${ACAD_RootPath}!"
    if [ "${ACAD_RootPath}" != "/Applications/Autodesk/AutoCAD 2019" ]; then
        echo "The ACAD_RootPath is not correct!"
        rm -rf "/tmp/_adsk_${UPDATE_VERSION}"
        exit 1
    fi
    echo "starting ......"
    local tempFullDataDir="${installLocation}"
    echo "The files is in ${tempFullDataDir}" 
    if [[ ! -d "${tempFullDataDir}" ]]; then
        echo "Can't get the full data!"
        rm -rf "/tmp/_adsk_${UPDATE_VERSION}"
        exit 1
    fi

    local tempOldDataDir="`mktemp -d -t tempolddata`"
    echo "moving the old data to ${tempOldDataDir}"
    mv -f "${ACAD_RootPath}/"*  "${tempOldDataDir}"
    if [ $? -ne 0 ];
    then
        echo "Can't move the old data!"
        rm -rf "${tempOldDataDir}"
        rm -rf "${tempFullDataDir}"
        rm -rf "/tmp/_adsk_${UPDATE_VERSION}"
        exit 1
    fi

    echo "moving the new data to ${ACAD_RootPath}"
    mv -f "${tempFullDataDir}/"*  "${ACAD_RootPath}"
    if [ $? -ne 0 ];
    then
        echo "Can't move the new data!"
        rm -rf "${ACAD_RootPath}"/*
        echo "Restore the old data!"
        mv -f "${tempOldDataDir}/"*  "${ACAD_RootPath}"

        rm -rf "${tempOldDataDir}"
        rm -rf "${tempFullDataDir}"
        rm -rf "/tmp/_adsk_${UPDATE_VERSION}"
        exit 1
    fi

    sudo chown -R root:wheel "${ACAD_RootPath}"
    sudo chmod -R 755 "${ACAD_RootPath}"

    updateAppIcon "${ACAD_RealPath}"

    rm -rf "${tempOldDataDir}"
    rm -rf "${tempFullDataDir}"
    rm -rf "/tmp/_adsk_${UPDATE_VERSION}"
    echo "Apply the patch successfully!"
    exit 0
}

applyPatch
