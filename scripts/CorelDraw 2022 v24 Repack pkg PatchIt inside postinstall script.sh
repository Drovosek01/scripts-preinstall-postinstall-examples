#! /bin/bash

export PLISTBUDDY=/usr/libexec/PlistBuddy
export patch_files_folder=$2

if [ -z $patch_files_folder ]
then
    patch_files_folder="/Users/macuser/Library/Preferences/com.corel.CUH.update/2.169"
fi



function WriteLog
{
    echo $1
    echo $1 >>"$patch_files_folder/update.log"
}

WriteLog "------------------------------------------------------"
WriteLog "0 = $0"
WriteLog "1 = $1"
WriteLog "2 = $2"
WriteLog "3 = $3"
WriteLog "patch_files_folder = $patch_files_folder"


function Main
{
	WriteLog "patchit.pkg"
	WriteLog "patchit install start"
	WriteLog "$(date)"
	WriteLog "X86_64 version"

	
	CUHPlistInstalled=/Library/Preferences/com.corel.CUH/com.corel.Registry.plist
	CUHPlistInstalledARM64=/Library/Preferences/com.corel.CUH/com.corel.Registry_ARM64.plist
	CUHPlistPatched=$patch_files_folder/com.corel.CUH/com.corel.Registry.plist
	
	if [ -f $CUHPlistInstalledARM64 ]; then
	
		WriteLog "ARM64 get installed, add ARM64 version"
		
		ver_in_patch_full_numberARM64=$($PLISTBUDDY -c 'Print :SOFTWARE:Corel:CUH:2.0:ARM64version:1' $CUHPlistInstalledARM64)
	
		if [ -z $ver_in_patch_full_numberARM64 ]; then
			WriteLog "ARM64 version not found"
		else 
			WriteLog "ARM64 version: $ver_in_patch_full_numberARM64"
		  	#Add ARM64 version
	
			$PLISTBUDDY -c "Add 'SOFTWARE:Corel:CUH:2.0:ARM64version' array" "$CUHPlistPatched"
			$PLISTBUDDY -c "Add 'SOFTWARE:Corel:CUH:2.0:ARM64version:0' integer 1" "$CUHPlistPatched"
			$PLISTBUDDY -c "Add 'SOFTWARE:Corel:CUH:2.0:ARM64version:1' string $ver_in_patch_full_numberARM64" "$CUHPlistPatched"

		fi
	fi
	
    WriteLog "installed: $CUHPlistInstalled"
    WriteLog "installing: $CUHPlistPatched"

    if [ ! -f $CUHPlistInstalled ]
    then
        copyFiles=1  # first install
        WriteLog 'CUH Not exits ... will install files'
    else

        ver_installed_full_number=$($PLISTBUDDY -c 'Print :SOFTWARE:Corel:CUH:2.0:version:1' $CUHPlistInstalled)
        if [ -z $ver_installed_full_number ]
        then
            ver_installed_full_number='2.160'
        fi
        
        ver_installed=0
        IFS='.' read -ra ADDR <<< "$ver_installed_full_number"
		for i in "${ADDR[@]}"; do
    		ver_installed="$i"
		done

        ver_in_patch_full_number=$($PLISTBUDDY -c 'Print :SOFTWARE:Corel:CUH:2.0:version:1' $CUHPlistPatched)
        if [ -z $ver_in_patch_full_number ]
        then
            ver_in_patch_full_number=1000
        fi

        ver_in_patch=0
        IFS='.' read -ra ADDR <<< "$ver_in_patch_full_number"
		for i in "${ADDR[@]}"; do
    		ver_in_patch="$i"
		done
		
		WriteLog "ver_in_patch_full_number  = $ver_in_patch_full_number"
        WriteLog "ver_in_patch  = $ver_in_patch"
        WriteLog "ver_installed_full_number  = $ver_installed_full_number"
        WriteLog "ver_installed = $ver_installed"

        copyFiles=0
        isPatchGreater=$(echo "$ver_in_patch>$ver_installed" | bc)


        if [ $ver_in_patch == $ver_installed ] || [ $isPatchGreater == 1 ]
        then
            WriteLog "$ver_in_patch >= $ver_installed ... upgrade attempt upgrade"
            copyFiles=1
        else
            WriteLog "$ver_in_patch < $ver_installed ... already up to date"
            copyFiles=0
        fi
    fi #if [ ! -f CUHPlistInstalled ]

	WriteLog "copyFiles: $copyFiles"
    if [ $copyFiles -eq 1 ]
    then

        WriteLog "delete unnecessary policy file"
        if [ -f /Library/Preferences/com.corel.CUH/Message.policy ]
        then
            rm -rf /Library/Preferences/com.corel.CUH/Message.policy
        fi

    	WriteLog "copy files"
        ditto $patch_files_folder/com.corel.CUH /Library/Preferences/com.corel.CUH
        ditto $patch_files_folder/com.corel.PCU /Library/Preferences/com.corel.PCU2
        ditto $patch_files_folder/Corel/Messages /Library/Preferences/Corel/Messages
		
        CUH_CU_Plist=~/Library/Preferences/com.corel.CUH/com.corel.Registry.plist
        if [ -f $CUH_CU_Plist ]
        then
            WriteLog "Sync Software to SOFTWARE"
            sed -i '' 's/<key>Software<\/key>/<key>SOFTWARE<\/key>/g' "$CUH_CU_Plist"
        fi
        $PLISTBUDDY -c "Delete 'SOFTWARE:Corel:CUH:Current Version:UpdateFrequency'" "$CUH_CU_Plist"
        $PLISTBUDDY -c "Add 'SOFTWARE:Corel:CUH:Current Version:UpdateFrequency' array" "$CUH_CU_Plist"
        $PLISTBUDDY -c "Add 'SOFTWARE:Corel:CUH:Current Version:UpdateFrequency:0' integer 4" "$CUH_CU_Plist"
        $PLISTBUDDY -c "Add 'SOFTWARE:Corel:CUH:Current Version:UpdateFrequency:1' integer 1" "$CUH_CU_Plist"
        
        
    fi

    WriteLog "patchit install end"
    WriteLog "$(date)"
}


Main

