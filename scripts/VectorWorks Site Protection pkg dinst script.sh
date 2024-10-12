#!/bin/sh
#

if [ "$EUID" != "0" ]; then 
	echo "Must be run as root" 
	exit 1
fi

if [ $(uname -s) != "Darwin" ]; then
    echo "Not running on Darwin/MacOSX -- aborted!"
    exit 1
fi

DARWINVER=$(uname -p | sed -e s/i.86/x86/)

if [ $DARWINVER != x86 ]; then
	if [ $DARWINVER != arm ]; then
		echo "Current system not support by this version Sentinel Runtime"
		exit 1
	fi
fi

needupd=0

DARWINVER=$(uname -p | sed -e s/i.86/x86/)

while true; do

# echo "check v2c update"
if [ ! -z "$(find ./ -type f -iname "*.v2c")" ]; then
   # echo "v2c update found"
   echo "Update/Install required"
   needupd=1
   break
fi

###############################
# check if aksusbd is newer
###############################

# echo "check aksusbd"
if [ -f "/usr/local/sentinel/aksusbd" ]; then
   # echo "aksusbd found, check version"
   usbmaj=8
   usbmin=43
   usbrel=1
   
   usbactmaj=$(/usr/local/sentinel/aksusbd -v | cut -f3 -d\ | cut -f1 -d.)
   usbactmin=$(/usr/local/sentinel/aksusbd -v | cut -f3 -d\ | cut -f2 -d.)
   usbactrel=$(/usr/local/sentinel/aksusbd -v | cut -f3 -d\ | cut -f3 -d.)
   
   
   if [ "$usbmaj" -gt "$usbactmaj" ]; then
	  # echo "Major aksusbd update"
	  needupd=1
   else
	  if [ "$usbmaj" -eq "$usbactmaj" ]; then
		  if [ "$usbmin" -gt "$usbactmin" ]; then
			 # echo "Minor aksusbd update"
			 needupd=1
		  else
			   if [ "$usbmaj" -eq "$usbactmaj" ]; then
				  if [ "$usbmin" -eq "$usbactmin" ]; then
					 if [ "$usbrel" ];then
						if [ "$usbactrel" ]; then
						   if [ "$usbrel" -gt "$usbactrel" ]; then
							  # echo "Release aksusbd update 2"
							  needupd=1
						   fi
						else
						   # echo "Release aksusbd update 1"
						   needupd=1
						fi
					 fi
				fi
			 fi
		  fi
	  fi
   fi
else
   # aksusbd not found
   # echo "aksusbd not found"
   needupd=1
fi


###############################
# check if update required
###############################

if [ "$needupd" == 1 ]; then
   echo "Update/Install required"
   break
fi

###############################
#check if hasplmd is newer
###############################

# echo "check hasplmd"

# workarround for snow leopard
sysv=`perl -e '@v = split /\./, $ARGV[0]; print $v[0];' \`uname -r\``
if [ $sysv == 10 ]; then
   filesize=$(ls -l /usr/local/sentinel/hasplmd | cut -f8 -d\ )
   if [ $filesize == 3362236 ]; then # SRM 3.10,3.50,3.60 (all the same)
     echo "Update/Install required"
     needupd=1
	 break
   fi
   if [ $filesize == 3547136 ]; then # CIR February 2009
     echo "Update/Install required"
     needupd=1
	 break
   fi
   if [ $filesize == 3625984 ]; then # CIR March 2009
     echo "Update/Install required"
     needupd=1
	 break
   fi
   if [ $filesize == 3568640 ]; then # SRM 4.0
     echo "Update/Install required"
     needupd=1
	 break
   fi
fi
# end of workarround for snow leopard

if [ -f "/usr/local/sentinel/hasplmd" ]; then
   # echo "hasplmd found, check version"
   llmmaj=27
   llmmin=2
   llmrel=132089

   llmactmaj=$(/usr/local/sentinel/hasplmd -v | cut -f3 -d\ | cut -f1 -d.)
   llmactmin=$(/usr/local/sentinel/hasplmd -v | cut -f3 -d\ | cut -f2 -d.)
   llmactrel=$(/usr/local/sentinel/hasplmd -v | cut -f3 -d\ | cut -f4 -d.)
   
   if [ "$llmmaj" -gt "$llmactmaj" ]; then
	  # echo "Major hasplmd update"
	  needupd=1
   else
	  if [ "$llmmaj" -eq "$llmactmaj" ]; then
		  if [ "$llmmin" -gt "$llmactmin" ]; then
			 # echo "Minor hasplmd update"
			 needupd=1
		  else
			   if [ "$llmmaj" -eq "$llmactmaj" ]; then
				  if [ "$llmmin" -eq "$llmactmin" ]; then
					 if [ "$llmrel" ];then
						if [ "$llmactrel" ]; then
						   if [ "$llmrel" -gt "$llmactrel" ]; then
							  # echo "Release hasplmd update 2"
							  needupd=1
						   fi
						else
						   # echo "Release hasplmd update 1"
						   needupd=1
						fi
					 fi
				fi
			 fi
		  fi
	  fi
   fi
else
   # hasplmd not found
   # echo "hasplmd not found"
   needupd=1
fi

break

done

###############################
# check if update required
###############################

if [ "$needupd" == 0 ]; then
   echo "Sentinel Runtime Can't be installed on this computer. Either Current or Newer Version is already installed."
else
   ## Checking Update/Install required
   echo "Installing Sentinel Runtime RTE Package."
   sudo installer -pkg "Sentinel Runtime.pkg" -target /
fi

echo done.
