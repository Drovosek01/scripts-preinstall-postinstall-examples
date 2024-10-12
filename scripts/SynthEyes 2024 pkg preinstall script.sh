#!/bin/bash
# This script removes official scripts from earlier versions of SynthEyes
# 	that have been moved to a new location, leaving user-added ones.
#	Shouldn't be necessary for side-by-side installs for BorisFX 
# Note that TARG is generally just "/"
if [ "$DSTROOT" = "/" ]; then
    TARG=""
else
    TARG="$DSTROOT"
fi

# rm -f "$TARG/Applications/SynthEyes/CameraCalibration.pdf"	# moved to Documentation
# rm -f "$TARG/Applications/SynthEyes/ChangeList.pdf"
# rm -f "$TARG/Applications/SynthEyes/GeoHTracking.pdf"
# rm -f "$TARG/Applications/SynthEyes/scripts/unsolv2mocap.szl"
# rm -f "$TARG/Applications/SynthEyes/scripts/vtxweilist.szl"
# rm -f "$TARG/Applications/SynthEyes/scripts/vueinfin.szl"
# ...
exit 0
