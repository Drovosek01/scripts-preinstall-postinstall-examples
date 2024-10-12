#!/bin/bash -x
#
# This script checks if the ASC installed on a user machine
# has a higher version number that the one in the installer
#
# return value:
# 0: asc is up-to-date
# 1: asc is not up-to-date
# -1: there was an error
#

version_in_installer="2.5.0.2193"

#From http://stackoverflow.com/questions/4023830/bash-how-compare-two-strings-in-version-format
# Compare 2 version number
# if $1 = $2,return 0
# if $1 > $2,return 1
# if $1 < $2,return 2
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

if [[ -f "/Applications/Arturia/Arturia Software Center.app/Contents/Info.plist" ]]; then
    #get installed version from plist
    version_on_machine="`defaults read /Applications/Arturia/Arturia\ Software\ Center.app/Contents/Info.plist CFBundleVersion`"
    vercomp ${version_on_machine} ${version_in_installer}
    if [[ $? -eq 2 ]]; then
        #version in installer is higher, not up to date
        exit 1
    else
        #ASC is already installed with the same or a higher version
        #Check that the program data exists
        if [[ -d "/Library/ArturiaSC/Arturia Software Center" ]]; then
            #Up to date and data exists. No need to reinstall
            exit 0
        else
            #program data doesn't exist, must re-install
            exit 1
        fi
   	 fi
else
    # ASC not installed
    exit 1
fi
