#!/bin/sh

# v2 - utworzenie pliku nks / nks instalowane

R_NEW_PATH_SYNAPSE="/Library/Application Support/Synapse Audio"
R_NEW_PLUGIN_PATH="$R_NEW_PATH_SYNAPSE/Legend"

# utworzmy sobie katalogi i nadamy prawa

mkdir -p "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1
chown "$USER" "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1
chmod 755 "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1

mkdir -p "$R_NEW_PLUGIN_PATH/" >> /dev/null 2>&1
chown "$USER" "$R_NEW_PLUGIN_PATH/" >> /dev/null 2>&1
chmod 755 "$R_NEW_PLUGIN_PATH/" >> /dev/null 2>&1

mkdir -p "$R_NEW_PLUGIN_PATH/NKS/" >> /dev/null 2>&1
chown "$USER" "$R_NEW_PLUGIN_PATH/NKS/" >> /dev/null 2>&1
chmod 755 "$R_NEW_PLUGIN_PATH/NKS/" >> /dev/null 2>&1

# plik nks

echo "" > "$R_NEW_PLUGIN_PATH/.installnks"

# koniec na razie

exit 0
