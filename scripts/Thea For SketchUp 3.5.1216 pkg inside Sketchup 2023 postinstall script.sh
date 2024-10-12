#!/bin/sh
SUPATH="$HOME/Library/Application Support/Sketchup 2023/Sketchup"

#Rename V2 Ruby file
eval sudo mv -f \"$SUPATH/Plugins/Thea4SU_files.rb\" \"$SUPATH/Plugins/Thea4SU_files.off_rb\"

#Delete part of old content
eval sudo rm -rf \"$SUPATH/Plugins/Thea4SU3_files/plugins\"
eval sudo rm -rf \"$SUPATH/Plugins/Thea4SU3_files/notices\"
eval sudo rm -f '$SUPATH/Plugins/Thea4SU3_files/*.*'

#Put new files in place
eval rsync -r -p \"/tmp/Thea4SU/Thea Materials/\" \"$SUPATH/Materials/\"
eval sudo rsync -a --executability \"/tmp/Thea4SU/Plugin/\" \"$SUPATH/Plugins/\"

