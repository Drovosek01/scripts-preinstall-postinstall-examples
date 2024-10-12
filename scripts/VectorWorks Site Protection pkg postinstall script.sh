#!/bin/sh

cd "`dirname "$0"`"

RlMPath="/Library/PrivilegedHelperTools/com.vectorworks.rlm"
SettingsFolder="/Library/Application Support/Vectorworks Site Protection"
ServerDaemon="/Library/LaunchDaemons/com.vectorworks.rlm.plist"
TrayDaemon="/Library/LaunchAgents/com.vectorworks.tray.plist"
InstallerTempFolder="$HOME/Library/Application Support/Vectorworks Site Protection Installer"
StartupDelay="$(<$InstallerTempFolder/rlmdelay)"
ReportLogFile="$SettingsFolder/reportlog.txt"
DebugLogFile="$SettingsFolder/debuglog.txt"

echo "Stopping previous daemons if they exist..."
sudo launchctl unload -w $ServerDaemon
sudo launchctl unload -w $TrayDaemon

sudo rm $ServerDaemon
sudo rm $TrayDaemon

# Uninstall & Install dongle drivers
./dunst
./dinsts

# Delete the user first as it prevents OS X from giving notifications for changing an existing user
dscl . -delete /Users/_rlm

# As of RLM 14.1 we need to run the service under a non-root user.
# The convention on unix-like platforms is to create a user for every service, which needs a unqiue user id (UID)
# From my understanding, ids 0-99 are reserved by the operating system, ids 100-500 are for system-wide applications
# and >500 are for local accounts (eg. first account created by the os x installer is always 501)
# See this: https://en.wikipedia.org/wiki/User_identifier
UniqueID=0
for i in {100..499}
do
    # Check if id is in use
    IdFound="$(dscl . -list /Users UniqueID | grep $i)"
    if [ -z "$IdFound" ]; then
        UniqueID=$i
        break;
    fi
done

if [ $UniqueID -eq 0 ]; then
    echo "All UIDs in range (100..499) are in use"
    exit 1
fi

# Create _rlm user
echo "Creating a user with ID: $UniqueID"
dscl . -create /Users/_rlm
# Staff group
dscl . -create /Users/_rlm PrimaryGroupID 20
dscl . -create /Users/_rlm UniqueID $UniqueID
# Set terminal to /usr/bin/false as it hides the user from the login panel and prevents us from being able to login with it
dscl . -create /Users/_rlm UserShell /usr/bin/false

# Create ISV options file
cat > $SettingsFolder/vektorwrx.opt << EOF
# Place any custom configuration here
REPORTLOG "+$ReportLogFile"
DEBUGLOG "$DebugLogFile"
EOF

sudo chmod 666 "$SettingsFolder/vektorwrx.opt"
sudo chown _rlm "$ReportLogFile"
sudo chown _rlm "$DebugLogFile"

function CreateServerDaemon {
sudo sh -c "cat > $ServerDaemon" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.vectorworks.rlm</string>
	<key>ProgramArguments</key>
	<array>
		<string>$RlMPath/RunAfterDelay</string>
		<string>$1</string>
	</array>
	<key>RunAtLoad</key>
    <true/>
	<key>WorkingDirectory</key>
	<string>$RlMPath</string>
	<key>KeepAlive</key>
	<false/>
    <key>Username</key>
    <string>_rlm</string>
</dict>
</plist>
EOF
}

# Hosts file edit, this adds the (current) hostaname to the hosts file to prevent RLM host database errors.
Host="127.0.0.1 $(hostname)"
HostsFile="/etc/hosts"
# Only add the host to the hosts file if its not already added
grep -qF "$Host" "$HostsFile" || echo "# Added by Vectorworks Site Protection. Do not remove unless you know what you are doing.\n$Host" >> "$HostsFile"

if [ -f "$InstallerTempFolder/licensefile" ]; then
    SourceLicenseFilePath="$(<$InstallerTempFolder/licensefile)"
    LicenseFileName="${SourceLicenseFilePath##*/}"
    TargetLicenseFilePath="$SettingsFolder/$LicenseFileName"

    # Make sure that we have a source license file set and that it exists
    if [ -f "$SourceLicenseFilePath" ]; then
        cp "$SourceLicenseFilePath" "$SettingsFolder"
        echo "Copy $SourceLicenseFilePath to $SettingsFolder"

        sudo chmod 666 "$TargetLicenseFilePath"

        if [ -f "$InstallerTempFolder/rlmport" ]; then
            RLMPortNumber="$(<$InstallerTempFolder/rlmport)"

            sudo sed -i '' -E "s/(HOST[ ]+[^ ]+[ ]+[^ ]+)[ ]+[0-9]+/\1 $RLMPortNumber/g" "$TargetLicenseFilePath"

            echo "Changed RLM port"

            if [ -f "$InstallerTempFolder/isvport" ]; then
                ISVPortNumber="$(<$InstallerTempFolder/isvport)"

                if [  -n "$ISVPortNumber" ]; then
                    sudo sed -i '' -E "s/(ISV vektorwrx)/ISV vektorwrx port=$ISVPortNumber/g" "$TargetLicenseFilePath"
                    echo "Changed ISV port"
                fi
            fi
        fi
    else
        echo "License file was specified: '$SourceLicenseFilePath', but it doesn't exist - ignored."
    fi
else
    echo "No license file specified."
fi

if [ -f "$InstallerTempFolder/serials" ]; then

    cp "$InstallerTempFolder/serials" "$RlMPath/Config.txt"

    echo "Created Config.txt at $RlMPath/Config.txt"
fi

if [ -f "$InstallerTempFolder/account" ]; then
    AccountName="$(<$InstallerTempFolder/account)"
    echo "$AccountName::all" > "$RlMPath/rlm.pw"
    chmod 666 "$RlMPath/rlm.pw"
    echo "Created rlm.pw at $RlMPath/rlm.pw"
fi
    
if [ -f "$InstallerTempFolder/daemon" ]; then
    echo "Installing daemons..."
        
    CreateServerDaemon $StartupDelay
    sudo chown root $ServerDaemon
    sudo chmod 644 $ServerDaemon

    sudo cp com.vectorworks.tray.plist $TrayDaemon
    sudo chown root $TrayDaemon
    sudo chmod 644 $TrayDaemon
fi

if [ -f "$InstallerTempFolder/runafterinstall" ]; then
    if [ -f "$InstallerTempFolder/daemon" ]; then
        echo "Starting daemons... "
        # Create the deamon without any startup delay
        CreateServerDaemon 0
        launchctl load -w $ServerDaemon
        launchctl load -w $TrayDaemon
        # Overwrite the daemon spec with the desired startup delay (those changes won't take effect until restart)
        CreateServerDaemon $StartupDelay
    else
        echo "Running Vectorworks Site Protection Server: ./rlm -c $SettingsFolder"
        cd "$RlMPath"
        sudo -u _rlm ./rlm -c "$SettingsFolder" &
        cd "/Applications"
        sudo open "Vectorworks Site Protection.app"
    fi
    
    sleep 2
    # Launch Web Interface and let the user sign-in, it is required as of RLM 15.1
    open "http://localhost:5054"
fi

# We use this folder for installer configuration, we don't need it anymore
rm -r "$InstallerTempFolder"
