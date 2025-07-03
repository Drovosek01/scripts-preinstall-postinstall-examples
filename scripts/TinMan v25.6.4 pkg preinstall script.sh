#!/bin/bash

# Remove any previous versions
sudo "$3/bin/mkdir" "$3/Library/Application Support/TinMan"
sudo "$3/bin/mkdir" "$3/Library/Application Support/TinMan/TML"
sudo "$3/bin/mkdir" "$3/Library/Application Support/TinMan/TMSettings"
sudo "$3/bin/chmod" -fR a+rwx "$3/Library/Application Support/TinMan"
exit 0
