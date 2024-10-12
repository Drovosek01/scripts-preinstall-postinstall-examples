#!/bin/sh

# v2 - nowe katalogi, dane NKS post

R_NEW_PATH_SYNAPSE="/Library/Application Support/Synapse Audio"
R_NEW_PLUGIN_PATH="$R_NEW_PATH_SYNAPSE/Legend"

NKS_INSTALL_FILE="$R_NEW_PLUGIN_PATH/.installnks"

NKS_XML_PATH="/Library/Application Support/Native Instruments/Service Center"
NKS_XML_FILE="SynapseTheLegend.xml"
NKS_XML_CONTENT=""

NKS_PLIST_PATH="/Library/Preferences"
NKS_PLIST_FILE="com.native-instruments.SynapseTheLegend.plist"
NKS_PLIST_CONTENT=""

if [ -d "$NKS_XML_PATH" ] && [ -f "$NKS_INSTALL_FILE" ]; then

  # utworzmy sobie katalogi i nadamy prawa
  # zrobione in nksPre

  # tworzenie konfiguracji NKS (dane teraz kopiowane przez instalator)

NKS_XML_CONTENT=$NKS_XML_CONTENT"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
# This is a template for an NI Product Information file.
# This file should be installed to
# C:\Program Files\Common Files\Native Instruments\Service Center
# or
# [System HD]/Library/Application Support/Native Instruments/Service Center.
# Please replace all $...$ with the appropriate information for your product.
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n<ProductHints>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t<Product version=\"1\">"
# Increment this version in case you plan to ship an updated version of this xml
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<UPID>72622ee9-0ed6-4baf-8289-46b70dddd262</UPID>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<Name>The Legend</Name>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<RegKey>SynapseTheLegend</RegKey>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<BinName>Legend</BinName>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<AuthAppID>500</AuthAppID>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<PluginID fx=\"false\">0x45545256</PluginID>"
# In hex format, e.g. 0x53756253 for 'SubS';
# Set fx='false' if your plugin is not an Audio Effect
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<Company>Synapse Audio</Company>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<FactoryLibrary>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t\t<Name>The Legend Factory</Name>"
# Please do not change the properties below this line -->
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t\t<Relevance>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t\t\t<Application minVersion=\"1.8\" nativeContent=\"false\">KKontrol</Application>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t\t\t<Application minVersion=\"2.4\" nativeContent=\"false\">Maschine</Application>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t\t</Relevance>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t</FactoryLibrary>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<Type>Plugin</Type>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t\t<AuthSystem>None</AuthSystem>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n\t</Product>"
NKS_XML_CONTENT=$NKS_XML_CONTENT"\n</ProductHints>"

NKS_INFO_INSTALL_DIR=`osascript << EOF
  tell application "Finder"
    set theItem to (POSIX file "/Library/Audio/Plug-Ins/VST") as text
  end tell
EOF`

NKS_INFO_CONTENT_DIR=`osascript << EOF
  tell application "Finder"
    set theItem to (POSIX file "/Library/Application Support/Synapse Audio/Legend/NKS") as text
  end tell
EOF`

NKS_PLIST_CONTENT=""
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n<plist version=\"1.0\">"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n<dict>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n\t<key>InstallDir</key>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n\t<string>$NKS_INFO_INSTALL_DIR:</string>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n\t<key>ContentDir</key>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n\t<string>$NKS_INFO_CONTENT_DIR:</string>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n\t<key>ContentVersion</key>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n\t<string>1.2.0.0</string>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n</dict>"
NKS_PLIST_CONTENT=$NKS_PLIST_CONTENT"\n</plist>"

  echo $NKS_PLIST_CONTENT > "$NKS_PLIST_PATH/$NKS_PLIST_FILE"
  echo $NKS_XML_CONTENT > "$NKS_XML_PATH/$NKS_XML_FILE"

  # usuwanie pliku .xmlinstall
  
  rm -f "$NKS_INSTALL_FILE" >> /dev/null 2>&1

  # ustawienie praw odczytu

  chown -R "$USER" "$R_NEW_PLUGIN_PATH/NKS" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$R_NEW_PLUGIN_PATH/NKS" >> /dev/null 2>&1
  
  # i dodatkowo ustawienie odpowiednich flag odczytu i/lub zapisu

  find "$R_NEW_PLUGIN_PATH/NKS" -type d -exec chmod 755 {} \; >> /dev/null 2>&1
  find "$R_NEW_PLUGIN_PATH/NKS" -type f -exec chmod 644 {} \; >> /dev/null 2>&1

  # i dodatkowo ustawienie praw odzytu i zaipsu dla ukrytych plików

  find "$R_NEW_PLUGIN_PATH/NKS" -type f -iname ".*" -exec chmod 644 {} \; >> /dev/null 2>&1

  # i dodatkowo usuwanie z kwarantanny

  xattr -d com.apple.quarantine "$R_NEW_PATH_SYNAPSE" >> /dev/null 2>&1
  xattr -dr com.apple.quarantine "$R_NEW_PATH_SYNAPSE" >> /dev/null 2>&1

  xattr -d com.apple.quarantine "$R_NEW_PLUGIN_PATH" >> /dev/null 2>&1
  xattr -dr com.apple.quarantine "$R_NEW_PLUGIN_PATH" >> /dev/null 2>&1

  xattr -d com.apple.quarantine "$R_NEW_PLUGIN_PATH/NKS" >> /dev/null 2>&1
  xattr -dr com.apple.quarantine "$R_NEW_PLUGIN_PATH/NKS" >> /dev/null 2>&1

fi

# uff, koniec

exit 0
