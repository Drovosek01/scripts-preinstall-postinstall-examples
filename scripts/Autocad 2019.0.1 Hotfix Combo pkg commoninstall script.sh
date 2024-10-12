#!/bin/bash

shopt -s nocasematch

strtrim()
{
    trimmedStr=$(echo $* | xargs)
    echo "$trimmedStr"
}

strindex()
{
    if [[ "$1" == "$2" ]]; then
        echo 0
    else
        x="${1%%$2*}"
        [[ $x = $1 ]] && echo -1 || echo ${#x}
    fi
}

if [ -e "/tmp/AdSSO.trace" ]; then
    export ADSSO_TRACE=1
fi

consoleLog()
{
# uncomment to get messages in console log
# export ADSSO_TRACE=1

    if [[ ! -z "$ADSSO_TRACE" ]]; then
        syslog -s -k Facility com.apple.console Level Error Sender AdSSOPackageInstaller Message "$*"
    fi
    echo AdSSOPackageInstaller: $*
}

appendPath()
{
    path=$1
    file=$2
    sep=$(echo "${path: -1}")
    if [ "$sep" != "/" ]; then
        path="$path/"
    fi
    echo ${path}${file}
}

appendAdSSOAppPath()
{
    path=$1
    file=`basename "$path"`
    adSSOAppName="AdSSO-v2.app"
    if echo "$file" | grep -iq "$adSSOAppName"; then
        path=$1
    else
        path=$(appendPath "$1" "$adSSOAppName")
    fi
    echo $path
}
consoleLog $*
export AdSSOInstallDIR=$(strtrim "$3")
export CurrentAdSSO=$(appendAdSSOAppPath "$AdSSOInstallDIR")

consoleLog Install path is "'$AdSSOInstallDIR'"

ternimateAdSSOProcessRunningFromPath()
{
    adSSOPath=`ps -ef | grep -v grep | grep -i "$1" | awk '{out=""; for(i=8;i<=NF;i++){out=out" "$i}; print out}'`
    IFS=$'\n' adSSOPath=($adSSOPath)
    if [[ ! -z $adSSOPath ]]; then
        listUSer=$(who | cut -d' ' -f1 | sort | uniq)
        IFS=$'\n' listUSer=($listUSer)
        filename=`defaults read "$1/Contents/Info" CFBundleName`
        runningAdSSOPath="$1/Contents/MacOS/$filename"
        runningAdSSOPath=$(strtrim "$runningAdSSOPath")
        consoleLog "terminating AdSSO running from $runningAdSSOPath"
        for key in "${!listUSer[@]}"; do
            user=${listUSer[$key]}
            if [ -d "/Users/$user" ]; then
                sudo -u "$user" "${runningAdSSOPath}" --quit
            fi
        done
    fi
}

terminateCurrentInstalledProcess()
{
    ternimateAdSSOProcessRunningFromPath "$CurrentAdSSO"
}


preinstall()
{
    terminateCurrentInstalledProcess

    # Rename old AdSSO - version check will be done in postisntall
    if [ -e "$CurrentAdSSO" ]; then
        mv -f "$CurrentAdSSO" "$CurrentAdSSO.old"
    fi
}

getBundleVersion()
{
    bundleVersion=""
    if [ -f "$1/Contents/Info.plist" ]; then
        bundleVersion=`defaults read "$1/Contents/Info" CFBundleVersion`
    fi
    echo "$bundleVersion"
}

comapreVersion()
{
    result=0
    v1="$1"
    IFS=$'.' v1=($v1)
    v2="$2"
    IFS=$'.' v2=($v2)
    if [[ -z $v1 ]]; then
        if [[ ! -z $v2 ]]; then
            result=-${v2[0]}
        fi
    fi
    for key in "${!v1[@]}"; do
        result=${v1[$key]}
        v22=${v2[$key]}
        if [[ -z $v22 ]]; then
            break
        fi
        result=$(expr $result - $v22)
        if [ $result -ne 0 ]; then
            break
        fi
    done
    echo "$result"
}

postinstall()
{
    if [ -d "$CurrentAdSSO.old" ]; then
        oldVersion=$(getBundleVersion "$CurrentAdSSO.old")
        newVersion=$(getBundleVersion "$CurrentAdSSO")
        result=$(comapreVersion "$newVersion" "$oldVersion")
        # check if this is higer version
        if [ $result -ge 0 ] && [ -d "$CurrentAdSSO" ]; then
            # delete old version
            consoleLog "removing old version of AdSSO"
            rm -rf "$CurrentAdSSO.old"
        else
            # remove new app as it is lower version and restore higher version app
            consoleLog "Installed version of AdSSO is already higher - restoring it back"
            rm -rf "$CurrentAdSSO"
            mv -f "$CurrentAdSSO.old" "$CurrentAdSSO"
        fi
    fi
}

main()
{
if [ "$1" == "preinstall" ]; then
    preinstall
else
    postinstall
fi
}

main "$1"


exit 0