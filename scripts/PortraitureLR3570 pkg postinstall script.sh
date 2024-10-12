#!/bin/sh

rm -Rf "/Applications/Imagenomic/Portraiture 3 Beta Plug-in for Lightroom/"
rm -Rf "$HOME/Library/Application Support/Adobe/Lightroom/Export Presets/Imagenomic Portraiture 3 Beta/"
rm -Rf "$HOME/Library/Application Support/Adobe/Lightroom/External Editor Presets/Imagenomic/Imagenomic Portraiture 3 Beta.lrtemplate"
rm -Rf "$HOME/Library/Application Support/Adobe/Lightroom/Modules/portraiture3beta.lrdevplugin"

rm -Rf "$2/Portraiture 3 Beta Plug-in for Lightroom/"


chown -R $USER "$2"
chown -R $USER "$2/Portraiture 3 Plug-in for Lightroom"
chown -R $USER "$2/Portraiture 3 Plug-in for Lightroom/Imagenomic Portraiture 3"
chown -R $USER "$2/Portraiture 3 Plug-in for Lightroom/portraiture3.lrdevplugin"


echo "$2/Portraiture 3 Plug-in for Lightroom" > "$2/Portraiture 3 Plug-in for Lightroom/portraiture3.lrdevplugin/Path.txt"
mkdir -p "$HOME/Library/Application Support/Adobe/Lightroom/Modules/"
rm -Rf "$HOME/Library/Application Support/Adobe/Lightroom/Modules/portraiture3.lrdevplugin"
ln -sf "$2/Portraiture 3 Plug-in for Lightroom/portraiture3.lrdevplugin" "$HOME/Library/Application Support/Adobe/Lightroom/Modules/"
mkdir -p "$HOME/Library/Application Support/Adobe/Lightroom/Export Presets/Imagenomic Portraiture 3/"
cp -Rf "$2/Portraiture 3 Plug-in for Lightroom/Imagenomic Portraiture 3/" "$HOME/Library/Application Support/Adobe/Lightroom/Export Presets/Imagenomic Portraiture 3/"

mkdir -p "$HOME/Library/Application Support/Adobe/Lightroom/External Editor Presets/Imagenomic/"
echo "s = {id = \"48C1AC0C-58BB-4E36-82DD-F146866B8164\",internalName = \"Imagenomic Portraiture 3\",title = \"Imagenomic Portraiture 3\",type = \"ExternalEditor\",value = {
externalEditingFormat = \"TIFF_ZIP_16_ProPhotoRGB\",externalEditingFormat_dpi = 240,externalEditorFullPath = \"$2/Portraiture 3 Plug-in for Lightroom/Portraiture3.app\",
},version = 0,}" > "$HOME/Library/Application Support/Adobe/Lightroom/External Editor Presets/Imagenomic/Imagenomic Portraiture 3.lrtemplate"

chown -R $USER "$HOME/Library/Application Support/Adobe/Lightroom/External Editor Presets/Imagenomic"
chown -R $USER "$HOME/Library/Application Support/Adobe/Lightroom/Export Presets/Imagenomic Portraiture 3"
chown -R $USER "$HOME/Library/Application Support/Adobe/Lightroom/Modules"
