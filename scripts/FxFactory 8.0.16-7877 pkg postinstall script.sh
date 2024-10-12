#!/bin/sh

ACTUAL_USER_ID=$(stat -f "%u" "$HOME")

( sudo -u \#$ACTUAL_USER_ID "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister" -R -f "/Applications/FxFactory.app" ) || ( "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister" -R -f  "/Applications/FxFactory.app" ) || true

/usr/bin/pluginkit -a "/Applications/FxFactory.app/Contents/PlugIns/FxFactory.pluginkit"

# Install and Activate Helper Tool

FXFACTORY_PRIVILEGED_HELPER_TOOLS="/Library/PrivilegedHelperTools"
FXFACTORY_HELPER_IDENTIFIER="com.fxfactory.FxFactory.helper"
FXFACTORY_HELPER_BUNDLED_PATH="/Applications/FxFactory.app/Contents/Library/LaunchServices/${FXFACTORY_HELPER_IDENTIFIER}"
FXFACTORY_HELPER_INSTALL_PATH="${FXFACTORY_PRIVILEGED_HELPER_TOOLS}/${FXFACTORY_HELPER_IDENTIFIER}"
FXFACTORY_HELPER_LAUNCHD_PLIST="/Library/LaunchDaemons/${FXFACTORY_HELPER_IDENTIFIER}.plist"

if [ ! -d "${FXFACTORY_PRIVILEGED_HELPER_TOOLS}" ]; then
	mkdir "${FXFACTORY_PRIVILEGED_HELPER_TOOLS}"
	chown root:wheel "${FXFACTORY_PRIVILEGED_HELPER_TOOLS}"
	chmod 755 "${FXFACTORY_PRIVILEGED_HELPER_TOOLS}"
fi

# Kill Helper Tool (if already running from an existing installation)

/bin/launchctl kill SIGKILL "system/${FXFACTORY_HELPER_IDENTIFIER}"

# Remove existing file from disk, replace it with newer version bundled in our app.

rm -Rf "${FXFACTORY_HELPER_INSTALL_PATH}"
/bin/cp -f "${FXFACTORY_HELPER_BUNDLED_PATH}" "${FXFACTORY_HELPER_INSTALL_PATH}"
/usr/sbin/chown root:wheel "${FXFACTORY_HELPER_INSTALL_PATH}"
/bin/chmod 544 "${FXFACTORY_HELPER_INSTALL_PATH}"

# Remove existing plist from disk, then create a new one

rm -Rf "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Add Label string" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Set Label ${FXFACTORY_HELPER_IDENTIFIER}" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Add MachServices dict" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Add MachServices:${FXFACTORY_HELPER_IDENTIFIER} bool" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Set MachServices:${FXFACTORY_HELPER_IDENTIFIER} true" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Add Program string" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Set Program ${FXFACTORY_HELPER_INSTALL_PATH}" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Add ProgramArguments array" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Add ProgramArguments:0 string" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/usr/libexec/PlistBuddy -c "Set ProgramArguments:0 ${FXFACTORY_HELPER_INSTALL_PATH}" "${FXFACTORY_HELPER_LAUNCHD_PLIST}"
/bin/launchctl load "${FXFACTORY_HELPER_LAUNCHD_PLIST}"

if [ -f "${FXFACTORY_HELPER_LAUNCHD_PLIST}" ]; then
    /bin/launchctl enable "system/${FXFACTORY_HELPER_IDENTIFIER}"
    /bin/launchctl kickstart -kp "system/${FXFACTORY_HELPER_IDENTIFIER}"
fi

# Remove Obsolete Versions
rm -Rf "/Applications/FxFactory.app/Contents/PlugIns/FxFactoryService.pluginkit"
rm -Rf "/Library/Frameworks/NIKit.framework"
rm -Rf "$HOME/Library/Frameworks/NIKit.framework"
rm -Rf "$HOME/Library/Frameworks/FxCore.framework"
rm -Rf "$HOME/Library/Frameworks/FxFactory.framework"
rm -Rf "/Library/Graphics/Quartz Composer Plug-Ins/Noise Industries Patches.plugin"
rm -Rf "/Library/Graphics/Image Units/Noise Industries Units.plugin"
rm -Rf "$HOME/Library/Graphics/Quartz Composer Plug-Ins/Noise Industries Patches.plugin"
rm -Rf "$HOME/Library/Graphics/Image Units/Noise Industries Units.plugin"
rm -Rf "$HOME/Library/Graphics/Quartz Composer Patches/FxFactory Patches.plugin"
rm -Rf "$HOME/Library/Graphics/Image Units/FxFactory Units.plugin"
rm -Rf "/Library/Plug-Ins/FxPlug/FxFactory.fxplug"
rm -Rf "/Library/Plug-Ins/FxPlug/FxFactoryLoader.fxplug"
rm -Rf "$HOME/Library/Plug-Ins/FxPlug/FxFactory.fxplug"
rm -Rf "$HOME/Library/Plug-Ins/FxPlug/FxFactoryLoader.fxplug"
rm -Rf "/Library/Graphics/Quartz Composer Plug-Ins/NVQCRenderer.plugin"
rm -Rf "$HOME/Library/Graphics/Quartz Composer Plug-Ins/NVQCRenderer.plugin"
rm -Rf "/Library/Application Support/FxFactory/Lemke Software EPICOLOR.fxproxy"
rm -Rf "/Library/Application Support/FxFactory/Lemke Software EPICOLOR.fxtemplates"
rm -Rf "/Library/Application Support/FxFactory/Lemke Software Xe8472.fxproxy"
rm -Rf "/Library/Application Support/FxFactory/Lemke Software Xe8472.fxtemplates"
rm -Rf "/Library/Application Support/FxFactory/idustrial revolution ParticleMetrix.fxproxy"
rm -Rf "/Library/Application Support/FxFactory/idustrial revolution ParticleMetrix.fxpack"
rm -Rf "/Library/Application Support/FxFactory/idustrial revolution ParticleMetrix.fxtemplates"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/ImporterFxFactory.bundle"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS3/MediaCore/FxFactory.plugin"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS3/MediaCore/ImporterFxFactory.bundle"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS4/MediaCore/FxFactory.plugin"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS4/MediaCore/ImporterFxFactory.bundle"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS5/MediaCore/FxFactory.plugin"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS5/MediaCore/ImporterFxFactory.bundle"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS5.5/MediaCore/FxFactory.plugin"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS5.5/MediaCore/ImporterFxFactory.bundle"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS6/MediaCore/FxFactory.plugin"
rm -Rf "/Library/Application Support/Adobe/Common/Plug-ins/CS6/MediaCore/ImporterFxFactory.bundle"

# Remove individual Adobe plug-ins from current and previous versions

rm -Rf "$HOME/Library/Application Support/Adobe/Common/Plug-ins/CS3/MediaCore/FxFactory"
rm -Rf "$HOME/Library/Application Support/Adobe/Common/Plug-ins/CS4/MediaCore/FxFactory"
rm -Rf "$HOME/Library/Application Support/Adobe/Common/Plug-ins/CS5/MediaCore/FxFactory"
rm -Rf "$HOME/Library/Application Support/Adobe/Common/Plug-ins/CS5.5/MediaCore/FxFactory"
rm -Rf "$HOME/Library/Application Support/Adobe/Common/Plug-ins/CS6/MediaCore/FxFactory"
rm -Rf "$HOME/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/FxFactory"

sudo -u \#$ACTUAL_USER_ID open -g "/Applications/FxFactory.app"

exit 0
