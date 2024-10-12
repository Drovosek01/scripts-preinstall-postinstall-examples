#!/bin/sh

function getDirAbsolute()
{
	pushd . > /dev/null
	if [ -d "${1}" ]; then
		cd "${1}"
	fi
	pwd
	popd > /dev/null
}


function shutdownAdSSO()
{

	local apppath=`/usr/bin/mdfind -onlyin "/Library/Application Support/Autodesk/" "kMDItemCFBundleIdentifier == '${1}'"`
	if [ ! -z "${apppath}" ];
	then
		echo "AdSSO Installation Detected at ${apppath}"
		local executable=`find "${apppath}/Contents/MacOS" -name AdSSO* -print`
		if [ ! -z "${executable}" ];
		then
			"${executable}" --quit
		fi
	fi
}

thisScriptDir="`getDirAbsolute \`dirname \"${0}\"\``"
thisScriptDir=${thisScriptDir:="."}

productname="AdSSO-v2"
x=`ps acwwwxu | grep "${productname}"`

if [ ! -z "${x}" ];
then
	echo "AdSSO Running"
	shutdownAdSSO "com.autodesk.AdSSO-v2"
	exit 1
fi

exit 0