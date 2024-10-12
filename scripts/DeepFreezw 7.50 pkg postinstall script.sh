#!/bin/sh

# $1: Full path to the installation package the Installer application is processing.
#	For example: /Volumes/Users/adminuser/Desktop/DFX.pkg
# $2: Full path to the installation destination. For example: /Applications
# $3: Installation volume (or mount point) to receive the payload. For example: /Volumes/Macintosh\ HD
# $4: The root directory for the system: /

STORAGESPACE_PLIST="${3}/Library/LaunchDaemons/com.faronics.storagespaced.plist"
LAUNCHD_PLIST="${3}/Library/LaunchDaemons/com.faronics.deepfreezed.plist"

# Ensure that the StorageSpace daemon is running before launching our daemon
/bin/launchctl bootstrap system "${STORAGESPACE_PLIST}"

# First we need to stop existing service, if it was running
/bin/launchctl bootout system "${LAUNCHD_PLIST}"

# Then we use bootstrap to load the daemon
/bin/launchctl bootstrap system "${LAUNCHD_PLIST}"

#
# Change the Password Change Interval in /Library/Preferences/DirectoryService/ActiveDirectory.plist
# passinterval option can always be set regardless whether this computer is bound to
# Active Directory or not.
#
/usr/sbin/dsconfigad -passinterval 0


# Script to clean up Deep Freeze 6.2 components from Mojave
#

# remove PDB
if [ -e "${3}/.dfxdata.dat" ]; then
	rm -rf "${3}/.dfxdata.dat"
fi

# if the Deep Freeze driver exists in /Library/Extensions or /System/Library/Extensions
# try to remove all different versions of the driver
if [ -e "${3}/Library/Extensions/DFXDriver.kext" -o -e "${3}/System/Library/Extensions/DFXDriver.kext" ]; then
	# remove new driver, which was installed with Deep Freeze 5.8 or higher, regardless of OS version
	rm -rf "${3}/Library/Extensions/DFXDriver.kext"

	# remove driver (Deep Freeze <= 5.7 or OS <= 10.8)
	rm -rf "${3}/System/Library/Extensions/DFXDriver.kext"

	# remove 10.7 driver (Deep Freeze >= 5.8 and OS <= 10.8 at install)
	rm -rf "${3}/System/Library/Extensions/DFXDriver10_7.kext"

	# remove 10.6 driver (Deep Freeze >= 5.8 and OS <= 10.6 at install)
	rm -rf "${3}/System/Library/Extensions/DFXRetroDriver.kext"

	# mark the extensions folder as modified (to rebuild the kext cache)
	/usr/bin/touch "${3}/Library/Extensions"

	echo "Removed old Deep Freeze HFS+ driver"
fi

# remove Launchd plists for the helper tool
if [ -e "${3}/Library/LaunchDaemons/com.faronics.deepfreezehelperd.plist" ]; then
	rm -rf "${3}/Library/LaunchDaemons/com.faronics.deepfreezehelperd.plist"
fi

# remove the actual daemons
if [ -e "${3}/Library/PrivilegedHelperTools/com.faronics.deepfreezed" ]; then
	rm -rf "${3}/Library/PrivilegedHelperTools/com.faronics.deepfreezed"
fi

# remove the deep freeze helper
if [ -e "${3}/Library/PrivilegedHelperTools/com.faronics.deepfreezehelperd" ]; then
	rm -rf "${3}/Library/PrivilegedHelperTools/com.faronics.deepfreezehelperd"
fi

# remove the commandline tool
if [ -e "${3}/Library/Application Support/Faronics/Deep Freeze/deepfreeze" ]; then
	rm -rf "${3}/Library/Application Support/Faronics/Deep Freeze/deepfreeze"
fi

# remove the preference plist
if [ -e "${3}/Library/Preferences/com.faronics.dfxcontrol.plist" ]; then
	rm -f "${3}/Library/Preferences/com.faronics.dfxcontrol.plist"
fi

# remove application
if [ -e "${3}/Applications/Faronics/DFXControl.app" ]; then
	rm -rf "${3}/Applications/Faronics/DFXControl.app"
fi

# Remove the receipt data from the database
# but do not remove com.Faronics.pkg.dfx because the 7.1 uses com.faronics.pkg.dfx
# as identifier (F instead of f)
pkgutil --forget "com.Faronics.pkg.dfxdriver" --volume "${3}" >/dev/null 2>&1
pkgutil --forget "com.Faronics.pkg.dfxdriver10_7" --volume "${3}" >/dev/null 2>&1
pkgutil --forget "com.Faronics.pkg.dfxretrodriver" --volume "${3}"  >/dev/null 2>&1

# remove the software update files
if [ -e "${3}/Library/Preferences/com.faronics.statusInfo.plist" ]; then
	rm -rf "${3}/Library/Preferences/com.faronics.statusInfo.plist"
fi

if [ -e "${3}/Library/Preferences/com.faronics.updateList.plist" ]; then
	rm -rf "${3}/Library/Preferences/com.faronics.updateList.plist"
fi


exit 0
