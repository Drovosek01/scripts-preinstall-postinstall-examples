#!/bin/bash
#prepare directories
if [ -a "/Library/Application Support/BorisFX/Lib/BCC17EmittersArchive" ]; then
  rm -Rf "/Library/Application Support/BorisFX/Lib/BCC17EmittersArchive"
fi

if ! [ -a "/Library/Application Support/BorisFX/Lib/BCC17EmittersArchive" ]; then
  /bin/mkdir "/Library/Application Support/BorisFX/Lib/BCC17EmittersArchive"
fi
if [ -d "/Library/Application Support/BorisFX/Lib/BCC17EmittersArchive" ]; then
  /bin/chmod 775 "/Library/Application Support/BorisFX/Lib/BCC17EmittersArchive"
  /usr/sbin/chown root:admin "/Library/Application Support/BorisFX/Lib/BCC17EmittersArchive"
fi

#clean old
if [ -a "/Library/Application Support/BorisFX/EmitterLibraries/Emitters_2021.il3" ]; then
  rm -Rf "/Library/Application Support/BorisFX/EmitterLibraries/Emitters_2021.il3"
fi
if [ -a "/Library/Application Support/BorisFX/EmitterLibraries/Emitters_2020.il3" ]; then
  rm -Rf "/Library/Application Support/BorisFX/EmitterLibraries/Emitters_2020.il3"
fi


#prepare directories
if ! [ -a "/Library/Application Support/BorisFX" ]; then
  mkdir "/Library/Application Support/BorisFX"
  chmod 777 "/Library/Application Support/BorisFX"
  chown root:admin "/Library/Application Support/BorisFX"
fi
if ! [ -a "/Library/Application Support/BorisFX/EmitterLibraries" ]; then
  mkdir "/Library/Application Support/BorisFX/EmitterLibraries"
  chmod 777 "/Library/Application Support/BorisFX/EmitterLibraries"
  chown root:admin "/Library/Application Support/BorisFX/EmitterLibraries"
fi
exit 0
