#!/usr/bin/env bash

if [ -e /usr/local/bin/wolframscript ]; then
	rm -rf /usr/local/bin/wolframscript
fi

# /usr/local/bin not guaranteed to be there. (https://bugs.wolfram.com/show?number=391970)
if [ ! -e /usr/local/bin ]; then
    mkdir -p /usr/local/bin
fi

ln -s /Applications/WolframScript.app/Contents/MacOS/wolframscript /usr/local/bin/wolframscript

touch /etc/paths.d/wolframscript
echo "/usr/local/bin" > /etc/paths.d/wolframscript
chmod 755 /etc/paths.d/wolframscript

touch /etc/manpaths.d/wolframscript
echo "/usr/local/share/man" > /etc/manpaths.d/wolframscript
chmod 755 /etc/manpaths.d/wolframscript

echo 0


