#!/bin/bash
#set_goz.sh
#MacOSX Installer script for setting the GoZ config directory permissions
echo "***** set_goz.sh *****"

sudo chown -R $USER:staff "/Users/Shared/Pixologic"
sudo chmod -R 777 "/Users/Shared/Pixologic"

exit 0