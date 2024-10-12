#!/bin/sh

# v2 - nowe katalogi

R_NEW_PATH_SYNAPSE="/Library/Application Support/Synapse Audio"
R_NEW_PLUGIN_PATH="$R_NEW_PATH_SYNAPSE/Legend"

# lokalizacje

PLUG_COMPONENT_TARGET="/Library/Audio/Plug-Ins/Components/Legend.component"
PLUG_VST_TARGET="/Library/Audio/Plug-Ins/VST/Legend.vst"
PLUG_VST3_TARGET="/Library/Audio/Plug-Ins/VST3/Legend.vst3"
PLUG_AAX_TARGET="/Library/Application Support/Avid/Audio/Plug-Ins/Legend.aaxplugin"
PLUG_VST3_FX_TARGET="/Library/Audio/Plug-Ins/VST3/LegendFX.vst3"
PLUG_VST_FX_TARGET="/Library/Audio/Plug-Ins/VST/LegendFX.vst"
PLUG_COMPONENT_FX_TARGET="/Library/Audio/Plug-Ins/Components/LegendFX.component"
PLUG_AAX_FX_TARGET="/Library/Application Support/Avid/Audio/Plug-Ins/LegendFX.aaxplugin"

# detekcja pakietów i instalacja zasobów

R_PATH_PLUGIN_INSTALL_AU=$R_NEW_PLUGIN_PATH"/.legendau"
R_PATH_PLUGIN_INSTALL_VST=$R_NEW_PLUGIN_PATH"/.legendvst"
R_PATH_PLUGIN_INSTALL_VST3=$R_NEW_PLUGIN_PATH"/.legendvst3"
R_PATH_PLUGIN_INSTALL_AAX=$R_NEW_PLUGIN_PATH"/.legendaax"
R_PATH_PLUGIN_INSTALL_AUFX=$R_NEW_PLUGIN_PATH"/.legendaufx"
R_PATH_PLUGIN_INSTALL_VSTFX=$R_NEW_PLUGIN_PATH"/.legendvstfx"
R_PATH_PLUGIN_INSTALL_VST3FX=$R_NEW_PLUGIN_PATH"/.legendvst3fx"
R_PATH_PLUGIN_INSTALL_AAXFX=$R_NEW_PLUGIN_PATH"/.legendaaxfx"

#prawa odczytu i zapisu

if [ -f "$R_PATH_PLUGIN_INSTALL_AU" ]
then

  chown -R "$USER" "$PLUG_COMPONENT_TARGET" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$PLUG_COMPONENT_TARGET" >> /dev/null 2>&1
  xattr -d com.apple.quarantine "$PLUG_COMPONENT_TARGET" >> /dev/null 2>&1

  rm -f "$R_PATH_PLUGIN_INSTALL_AU" >> /dev/null 2>&1

  # test Audio Unit problem

  if [[ ${OSTYPE:6} -ge 17 ]]
  then
    killall -9 AudioComponentRegistrar >> /dev/null 2>&1
  fi

fi

if [ -f "$R_PATH_PLUGIN_INSTALL_AUFX" ]
then

  chown -R "$USER" "$PLUG_COMPONENT_FX_TARGET" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$PLUG_COMPONENT_FX_TARGET" >> /dev/null 2>&1
  xattr -d com.apple.quarantine "$PLUG_COMPONENT_FX_TARGET" >> /dev/null 2>&1

  rm -f "$R_PATH_PLUGIN_INSTALL_AUFX" >> /dev/null 2>&1

  # test Audio Unit problem

  if [[ ${OSTYPE:6} -ge 17 ]]
  then
    killall -9 AudioComponentRegistrar >> /dev/null 2>&1
  fi

fi

if [ -f "$R_PATH_PLUGIN_INSTALL_VST" ]
then

  chown -R "$USER" "$PLUG_VST_TARGET" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$PLUG_VST_TARGET" >> /dev/null 2>&1
  xattr -d com.apple.quarantine "$PLUG_VST_TARGET" >> /dev/null 2>&1

  rm -f "$R_PATH_PLUGIN_INSTALL_VST" >> /dev/null 2>&1

fi

if [ -f "$R_PATH_PLUGIN_INSTALL_VSTFX" ]
then

  chown -R "$USER" "$PLUG_VST_FX_TARGET" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$PLUG_VST_FX_TARGET" >> /dev/null 2>&1
  xattr -d com.apple.quarantine "$PLUG_VST_FX_TARGET" >> /dev/null 2>&1

  rm -f "$R_PATH_PLUGIN_INSTALL_VSTFX" >> /dev/null 2>&1

fi

if [ -f "$R_PATH_PLUGIN_INSTALL_VST3" ]
then

  chown -R "$USER" "$PLUG_VST3_TARGET" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$PLUG_VST3_TARGET" >> /dev/null 2>&1
  xattr -d com.apple.quarantine "$PLUG_VST3_TARGET" >> /dev/null 2>&1

  rm -f "$R_PATH_PLUGIN_INSTALL_VST3" >> /dev/null 2>&1

fi

if [ -f "$R_PATH_PLUGIN_INSTALL_VST3FX" ]
then

  chown -R "$USER" "$PLUG_VST3_FX_TARGET" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$PLUG_VST3_FX_TARGET" >> /dev/null 2>&1
  xattr -d com.apple.quarantine "$PLUG_VST3_FX_TARGET" >> /dev/null 2>&1

  rm -f "$R_PATH_PLUGIN_INSTALL_VST3FX" >> /dev/null 2>&1

fi

if [ -f "$R_PATH_PLUGIN_INSTALL_AAX" ]
then

  chown -R "$USER" "$PLUG_AAX_TARGET" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$PLUG_AAX_TARGET" >> /dev/null 2>&1
  xattr -d com.apple.quarantine "$PLUG_AAX_TARGET" >> /dev/null 2>&1

  rm -f "$R_PATH_PLUGIN_INSTALL_AAX" >> /dev/null 2>&1

fi

if [ -f "$R_PATH_PLUGIN_INSTALL_AAXFX" ]
then

  chown -R "$USER" "$PLUG_AAX_FX_TARGET" >> /dev/null 2>&1
  chflags -R nouchg,noschg "$PLUG_AAX_FX_TARGET" >> /dev/null 2>&1
  xattr -d com.apple.quarantine "$PLUG_AAX_FX_TARGET" >> /dev/null 2>&1

  rm -f "$R_PATH_PLUGIN_INSTALL_AAXFX" >> /dev/null 2>&1

fi

# uff, koniec

exit 0
