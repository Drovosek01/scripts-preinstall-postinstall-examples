#!/bin/bash
function func_CheckAndInstallPlugin()
{
  currDir="$PWD"
  auxAppPluginInstalled=0
  `"$(dirname -- "$0")/dxo-test-prop.sh" "${propFilePath}" "${checkedPropName}"`
  if [ "$?" -eq "1" ]; then
    if [ -d "${progName}" ]; then
      echo "Adobe ${progName} installed. Install plugin for Adobe Photoshop ${progName}.";
      if [ ! -z "${photoshopPluginDestDir}" ]; then
        installDir="${appSupportDir}${pluginsDir}${progName}/DxO FilmPack 5"
        if [ ! -d "${installDir}" ]; then
          mkdir -p "${installDir}"
        fi
        cd "${photoshopPluginDestDir}"
        #create links for plugin
        photoshopDestLink="${installDir}/${photoshopPluginBaseName}"
        for fName in *.plugin
        do
          echo "copy from $PWD/${fName} to ${installDir}/${fName}"
          cp -Rf "$PWD/${fName}" "${installDir}/${fName}"
        done
        auxAppPluginInstalled=1
      fi
    fi
  fi
  echo "installedAppKeyName: ${installedAppKeyName}"
  for appName in ${installedAppKeyName}
  do
    echo "appName: ${appName}, auxAppPluginInstalled: ${auxAppPluginInstalled}"
    defaults write "${dataPlistFilePath}" "${appName}" "${auxAppPluginInstalled}"
  done
  cd "${currDir}"
}

function func_CheckAndInstallPluginForCustomLocation()
{
  currDir="$PWD"
  auxAppPluginInstalled=0
  `"$(dirname -- "$0")/dxo-test-prop.sh" "${propFilePath}" "${checkedPropName}"`
  if [ "$?" -eq "1" ]; then
    echo "Adobe ${progName} installed. Install plugin for Adobe Photoshop ${progName}.";
    read thisPluginDestDir <"/private/tmp/dxo-setup-data/${photoshopPluginDestFileName}"
    if [ ! -z "${thisPluginDestDir}" ]; then
      installDir="${thisPluginDestDir}/DxO FilmPack 5"
      if [ ! -d "${installDir}" ]; then
        mkdir -p "${installDir}"
      fi
      cd "${photoshopPluginDestDir}"
      #create links for plugin
      photoshopDestLink="${installDir}/${photoshopPluginBaseName}"
      for fName in *.plugin
      do
        echo "copy from $PWD/${fName} to ${installDir}/${fName}"
        cp -Rf "$PWD/${fName}" "${installDir}/${fName}"
      done
      auxAppPluginInstalled=1
      echo "installedAppKeyName: ${installedAppKeyName}"
      for appName in ${installedAppKeyName}
      do
        echo "appName: ${appName}, auxAppPluginInstalled: ${auxAppPluginInstalled}"
        defaults write "${dataPlistFilePath}" "${appName}" "${auxAppPluginInstalled}"
      done
      defaults write "${dataPlistFilePath}" "${checkedPropName}__plugin_dir" "${installDir}"
    fi
  fi
  cd "${currDir}"
}

function func_Exit()
{
  if [ ! -z "/private/tmp/dxo-setup-data/" ]; then
    if [ -d "/private/tmp/dxo-setup-data/" ]; then
      rm -Rdf "/private/tmp/dxo-setup-data/"
    fi
  fi
  if [ -f "${photoshopPluginExtraLinkDestFileName}" ]; then
    rm "${photoshopPluginExtraLinkDestFileName}"
  fi
  exit ${exitVal}
}

fromDir="$2"
propFilePath="/private/tmp/dxo-setup-data/Data"
dataPlistFilePath="/Library/Application Support/DxO Labs/dfpv5/Data"

if [ -z "$2" ]; then
  echo "Installation path not specified";
  exitVal=1
  func_Exit
fi

photoshopPluginExtraLinkDestFileName="/private/tmp/dxo-setup-data/dxo-photoshop-dest.txt"

if [ ! -f "${photoshopPluginExtraLinkDestFileName}" ]; then
  echo "Photoshop plugin file path doesn't exist: ${photoshopPluginExtraLinkDestFileName}"
  photoshopPluginExtraLinkPath=
else
  read photoshopPluginExtraLinkPath <"${photoshopPluginExtraLinkDestFileName}"
  if [ -z "${photoshopPluginExtraLinkPath}" ]; then
    echo "Photoshop extra link destination file not found: ${photoshopPluginExtraLinkDestFileName}"
    photoshopPluginExtraLinkPath=
  else
    photoshopPluginExtraLinkPath="${photoshopPluginExtraLinkPath}"
    defaults write "${dataPlistFilePath}" "photoshopPluginExtraLinkPath" "${photoshopPluginExtraLinkPath}"
    if [ -d "${photoshopPluginExtraLinkPath}/" ]; then
      echo "Remove old photoshop plugin in ${photoshopPluginExtraLinkPath}"
      rm -Rdf "${photoshopPluginExtraLinkPath}/PhotoshopPlugin-filter.plugin"
    else
      mkdir -p "${photoshopPluginExtraLinkPath}"
    fi
  fi
fi

echo "check ${fromDir}/"*.plugin
photoshopPluginDestDir="/Applications//DxO FilmPack 5.app/Contents/MacOS/"
if [ -d "${photoshopPluginDestDir}" ]; then
  cd "${photoshopPluginDestDir}"
  for fName in *.plugin
  do
    photoshopPluginDestPath="${photoshopPluginDestDir}/${fName}"
    if [ ! -z "${photoshopPluginExtraLinkPath}" ]; then
      if [ "${photoshopPluginExtraLinkPath}" != "${photoshopPluginDestPath}" ]; then
        echo "create link from ${photoshopPluginDestPath} to ${photoshopPluginExtraLinkPath}/${fName}"
        mkdir -p "${photoshopPluginExtraLinkPath}"
        chown "${USER}":staff "${photoshopPluginExtraLinkPath}"
        ln -sf "${photoshopPluginDestPath}" "${photoshopPluginExtraLinkPath}/${fName}"
        chown "${USER}":staff "${photoshopPluginExtraLinkPath}/${fName}"
      fi
    fi
  done
else
  echo "photoshopPluginDestDir does not exist: ${photoshopPluginDestDir}!"
fi

echo "Photoshop plugin extra file path: ${photoshopPluginExtraLinkPath}"

appSupportDir="/Library/Application Support/"

cd "${appSupportDir}"
pluginsDir="Adobe/Plug-Ins/"

if [ ! -d "${pluginsDir}" ]; then
  echo "There's no adobe plugins directories."
  exitVal=0
  func_Exit
fi

cd "${pluginsDir}"

progName="CS3"
installedAppKeyName="DXOCS332INSTALLED"
checkedPropName="photoshopcs3"
func_CheckAndInstallPlugin

progName="CS4"
installedAppKeyName="DXOCS432INSTALLED"
checkedPropName="photoshopcs4"
func_CheckAndInstallPlugin

progName="CS5"
installedAppKeyName="DXOCS532INSTALLED DXOCS564INSTALLED"
checkedPropName="photoshopcs5"
func_CheckAndInstallPlugin

progName="CS6"
installedAppKeyName="DXOCS664INSTALLED"
checkedPropName="photoshopcs6"
func_CheckAndInstallPlugin

progName="CC"
installedAppKeyName="DXOCC64INSTALLED"
checkedPropName="photoshopcc"
func_CheckAndInstallPlugin

progName="Elements 9"
installedAppKeyName="DXOEL932INSTALLED"
checkedPropName="phelements9"
func_CheckAndInstallPlugin

progName="Elements 10"
installedAppKeyName="DXOEL1032INSTALLED"
checkedPropName="phelements10"
func_CheckAndInstallPlugin

progName="Elements 11"
installedAppKeyName="DXOEL1132INSTALLED"
checkedPropName="phelements11"
func_CheckAndInstallPlugin

progName="Elements 12"
installedAppKeyName="DXOEL1264INSTALLED"
checkedPropName="phelements12"
func_CheckAndInstallPlugin

progName="Elements 13"
installedAppKeyName="DXOEL1364INSTALLED"
checkedPropName="phelements13"
func_CheckAndInstallPlugin

progName="Elements 14"
installedAppKeyName="DXOEL1464INSTALLED"
checkedPropName="phelements14"
func_CheckAndInstallPlugin

progName="Elements 15"
installedAppKeyName="DXOEL1564INSTALLED"
checkedPropName="phelements15"
func_CheckAndInstallPlugin

progName="Elements 16"
installedAppKeyName="DXOEL1664INSTALLED"
checkedPropName="phelements16"
func_CheckAndInstallPlugin

progName="Elements 17"
installedAppKeyName="DXOEL1764INSTALLED"
checkedPropName="phelements17"
func_CheckAndInstallPlugin

progName="Elements 18"
installedAppKeyName="DXOEL1864INSTALLED"
checkedPropName="phelements18"
func_CheckAndInstallPlugin

exitVal=0

func_Exit
