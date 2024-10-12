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

##################################################################
# The following perl function kills a process by the passed name
# it returns 0 if it killed a process, 1 otherwise
#
function kill_by_name
{
perl -e '
	$process_name = $ARGV[0];
	
	open(PS,qq{ps -ax |});
	
	foreach (<PS>)
	{
		if ($_ =~ /\/$process_name/)
		{
			s/^\s+|\s+$//g;
			@proc = split /\s+/, $_, 2;	
			print qq{Process $proc[0] stopped.\n};
			kill 9, $proc[0];
			close PS;
			exit 0;		
		}
	}
	close PS;
	exit 1;
	' $1
	return $?
}

###############################################################

# check for installed components
res=""

if [ -f '/usr/local/sentinel/aksusbd' ]; then res="daemon"; fi
if [ -f '/usr/local/sentinel/hasplmd' ]; then res="daemon"; fi
if [ -f '/Library/LaunchDaemons/com.aladdin.aksusbd.plist' ]; then res="$res plist"; fi
if [ -f '/Library/LaunchDaemons/com.aladdin.hasplmd.plist' ]; then res="$res plist"; fi
if [ -d '/System/Library/StartupItems/Aladdin' ]; then res="$res LegacyStartupItem"; fi
if [ -d '/Library/StartupItems/Aladdin' ]; then res="$res StartupItem"; fi
if [ $(ls -l /Library/Receipts/AKS*.pkg 2> /dev/null | wc -l) != '0' ]; then res="$res AKS_Receipt"; fi
if [ $(ls -l /Library/Receipts/HASP*.pkg 2> /dev/null | wc -l) != '0' ]; then res="$res HASP_Receipt"; fi
if [ $(ls -l /Library/Receipts/Sentinel*.pkg 2> /dev/null | wc -l) != '0' ]; then res="$res Sentinel_Receipt"; fi
if [ $(pkgutil --pkgs=com.ealaddin.haspsrm.dinst | wc -l) != '0' ]; then res="$res pkginfo"; fi
#if [  "`launchctl list | grep aksusbd`" ]; then res="$res 5"; fi
#if [  "`launchctl list | grep hasplmd`" ]; then res="$res 5"; fi

##################################################################
# now we get the major version of the OS
#
sysv=`perl -e '@v = split /\./, $ARGV[0]; print $v[0];' \`uname -r\``

if [ "$res" == "" ]; then
	echo "There are no Sentinel driver components installed."
	exit
else
 	echo Found Sentinel components: $res 
 	if [ "$1" == "-c" ]; then
 		exit
 	fi
fi

err=0

# remove the legacy startup item
if [ -d '/System/Library/StartupItems/Aladdin' ]; 
then 
	rm -rf /System/Library/StartupItems/Aladdin
	echo removed legacy startup item
fi

# remove the startup item
if [ -d '/Library/StartupItems/Aladdin' ]; 
then 
	rm -rf /Library/StartupItems/Aladdin
	echo removed startup item
fi

# look if launchd plist exists
if [ -f '/Library/LaunchDaemons/com.aladdin.aksusbd.plist' ];
then 
	if [ "`launchctl list | grep aksusbd`" ]; 
	then 
		launchctl unload '/Library/LaunchDaemons/com.aladdin.aksusbd.plist'
	fi
	
	if [ "`launchctl list | grep aksusbd`" ]; 
	then 
		err=1
	fi

	# remove the LaunchDaemons plist
	rm -f /Library/LaunchDaemons/com.aladdin.aksusbd.plist
	echo removed launchd plist for USB daemon
fi

if [ -f '/Library/LaunchDaemons/com.aladdin.hasplmd.plist' ];
then 
	if [ "`launchctl list | grep hasplmd`" ]; 
	then 
		launchctl unload '/Library/LaunchDaemons/com.aladdin.hasplmd.plist'
	fi
	
	if [ "`launchctl list | grep hasplmd`" ]; 
	then 
		err=1
	fi

	# remove the LaunchDaemons plist
	rm -f /Library/LaunchDaemons/com.aladdin.hasplmd.plist
	echo removed launchd plist for LLM daemon
fi

#if the daemon is running, kill it
kill_by_name aksusbd
kill_by_name hasplmd


# if the daemon exists remove it
if [ -f '/usr/local/sentinel/hasplmd' ];
then
	rm -f /usr/local/sentinel/aksusbd
	echo removed USB daemon
fi

# if the daemon exists remove it
if [ -f '/usr/local/sentinel/hasplmd' ];
then
	rm -f /usr/local/sentinel/hasplmd
	echo removed LLM daemon
fi

# delete /usr/local/sentinel folder
if [ -d '/usr/local/sentinel' ]; then
	rm -rf /usr/local/sentinel
fi

# if package receipt exists, remove it
#if [ "`find /Library/Receipts  -name AKS*.pkg`" ];
#then
#	rm -rf /Library/Receipts/AKS*.pkg
#	echo removed package receipt
#fi

# if package receipt exists, remove it
#if [ "`find /Library/Receipts  -name HASP*.pkg`" ];
#then
#	rm -rf /Library/Receipts/HASP*.pkg
#	echo removed package receipt
#fi

# if package receipt exists, remove it
#if [ "`find /Library/Receipts  -name Sentinel*.pkg`" ];
#then
#	rm -rf /Library/Receipts/HASP*.pkg
#	echo removed package receipt
#fi

# if one of these package receipt exists, remove it
if [ -d '/Library/Receipts' ]; 
then
	if [ $(ls -l /Library/Receipts/AKS*.pkg  2> /dev/null | wc -l) != '0' ]; then
		rm -rf /Library/Receipts/AKS*.pkg
		echo removed package receipt
	fi

	if [ $(ls -l /Library/Receipts/HASP*.pkg 2> /dev/null | wc -l) != '0' ]; then
		rm -rf /Library/Receipts/HASP*.pkg
		echo removed package receipt
	fi

	if [ $(ls -l /Library/Receipts/Sentinel*.pkg 2> /dev/null | wc -l) != '0' ]; then
		rm -rf /Library/Receipts/Sentinel*.pkg
		echo removed package receipt
	fi
fi


### replaced by using pkgutil, which also deal with InstallHistory.plist
# if [ $(ls -l /private/var/db/receipts/com.ealaddin.haspsrm.* | wc -l) != '0' ];
# then
#   rm -rf /private/var/db/receipts/com.ealaddin.haspsrm.*
#   echo removed package receipt
# fi

if [ $(pkgutil --pkgs=com.ealaddin.haspsrm.dinst | wc -l) != '0' ]; then
#   pkgutil --force --unlink com.ealaddin.haspsrm.dinst
      pkgutil --force --forget com.ealaddin.haspsrm.dinst > /dev/null 2>&1
fi

echo "Sentinel SRM software was removed successfully."                                                                    
echo "The directory /etc/hasplm (for configuration files and settings)"                                           
echo "and /var/hasplm (for vendor libraries) were not removed."                                                   
echo "The directories can be manually deleted."                                                                   

if [ $err == 1 ]; then
	echo NOTE: launchd plist could not be unloaded, please restart computer to complete uninstall.
fi
