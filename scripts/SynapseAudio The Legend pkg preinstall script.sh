#!/bin/sh

killall -9 AudioComponentRegistrar >> /dev/null 2>&1

rm -rf "/Library/Audio/Plug-Ins/Components/LegendFX.component" >> /dev/null 2>&1

R_NEW_PATH_SYNAPSE="/Library/Application Support/Synapse Audio"
R_NEW_LEGD_PATH="$R_NEW_PATH_SYNAPSE/Legend"

R_PATH_PLUGIN_INSTALL="$R_NEW_LEGD_PATH/.legendaufx"

mkdir -p "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1
chown "$USER" "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1
chmod 755 "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1

mkdir -p "$R_NEW_LEGD_PATH/" >> /dev/null 2>&1
chown "$USER" "$R_NEW_LEGD_PATH/" >> /dev/null 2>&1
chmod 755 "$R_NEW_LEGD_PATH/" >> /dev/null 2>&1

echo "" > "$R_PATH_PLUGIN_INSTALL"

exit 0
