#!/bin/bash
if [ -e ~/Library/Application\ Support/Marmoset\ Toolbag\ 4 ]; then
MIGRATE=`osascript -e 'display dialog "Would you like to migrate your Toolbag 4 preferences, workspaces, and library directories to Toolbag 5?" buttons {"Yes", "No"} default button "Yes"' & wait`
if [ "$MIGRATE" = "button returned:Yes" ]; then
mkdir ~/Library/Application\ Support/Marmoset\ Toolbag\ 5
cp ~/Library/Application\ Support/Marmoset\ Toolbag\ 4/prefs.txt ~/Library/Application\ Support/Marmoset\ Toolbag\ 5/
cp -r ~/Library/Application\ Support/Marmoset\ Toolbag\ 4/workspaces ~/Library/Application\ Support/Marmoset\ Toolbag\ 5/
cp -r ~/Library/Application\ Support/Marmoset\ Toolbag\ 4/baker ~/Library/Application\ Support/Marmoset\ Toolbag\ 5/
chown -R jeffdr ~/Library/Application\ Support/Marmoset\ Toolbag\ 5
fi
fi
open "$2/Marmoset Toolbag 5/Marmoset Toolbag.app"
