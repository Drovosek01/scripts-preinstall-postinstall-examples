#!/bin/bash
launchctl remove launchkeep.cold-turkey
launchctl remove user.launchkeep.cold-turkey
pkill -9 "Cold Turkey Blocker"
pkill -9 "Cold Turkey"
function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }
if [ $(version `sw_vers -productVersion`) -lt $(version "10.14.4") ]; then
    if [ ! -f "/usr/lib/swift/libswiftSwiftOnoneSupport.dylib" ]; then
        ASKSWIFTLIB="$(osascript -e "display dialog \"It looks like you're using macOS 10.14.3 or earlier. In order for website blocking to work, you'll need to install the Swift 5.0 Runtime Libraries. Would you like to do this now?\" buttons {\"Yes\", \"No\"} default button \"Yes\" with title \"A required library is not installed\"")"
        if [ "$ASKSWIFTLIB" = "button returned:Yes" ]; then
            open -a safari 'https://support.apple.com/kb/DL1998'
        fi
    fi
fi
$(exit 0)
