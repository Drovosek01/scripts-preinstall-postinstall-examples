#!/bin/sh

###
# Common Section
###
monkey_dir="/Library/Application Support/RubberMonkey"
chown root:admin "$monkey_dir"
chmod 775 "$monkey_dir"

regexe="RegisterApp_v3"
regapp="$regexe.app"

deregexe="DeregisterApp_v3"
deregapp="$deregexe.app"

# move the command-line tools into the registration app bundles
mv "$monkey_dir/cp_lic" "$monkey_dir/$regapp/Contents/MacOS/cp_lic"
mv "$monkey_dir/rm_lic" "$monkey_dir/$deregapp/Contents/MacOS/rm_lic"


chown -R root:admin "$monkey_dir/.versions"
chmod 0775 "$monkey_dir/.versions"

chown -R root:admin "$monkey_dir/Profiles"
chmod 0775 "$monkey_dir/Profiles"
chmod -R 0664 "$monkey_dir/Profiles/5D"
chmod 0775 "$monkey_dir/Profiles/5D"

chown -R root:admin "$monkey_dir/ResourcesNITRATE"
chmod -R 0664 "$monkey_dir/ResourcesNITRATE"
chmod 0775 "$monkey_dir/ResourcesNITRATE"

lic_dir="$monkey_dir/Licenses"
if ! [ -e "$lic_dir" ]
then
mkdir "$lic_dir"
fi
chown root:admin "$lic_dir"
chmod 0775 "$lic_dir"

chown -R root:admin "$monkey_dir/$deregapp"
chmod -R 0664 "$monkey_dir/$deregapp"
chmod 0775 "$monkey_dir/$deregapp"
chmod 0775 "$monkey_dir/$deregapp/Contents"
chmod 0775 "$monkey_dir/$deregapp/Contents/_CodeSignature"
chmod 0775 "$monkey_dir/$deregapp/Contents/MacOS"
chmod 0775 "$monkey_dir/$deregapp/Contents/Resources"
chmod 0775 "$monkey_dir/$deregapp/Contents/Resources/English.lproj"
chmod 0775 "$monkey_dir/$deregapp/Contents/MacOS/$deregexe"
chmod 6775 "$monkey_dir/$deregapp/Contents/MacOS/rm_lic"

chown -R root:admin "$monkey_dir/$regapp"
chmod -R 0664 "$monkey_dir/$regapp"
chmod 0775 "$monkey_dir/$regapp"
chmod 0775 "$monkey_dir/$regapp/Contents"
chmod 0775 "$monkey_dir/$regapp/Contents/_CodeSignature"
chmod 0775 "$monkey_dir/$regapp/Contents/MacOS"
chmod 0775 "$monkey_dir/$regapp/Contents/Resources"
chmod 0775 "$monkey_dir/$regapp/Contents/Resources/English.lproj"
chmod 0775 "$monkey_dir/$regapp/Contents/MacOS/$regexe"
chmod 6775 "$monkey_dir/$regapp/Contents/MacOS/cp_lic"

support_dir="$HOME/Library/Application Support/RubberMonkey"
if ! [ -e "$support_dir" ]
then
mkdir "$support_dir"
fi
chown $USER "$support_dir"
chmod 0775 "$support_dir"

log_dir="$support_dir/Logs"
if ! [ -e "$log_dir" ]
then
mkdir "$log_dir"
fi
chown $USER "$log_dir"
chmod 0775 "$log_dir"

###
# OFX Plugin section
###
ofx_path="/Library/OFX"
if ! [ -e "$ofx_path" ]
then
mkdir "$ofx_path"
fi
chown root:wheel "$ofx_path"
chmod 0775 "$ofx_path"

plugin_path="$ofx_path/Plugins"
if ! [ -e "$plugin_path" ]
then
mkdir "$plugin_path"
fi
chown root:wheel "$plugin_path"
chmod 0775 "$plugin_path"

plugin_name="FilmConvertNitrate.ofx.bundle"
plugin_tmp="/Library/Application Support/RubberMonkey/Plugin Temp/"
plugin_src="${plugin_tmp}/$plugin_name"
plugin_dst="$plugin_path/$plugin_name"

# If we have a plugin to copy
if [ -e "$plugin_src" ]
then
    # If there is already one there
    if [ -e "$plugin_dst" ]
    then
        # then delete the existing plugin
        rm -rf "$plugin_dst"
    fi
    
    # move the plugin from the temporary location into the newly vacated plugin directory
    mv "$plugin_src" "$plugin_dst"
fi

# remove the temporary directory, which should now be empty
if [ -e "$plugin_tmp" ]
then
rmdir "$plugin_tmp"
fi

chown root:admin "$plugin_dst"
chown root:admin "$plugin_dst/Contents"
chown root:admin "$plugin_dst/Contents/MacOS"
chown root:admin "$plugin_dst/Contents/MacOS/FilmConvertNitrate.ofx"
chown root:admin "$plugin_dst/Contents/_CodeSignature"
chown root:admin "$plugin_dst/Contents/_CodeSignature/CodeResources"
chown root:admin "$plugin_dst/Contents/Resources"
chown root:admin "$plugin_dst/Contents/Resources/CameraSelectWindow.nib"
chown root:admin "$plugin_dst/Contents/Info.plist"
chown root:admin "$plugin_dst/Contents/PkgInfo"

chmod 0775 "$plugin_dst"
chmod 0775 "$plugin_dst/Contents"
chmod 0775 "$plugin_dst/Contents/MacOS"
chmod 0775 "$plugin_dst/Contents/MacOS/FilmConvertNitrate.ofx"
chmod 0775 "$plugin_dst/Contents/_CodeSignature"
chmod 0775 "$plugin_dst/Contents/_CodeSignature/CodeResources"
chmod 0775 "$plugin_dst/Contents/Resources"
chmod 0664 "$plugin_dst/Contents/Resources/CameraSelectWindow.nib"
chmod 0664 "$plugin_dst/Contents/Info.plist"
chmod 0664 "$plugin_dst/Contents/PkgInfo"

exit 0

