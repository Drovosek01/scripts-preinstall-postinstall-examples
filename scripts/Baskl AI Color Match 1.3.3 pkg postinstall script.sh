#!/bin/bash

LOGGING_DIR="/Library/Application Support/BSKL/Logs"
PLUGIN_NAME="AI Color Match"
PLUGIN_NAME_LOG="aicolormatch"

RENDER_ENGINE_NEEDED=12

# Log all stdout and stderr
mkdir "/Library/Application Support/BSKL/Logs/"
exec >> "$LOGGING_DIR/${PLUGIN_NAME_LOG}_installer-bash.log"
exec 2>&1

echo "
############################
Installing $PLUGIN_NAME
$(date)
############################
"

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "script_dir: $script_dir"

# Variables
GDIALOG_PID=""
PIPE_PATH="$script_dir/bskl_installer_pipe"
# Create a named pipe
rm -f "${PIPE_PATH}"
mkfifo "${PIPE_PATH}"

"$script_dir/gDialog.app/Contents/MacOS/gDialog" progressbar --title "${PLUGIN_NAME} Installer" --text "Please wait..." --focus < "${PIPE_PATH}" &
GDIALOG_PID=$!
exec 3<> "${PIPE_PATH}"

# Tell user install failed if any command fails
set -e # This might not be the best way to do this: https://stackoverflow.com/questions/19622198/what-does-set-e-mean-in-a-bash-script (NOTE: if we change it here, we should change it below too)
close_gdialog() {
    kill $GDIALOG_PID
}
# Set the trap to call close_gdialog on ERR signal
trap close_gdialog ERR

###### DOWNLOAD COMPANION ######
echo "80 Downloading Companion..." >&3

# Directory where you want to extract the contents
destination_directory="/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BSKL"

# Temporary file for storing the downloaded zip - NOTE THIS DIRECTORY MUST ALREADY EXIST
temp_zip="$script_dir/tempfile.zip"

# Download the zip file
echo "Downloading Companion..."
curl -L "https://bskl.xyz/r/companion-latest-mac" -o "$temp_zip" --fail --show-error

# Create the destination directory if it doesn't exist
mkdir -p "$destination_directory"

echo "70 Extracting Companion..." >&3

# Extract the contents of the zip file
echo "Extracting Companion."
unzip -oq "$temp_zip" -d "$destination_directory" -x "__MACOSX/*"

# Remove the temporary zip file
rm "$temp_zip"

echo "Finished extracting Companion."

###### DOWNLOAD RENDER ENGINE ######

# Determine the architecture of the user's Mac
arch=$(uname -m)

echo "10 Determining files to download..." >&3

if [ "$arch" == "arm64" ]; then
    # URL to the zip file for ARM architecture
    url="https://bskl.xyz/r/render-engine-mac-arm-v${RENDER_ENGINE_NEEDED}"
else
    # URL to the zip file for x86_64 architecture
    url="https://bskl.xyz/r/render-engine-mac-x64-v${RENDER_ENGINE_NEEDED}"
fi

version_directory="/Library/Application Support/BSKL/Render Engine/Python 3.10/version.txt"

# If the version file exists
if [[ -f "$version_directory" ]]; then
    CURRENT_VERSION=$(cat "$version_directory")
else
    CURRENT_VERSION=0
fi

echo "Current Render Engine version: $CURRENT_VERSION"
echo "Needed Render Engine version: $RENDER_ENGINE_NEEDED"

# Count the number of directories in MediaCore/BSKL
NUM_PLUGINS_INSTALLED=$(find "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BSKL" -maxdepth 1 -type d | grep -v "^/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/BSKL$" | wc -l | tr -d ' ')
echo "Number of plugins installed: $NUM_PLUGINS_INSTALLED"

# Only proceed with download if the needed version is greater than the current version (which will be 0 if it doesn't exist)
if [ $RENDER_ENGINE_NEEDED -gt $CURRENT_VERSION ]; then
    # If there's more than just this plugin + companion installed
    if [ $NUM_PLUGINS_INSTALLED -gt 2 ]; then 
        "$script_dir/gDialog.app/Contents/MacOS/gDialog" msgbox --title "BSKL Installer" --text "Your local Render Engine will be updated. It's possible that this will break support for other BSKL plugins until you update them to the latest version. Please run the latest installer for any other BSKL plugins on aescripts if they stop working." --focus 2>&1 > /dev/null &
        GDIALOG_2_PID=$!
        close_gdialog_2() {
            close_gdialog # Since we're overwriting the original trap, we need to make sure this runs too
            kill $GDIALOG_2_PID || true # Always return 0 even if it fails to find the PID, so the installer doesn't fail if the user already closed this 
        }
        trap close_gdialog_2 ERR
    fi

    echo "20 Downloading Render Engine..." >&3

    # Directory where you want to extract the contents
    destination_directory="/Library/Application Support/BSKL/Render Engine/Python 3.10"

    # Temporary file for storing the downloaded zip - NOTE THIS DIRECTORY MUST ALREADY EXIST
    temp_zip="$script_dir/tempfile.zip"

    # Download the zip file
    echo "Downloading the zip file from ${url}"
    curl -L "$url" -o "$temp_zip" --fail --show-error

    # Delete the existing Render Engine (this turns out to be necessary for downgrading some packages) after making sure we can safely run "rm -r"
    calculate_size_GB() {
        local dir="$1"
        local size=$(du -sk "$dir" | cut -f1)
        echo "$((size / 1024 / 1024))"
    }
    function dir_is_safe {
        local dir=$1

        if [ -z "$dir" ]; then
            echo "Error: Destination directory is not specified."
            exit 1
        fi

        # Check for dangerous paths
        if [[ "$dir" == "/" || "$dir" == "/*" ]]; then
            echo "Error: Targeting the root directory is not allowed."
            exit 1
        fi

        # Calculate the size of the directory
        local size=$(calculate_size_GB "$dir")
        if [ $? -ne 0 ]; then
            echo "Error: Failed to calculate the size of the directory."
            exit 1
        fi

        echo "Directory size: ${size}GB"

        # Check if the directory size is greater than 15GB
        if [ "$size" -gt 15 ]; then
            echo "Error: Directory size exceeds 15GB."
            exit 1
        fi
    }

    if dir_is_safe "$destination_directory"; then
        rm -rf "$destination_directory"
        echo "Removed existing Render Engine."
    fi
    
    # If dir_is_safe fails, then the whole installation will fail (as it should)

    # Create the destination directory if it doesn't exist
    mkdir -p "$destination_directory"

    echo "60 Extracting Render Engine..." >&3

    # Extract the contents of the zip file
    echo "Extracting the contents..."
    unzip -oq "$temp_zip" -d "$destination_directory" -x "__MACOSX/*"

    # Remove the temporary zip file
    rm "$temp_zip"

    echo "Done!"
elif [ $RENDER_ENGINE_NEEDED -lt $CURRENT_VERSION ]; then
    echo "The installed Render Engine version is greater than the version this installer wants to install. Not downloading."

    "$script_dir/gDialog.app/Contents/MacOS/gDialog" msgbox --title "BSKL Installer" --text "Your local Render Engine version is more recent that the one required. This version of ${PLUGIN_NAME} might not work. If you encounter an error, please install the latest version of ${PLUGIN_NAME}." --focus 2>&1 > /dev/null &
    GDIALOG_3_PID=$!
    close_gdialog_3() {
        close_gdialog # Since we're overwriting the original trap, we need to make sure this runs too
        kill $GDIALOG_3_PID || true # Always return 0 even if it fails to find the PID, so the installer doesn't fail if the user already closed this 
    }
    trap close_gdialog_3 ERR
else
    echo "Render Engine is the correct version already. Not downloading."
fi

# We don't want the installer to fail if these commands fail, since they're just logging stuff for debugging and installing default models
set +e

# Try to move the relevant part of the pkg install log to our Logs folder
function export_log {
    LOG_NAME="${PLUGIN_NAME_LOG}_installer.log"

    # The .* is Regex so it will catch any installer name starting with PLUGIN_NAME
    STARTING_LINE_OF_LAST_INSTALL=`egrep "${PLUGIN_NAME} .* Installation Log" /var/log/install.log | tail -n 1`

    # Copy the rest of the log from that line on, up to 10000 lines.
    fgrep --after-context=10000 "$STARTING_LINE_OF_LAST_INSTALL" /var/log/install.log > "$LOGGING_DIR/$LOG_NAME"
}
export_log

# Log the installed pip packages
echo "
pip list:
"
"/Library/Application Support/BSKL/Render Engine/Python 3.10/bin/python" -m pip list

echo "
version.txt:" $(cat "/Library/Application Support/BSKL/Render Engine/Python 3.10/version.txt")

set -e

echo "EOF" >&3
exec 3>&-
close_gdialog
# Call this only if it's defined
if command -v close_gdialog_2 >/dev/null 2>&1; then
  close_gdialog_2
fi
# We don't close gdialog3 because then it would close too soon for the user to read it. It's okay if it's left hanging, it doesn't use significant CPU.