#! /bin/bash

export PLISTBUDDY=/usr/libexec/PlistBuddy
export patch_files_folder=$2

if [ -z $patch_files_folder ]
then
    patch_files_folder="/Library/Preferences/com.corel.CUH.update/13.0.0.331"
fi




function WriteLog
{
    echo $1
    echo $1 >>"$patch_files_folder/update.log"
}

function Main
{
	WriteLog "launchagent.pkg"
	
	ditto $patch_files_folder/X86_64 /Library/LaunchAgents

	
	chown root:wheel /Library/LaunchAgents/com.corel.CorelUpdateHelperTask.agent.plist
	chmod 644 /Library/LaunchAgents/com.corel.CorelUpdateHelperTask.agent.plist

	cnt=1
	while [ ! -f /Library/Preferences/com.corel.CUH/CUH.app/Contents/MacOS/CUH ]
	do
    	WriteLog "CUH.app NOT found... sleeping... $cnt"
    	sleep 2
    	
    	let cnt++
    	if [ $cnt == 4 ]
    	then
    		break
    	fi
	done
	
	if [ ! -f /Library/Preferences/com.corel.CUH/CUH.app/Contents/MacOS/CUH ]
	then
		WriteLog "CUH.app not found... exit, agent will start next reboot ..."
	else
		WriteLog "CUH.app found... executing..."
  
  		LOGGEDUSERS=`who | awk '/console/ { print $1 }'`
  		for CURRENTUSER in $LOGGEDUSERS
  		do
			su -l $CURRENTUSER -c 'launchctl load -w /Library/LaunchAgents/com.corel.CorelUpdateHelperTask.agent.plist'
			WriteLog "launchctl"
	
    		su -l $CURRENTUSER -c '/Library/Preferences/com.corel.CUH/CUH.app/Contents/MacOS/CUH -schedule 0'
    		WriteLog "schedule"
    
	    	su -l $CURRENTUSER -c 'open /Library/Preferences/com.corel.CUH/CUH.app --args /t'
    		WriteLog "args /t"
    	done

    fi
    
	
}

Main


