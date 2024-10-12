#!/bin/sh

#$0 - Script path
#$1 - Package path
#$2 - Target location
#$3 - Target volume

# Once the Arnold library is installed with wrong permissions (only the owner had read permission).
# To avoid any similar issues in the future this script forces the read permission for everyone.

echo "Postinstall" > /Users/Shared/c4dtoa_install.log
echo "0: $0" >> /Users/Shared/c4dtoa_install.log
echo "1: $1" >> /Users/Shared/c4dtoa_install.log
echo "2: $2" >> /Users/Shared/c4dtoa_install.log
echo "3: $3" >> /Users/Shared/c4dtoa_install.log

chmod -R +r "$2/library/materialpreview/"
chmod -R +r "$2/plugins/C4DtoA/"

# set execute permission on the api tools
chmod -R +x "$2/plugins/C4DtoA/api/bin"

# #1276 FIXME PackageMaker does not install .app properly, so we rename thosse folders as a workaround
find "$2/plugins/C4DtoA/arnold/bin" -type d -name "*.app.tmp" -execdir bash -c 'mv "{}" `echo "{}" | sed -E "s/.app.tmp$/.app/g"`' \;

# #971 move Arnold outside of the plugins folder (because of NLM)
# NOTE keep the license file
#cp "$2/arnold/bin/*.lic" "$2/plugins/C4DtoA/arnold/bin/"
find "$2/arnold/bin" -name "*.lic" -exec cp {} "$2/plugins/C4DtoA/arnold/bin" \;
rm -r "$2/arnold"
mv "$2/plugins/C4DtoA/arnold" "$2/arnold"

# set execute permission on the Arnold tools
chmod +x "$2/arnold/bin/kick"
chmod +x "$2/arnold/bin/maketx"
chmod +x "$2/arnold/bin/noice"
chmod +x "$2/arnold/bin/oiiotool"
chmod +x "$2/arnold/bin/oslc"

# update single-user licensing if needed
chmod +x "$2/arnold/license/LicensingUpdater"
"$2/arnold/license/LicensingUpdater" --single-user
if [ $? -ne 0 ]
then
   echo "[WARNING] Failed to update Autodesk Licensing"
fi

exit 0

