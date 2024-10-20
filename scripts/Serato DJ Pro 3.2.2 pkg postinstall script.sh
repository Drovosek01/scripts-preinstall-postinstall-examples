#!/bin/bash

seratoPath="/Applications/Serato DJ Pro.app"

function getCurrentUser() {
    local current_user
    current_user=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && $0 !~ /loginwindow/ { print $3 }')
    echo "$current_user"
}

function modifyDock() {
    local current_user="$1"
    local plist="/Users/$current_user/Library/Preferences/com.apple.dock.plist"
    echo "Using user: $current_user for Dock operation."
    echo "Using plist: $plist"

    local appInDock=$(sudo -u "$current_user" defaults read com.apple.dock persistent-apps | grep "Serato%20DJ%20Pro.app" | wc -l)

    if [ "$appInDock" -eq "0" ]; then
        echo "Application is not in the Dock. Adding it..."
        sudo -u "$current_user" defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$seratoPath</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
        sudo -u "$current_user" killall Dock
        echo "Application added to the Dock successfully for user: $current_user"
    else
        echo "Application is already in the Dock for user: $current_user"
    fi
}

echo "Starting SDJ Pro postinstall script."

# Remove 'Serato DJ' app
rm -rf /Applications/Serato\ DJ.app

current_user=$(getCurrentUser)

if [ -n "$current_user" ]; then
    modifyDock "$current_user"
else
    echo "Failed to retrieve a valid user. Skipping Dock operation."
fi

# Remove the cached qml binaries in case they are generated by an older version of DJ which uses an older version of Qt. This
# will prevent issues wherein the newer version of Qt doesn't regenerate the cache properly, leading to unexpected GUI behaviours.
rm -rf ~/Library/Caches/Serato/seratodj/qmlcache

echo "Postinstall script completed."
