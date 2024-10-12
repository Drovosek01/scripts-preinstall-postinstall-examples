#!/bin/sh

#  pre_install.sh
#  
#
#  Created by bld on 27/02/2017.
#

PLUGIN_BINARY="Tekturon"
PLUGIN_BINARY_LC="tekturon"

#--------------------------------------------------------
# previous versions to be removed before installation
#--------------------------------------------------------

AAX="/Library/Application Support/Avid/Audio/Plug-Ins/D16 Group/${PLUGIN_BINARY}.aaxplugin"
AU="/Library/Audio/Plug-Ins/Components/${PLUGIN_BINARY}.component"
VST="/Library/Audio/Plug-Ins/VST/${PLUGIN_BINARY}.vst"
VST3="/Library/Audio/Plug-Ins/VST3/${PLUGIN_BINARY}.vst3"

#--------------------------------------------------------
# removing bundles if they exist
#--------------------------------------------------------

if [ -e "$AU" ]
then
    rm -rf "$AU"
fi

if [ -e "$AAX" ]
then
    rm -rf "$AAX"
fi

if [ -e "$VST" ]
then
    rm -rf "$VST"
fi

if [ -e "$VST3" ]
then
    rm -rf "$VST3"
fi

pkgutil --forget com.d16group.pkg.${PLUGIN_BINARY_LC}-aax
pkgutil --forget com.d16group.pkg.${PLUGIN_BINARY_LC}-au
pkgutil --forget com.d16group.pkg.${PLUGIN_BINARY_LC}-vst2
pkgutil --forget com.d16group.pkg.${PLUGIN_BINARY_LC}-vst3

#--------------------------------------------------------

exit 0
