#!/bin/bash

FILES_TO_REMOVE="libndi.dylib libndi.3.dylib libndi.4.dylib libavcodec.55.dylib libavcodec.57.dylib libavformat.55.dylib libavformat.57.dylib libavutil.52.dylib libavutil.55.dylib libswscale.2.dylib libswscale.4.dylib libArtnet.dylib libltc.dylib libpng16.16.dylib libturbojpeg.0.dylib libfreetype.6.dylib"
for FILE in ${FILES_TO_REMOVE}; do
    if [ -e "/Applications/Resolume Arena/Arena.app/Contents/MacOS/${FILE}" ]; then
        rm "/Applications/Resolume Arena/Arena.app/Contents/MacOS/${FILE}"
    fi
done

OLD_FFMPEG_LIBS="libavcodec.59.dylib libavformat.58.dylib libavutil.57.dylib libswscale.6.dylib libavfilter.8.dylib";
for FILE in ${OLD_FFMPEG_LIBS}; do
    if [ -e "/Applications/Resolume Arena/${FILE}" ]; then
        rm "/Applications/Resolume Arena/${FILE}";
    fi;
done;

if [ -e "/Library/Application Support/Resolume/beta/nodes/wire/transport.dylib" ]; then
    rm "/Library/Application Support/Resolume/beta/nodes/wire/transport.dylib";
fi;

ADOBE_PLUGIN_PATH="/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/Resolume DXV"
if [ -e "${ADOBE_PLUGIN_PATH}" ]; then
    find "${ADOBE_PLUGIN_PATH}" -type d -exec touch {} \;
fi;

if [ -d "/Applications/Resolume Arena/Arena.app/Contents/MacOS/BugsplatMac.framework" ]; then
    rm -r "/Applications/Resolume Arena/Arena.app/Contents/MacOS/BugsplatMac.framework"
fi
if [ -d "/Applications/Resolume Arena/Arena.app/Contents/MacOS/Sparkle.framework" ]; then
    rm -r "/Applications/Resolume Arena/Arena.app/Contents/MacOS/Sparkle.framework"
fi

# Remove old plugins if they exist
if [ -d "/Applications/Resolume Arena/plugins/ffgl/Chromakey.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/Chromakey.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/FFGLBarShift.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/FFGLBarShift.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/FFGLEdgeDetection.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/FFGLEdgeDetection.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/FFGLStopMotion.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/FFGLStopMotion.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/FFGLWaveWarp.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/FFGLWaveWarp.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Fragment.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Fragment.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Goo.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Goo.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Iterate.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Iterate.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Kaleidoscope.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Kaleidoscope.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_RadialBlur.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_RadialBlur.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Ripples.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Ripples.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Stripper.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Stripper.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Tunnel.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_Tunnel.bundle";
fi
if [ -d "/Applications/Resolume Arena/plugins/ffgl/SyzGL_VideoWall.bundle" ]; then
    rm -rf "/Applications/Resolume Arena/plugins/ffgl/SyzGL_VideoWall.bundle";
fi

for DIR in "/Users/Shared/Library/Application Support/Resolume "*; do
    if [ -d "${DIR}" ]; then
        rmdir "${DIR}";
    fi;
done;

if [ -d "/Users/Shared/Library/Application Support" ]; then
    rmdir "/Users/Shared/Library/Application Support";
fi
if [ -d "/Users/Shared/Library" ]; then
    rmdir "/Users/Shared/Library";
fi

if [ -e "/Library/Application Support/Resolume Arena/registration" ]; then
    chmod ugo+rx "/Library/Application Support/Resolume Arena/";
    chmod ugo+rwx "/Library/Application Support/Resolume Arena/registration";
    chmod -R ugo+rw "/Library/Application Support/Resolume Arena/registration";
fi
if [ -e "/Library/Application Support/Resolume Avenue/registration" ]; then
    chmod ugo+rx "/Library/Application Support/Resolume Avenue/";
    chmod ugo+rwx "/Library/Application Support/Resolume Avenue/registration";
    chmod -R ugo+rw "/Library/Application Support/Resolume Avenue/registration";
fi
if [ -e "/Library/Application Support/Resolume Wire/registration" ]; then
    chmod ugo+rx "/Library/Application Support/Resolume Wire/";
    chmod ugo+rwx "/Library/Application Support/Resolume Wire/registration";
    chmod -R ugo+rw "/Library/Application Support/Resolume Wire/registration";
fi

open "/Applications/Resolume Arena/Arena.app" || true
