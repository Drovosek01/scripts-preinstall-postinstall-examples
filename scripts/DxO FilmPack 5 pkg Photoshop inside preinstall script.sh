#!/bin/sh

photoshopPluginDir="/Library/Application Support/Adobe/Plug-Ins/"
dataPlistFilePath="/Library/Application Support/DxO Labs/dfpv5/Data.plist"

if [ -d "${photoshopPluginDir}CS3/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}CS3/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}CS4/" ]; then
  sudo rm -Rfd "${photoshopPluginDir}CS4/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}CS5/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}CS5/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}CS6/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}CS6/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}CC/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}CC/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 9/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 9/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 10/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 10/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 11/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 11/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 12/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 12/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 13/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 13/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 14/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 14/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 15/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 15/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 16/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 16/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 17/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 17/DxO FilmPack 5";
fi
if [ -d "${photoshopPluginDir}Elements 18/DxO FilmPack 5" ]; then
  sudo rm -Rfd "${photoshopPluginDir}Elements 18/DxO FilmPack 5";
fi

#remove extra photoshop plug-in files
photoshopPluginExtraLinkPath=`defaults read "${dataPlistFilePath}" "photoshopPluginExtraLinkPath"`
if [ ! -z "${photoshopPluginExtraLinkPath}" ]; then
  if [ -d "${photoshopPluginExtraLinkPath}" ]; then
      sudo rm -Rdf "${photoshopPluginExtraLinkPath}/PhotoshopPlugin-filter.plugin"
      sudo defaults delete "${dataPlistFilePath}" "photoshopPluginExtraLinkPath"
      #remove extra photoshop plug-in directory if it is empty
      if [ ! "$(ls "${photoshopPluginExtraLinkPath}")" ]; then
        sudo rm -Rdf "${photoshopPluginExtraLinkPath}"
      fi
  fi
fi

dxoKey=photoshopcc__plugin_dir
dxoPluginPath=
dxoPluginPath=`defaults read "${dataPlistFilePath}" "${dxoKey}"`
echo "Photoshop CC plug-in dir to be removed: ${dxoPluginPath}"
if [ ! -z "${dxoPluginPath}" ]; then
  if [ -d "${dxoPluginPath}" ]; then
    sudo rm -Rfd "${dxoPluginPath}"
    sudo defaults delete "${dataPlistFilePath}" "${dxoKey}"
    sudo chown "${USER}":staff "${dataPlistFilePath}"
    sudo chmod 666 "${dataPlistFilePath}"
  fi
fi

dxoKey=photoshop2014cc__plugin_dir
dxoPluginPath=
dxoPluginPath=`defaults read "${dataPlistFilePath}" "${dxoKey}"`
echo "Photoshop CC 2014 plug-in dir to be removed: ${dxoPluginPath}"
if [ ! -z "${dxoPluginPath}" ]; then
  if [ -d "${dxoPluginPath}" ]; then
    sudo rm -Rfd "${dxoPluginPath}"
    sudo defaults delete "${dataPlistFilePath}" "${dxoKey}"
    sudo chown "${USER}":staff "${dataPlistFilePath}"
    sudo chmod 666 "${dataPlistFilePath}"
  fi
fi

dxoKey=photoshop2015cc__plugin_dir
dxoPluginPath=
dxoPluginPath=`defaults read "${dataPlistFilePath}" "${dxoKey}"`
echo "Photoshop CC 2015 plug-in dir to be removed: ${dxoPluginPath}"
if [ ! -z "${dxoPluginPath}" ]; then
  if [ -d "${dxoPluginPath}" ]; then
    sudo rm -Rfd "${dxoPluginPath}"
    sudo defaults delete "${dataPlistFilePath}" "${dxoKey}"
    sudo chown "${USER}":staff "${dataPlistFilePath}"
    sudo chmod 666 "${dataPlistFilePath}"
  fi
fi

sudo pkgutil --forget com.dxo-lab.dfpv5.PhotoshopPlugin.pkg

exit 0
