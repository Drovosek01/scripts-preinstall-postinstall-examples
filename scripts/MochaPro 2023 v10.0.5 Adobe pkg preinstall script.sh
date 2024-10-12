#!/bin/bash
if ! [ -a "/Library/Application Support/Adobe" ]; then
  /bin/mkdir "/Library/Application Support/Adobe"
fi
if [ -d "/Library/Application Support/Adobe" ]; then
  /bin/chmod 775 "/Library/Application Support/Adobe"
  /usr/sbin/chown root:admin "/Library/Application Support/Adobe"
fi

if ! [ -a "/Library/Application Support/Adobe/Common" ]; then
  /bin/mkdir "/Library/Application Support/Adobe/Common"
fi
if [ -d "/Library/Application Support/Adobe/Common" ]; then
  /bin/chmod 775 "/Library/Application Support/Adobe/Common"
  /usr/sbin/chown root:admin "/Library/Application Support/Adobe/Common"
fi

if ! [ -a "/Library/Application Support/Adobe/Common/Plug-ins" ]; then
  /bin/mkdir "/Library/Application Support/Adobe/Common/Plug-ins"
fi
if [ -d "/Library/Application Support/Adobe/Common/Plug-ins" ]; then
  /bin/chmod 775 "/Library/Application Support/Adobe/Common/Plug-ins"
  /usr/sbin/chown root:admin "/Library/Application Support/Adobe/Common/Plug-ins"
fi

if ! [ -a "/Library/Application Support/Adobe/Common/Plug-ins/7.0" ]; then
  /bin/mkdir "/Library/Application Support/Adobe/Common/Plug-ins/7.0"
fi
if [ -d "/Library/Application Support/Adobe/Common/Plug-ins/7.0" ]; then
  /bin/chmod 775 "/Library/Application Support/Adobe/Common/Plug-ins/7.0"
  /usr/sbin/chown root:admin "/Library/Application Support/Adobe/Common/Plug-ins/7.0"
fi

if ! [ -a "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore" ]; then
  /bin/mkdir "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore"
fi
if [ -d "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore" ]; then
  /bin/chmod 775 "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore"
  /usr/sbin/chown root:admin "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore"
fi

if [ -d "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/Imagineer Systems" ]; then
  /bin/rm -dfr "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/Imagineer Systems"
fi

if ! [ -a "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX" ]; then
  /bin/mkdir "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX"
fi
if [ -d "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX" ]; then
  /bin/chmod 775 "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX"
  /usr/sbin/chown root:admin "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX"
fi

# Remove all old versions of the Mocha plugin
rm -rf /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX/[Mm]ocha*

PACKAGE_INSTALL_DIR="MochaPro2023"

if ! [ -a "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX/$PACKAGE_INSTALL_DIR" ]; then
  /bin/mkdir "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX/$PACKAGE_INSTALL_DIR"
fi
if [ -d "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX/$PACKAGE_INSTALL_DIR" ]; then
  /bin/chmod 775 "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX/$PACKAGE_INSTALL_DIR"
  /usr/sbin/chown root:admin "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX/$PACKAGE_INSTALL_DIR"
fi

# Reprise directory needed since RLM 14.1
if ! [ -a "/Library/Application Support/Reprise" ]; then
  /bin/mkdir "/Library/Application Support/Reprise"
fi
if [ -d "/Library/Application Support/Reprise" ]; then
  /bin/chmod 777 "/Library/Application Support/Reprise"
  /usr/sbin/chown root:admin "/Library/Application Support/Reprise"
fi

products_codes=(Pro VR)
for product_code in "${products_codes[@]}"; do
  mocha_path="/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BorisFX/$PACKAGE_INSTALL_DIR"
  if [ -d $mocha_path ]; then
    /bin/chmod 775 $mocha_path
    /usr/sbin/chown root:admin $mocha_path
  fi
done

exit 0
