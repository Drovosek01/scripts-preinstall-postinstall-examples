#!/bin/bash

export LOG_DIR="${HOME}/Library/Application Support/Topaz Labs LLC/Topaz Video AI"
mkdir -p "${LOG_DIR}"
echo "Starting preinstall" > "${LOG_DIR}/vai-install.log"

if [ -d ${DSTROOT}/Applications/"Topaz Video AI.app/Contents/Resources/presets" ]; then
	mkdir -p $TMPDIR/VAI-upgrade/presets/
	echo cp -Rp ${DSTROOT}/Applications/"Topaz Video AI.app/Contents/Resources/presets/"* $TMPDIR/VAI-upgrade/presets/ >> "${LOG_DIR}/vai-install.log"
	cp -Rp ${DSTROOT}/Applications/"Topaz Video AI.app/Contents/Resources/presets/"* $TMPDIR/VAI-upgrade/presets/
fi

if [ -d ${DSTROOT}/Applications/"Topaz Video AI.app/Contents/Resources/models" ]; then
	mkdir -p $TMPDIR/VAI-upgrade/models/
	echo cp -Rp ${DSTROOT}/Applications/"Topaz Video AI.app/Contents/Resources/models/"*.tz $TMPDIR/VAI-upgrade/models/ >> "${LOG_DIR}/vai-install.log"
	cp -Rp ${DSTROOT}/Applications/"Topaz Video AI.app/Contents/Resources/models/"*.tz $TMPDIR/VAI-upgrade/models/
fi
	
echo "Finished preinstall" >> "${LOG_DIR}/vai-install.log"
