#! /bin/bash

export PLISTBUDDY=/usr/libexec/PlistBuddy
export install_directory=$2

#uncomment and change path to debug outside of installer
#needs point to folder where product_enum.plist can be found
#export install_directory="/Users/builder/Documents/IPM_Common_Modules_Mac-latest/IPM/Version1/IPM_Common_Modules_Mac/Fileset/com.corel.PCU"


function WriteLog
{
    echo $1
    echo $1 >>"$install_directory/update.log"
}


function Main
{
    component_template="$install_directory/product_enum.plist"
    commonplist="$install_directory/com.Corel.Registry.plist"

    component_template_Installed="/Library/Preferences/com.corel.PCU2/product_enum.plist"
    commonplist_Installed="/Library/Preferences/com.corel.PCU2/com.Corel.Registry.plist"
	
	WriteLog "PCU install start"
	WriteLog "$(date)"

    WriteLog $component_template
    WriteLog $commonplist

    if [[ -e $component_template_Installed ]]; then
        templateInstalledVersion=$($PLISTBUDDY -c 'Print :version:1' "$component_template_Installed");
        templatePatchVersion=$($PLISTBUDDY -c 'Print :version:1' "$component_template");

        if [ -z "$templateInstalledVersion" ]
        then
            WriteLog "Update product_enum.plist : $component_template"
            cp -Rf $component_template $component_template_Installed
        else
            installedVersion=${templateInstalledVersion##*.};
            patchVersion=${templatePatchVersion##*.};
            isInstalledGreater=$(echo "$installedVersion>$patchVersion" | bc)

            if [ $isInstalledGreater == 1 ]
            then
                WriteLog "Use Installed product_enum.plist : $component_template_Installed"
                cp -Rf $component_template_Installed $component_template
            else
                WriteLog "Update product_enum.plist : $component_template"
                cp -Rf $component_template $component_template_Installed
            fi
        fi
    fi

	# https://coreljira.atlassian.net/browse/EC-254
	folder="/Library/Preferences/Corel/bin"
	mkdir -p $folder
	chown root:wheel $folder
	chmod 777 $folder
	
	folder="/Library/Preferences/Corel/Downloads"
	mkdir -p $folder
	chown root:wheel $folder
	chmod 777 $folder
	
    products_str=$($PLISTBUDDY -c 'Print ProductList' "$component_template")

    IFS=:
    products=($products_str)
    for index in "${!products[@]}"
    do
        WriteLog "$index ${products[$index]}"

        # get templated item
        key="${products[$index]}"

        Regkey=$($PLISTBUDDY -c "Print :$key:Regkey" "$component_template")
        Path=$($PLISTBUDDY -c "Print :$key:Path" "$component_template")
        NLRFilename=$($PLISTBUDDY -c "Print :$key:NLRFilename" "$component_template")
        DTAFilename=$($PLISTBUDDY -c "Print :$key:DTAFilename" "$component_template")
        ApplicationBundleIdentifier=$($PLISTBUDDY -c "Print :$key:ApplicationBundleIdentifier" "$component_template")
        licenseid=$($PLISTBUDDY -c "Print :$key:licenseid" "$component_template")
        CorelSuiteIdentifier=$($PLISTBUDDY -c "Print :$key:CorelSuiteIdentifier" "$component_template")

        # find source id
        application_plist="/Library/Preferences/$ApplicationBundleIdentifier/com.Corel.Registry.plist"
        
        if  [ $CorelSuiteIdentifier ] 
        then
            
            application_plist="/Library/Preferences/$CorelSuiteIdentifier/com.Corel.Registry.plist"

        fi

        WriteLog $application_plist

        application_regkey=$(echo $Regkey | tr "/" ":")
        sourceid=""
        sourceid=$($PLISTBUDDY -c "Print '$application_regkey:SourceID:1'" "$application_plist")

        if [ 6 == ${#sourceid} ]
        then
            # delete section, and write or re-write section
            # this will help fix any incorrect sourceids that may be in the file
            $PLISTBUDDY -c "Delete SOFTWARE:Corel:PCU:Licenses:$licenseid:$sourceid" "$commonplist"

            # write or re-write new section to match setup
            full_dict="SOFTWARE:Corel:PCU:Licenses:$licenseid:$sourceid"
            $PLISTBUDDY -c "Add $full_dict dict" "$commonplist"

            $PLISTBUDDY -c "Add $full_dict:DTAFilename array" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:DTAFilename:0 integer 1" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:DTAFilename:1 string '$DTAFilename'" "$commonplist"

            $PLISTBUDDY -c "Add $full_dict:RegKey array" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:RegKey:0 integer 1" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:RegKey:1 string '$Regkey'" "$commonplist"

            $PLISTBUDDY -c "Add $full_dict:Path array" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:Path:0 integer 1" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:Path:1 string '$Path'" "$commonplist"

            $PLISTBUDDY -c "Add $full_dict:NLRFilename array" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:NLRFilename:0 integer 1" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:NLRFilename:1 string '$NLRFilename'" "$commonplist"

            $PLISTBUDDY -c "Add $full_dict:ApplicationBundleIdentifier array" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:ApplicationBundleIdentifier:0 integer 1" "$commonplist"
            $PLISTBUDDY -c "Add $full_dict:ApplicationBundleIdentifier:1 string '$ApplicationBundleIdentifier'" "$commonplist"

            if  [ $CorelSuiteIdentifier ] 
            then
                $PLISTBUDDY -c "Add $full_dict:CorelSuiteIdentifier array" "$commonplist"
                $PLISTBUDDY -c "Add $full_dict:CorelSuiteIdentifier:0 integer 1" "$commonplist"
                $PLISTBUDDY -c "Add $full_dict:CorelSuiteIdentifier:1 string '$CorelSuiteIdentifier'" "$commonplist"
            fi
            
            WriteLog " ------------------------------------- "
            WriteLog $commonplist
            WriteLog $Regkey
            WriteLog $Path
            WriteLog $NLRFilename
            WriteLog $DTAFilename
            WriteLog $ApplicationBundleIdentifier
            WriteLog $licenseid
            WriteLog $sourceid
            WriteLog " ------------------------------------- "

        fi #sourcid found

    done #iterating product list

    #add the CUH build number to the com.corel.Registry.plist
    CUHVersion=$($PLISTBUDDY -c 'Print :version:1' "$component_template");

    $PLISTBUDDY -c "Add :SOFTWARE:Corel:PCU:Version array" "$commonplist"
    $PLISTBUDDY -c "Add :SOFTWARE:Corel:PCU:Version:0 integer 1" "$commonplist"
    $PLISTBUDDY -c "Add :SOFTWARE:Corel:PCU:Version:1 string '$CUHVersion'" "$commonplist"

    if [[ -e $commonplist_Installed ]]; then
        cp -Rf $commonplist $commonplist_Installed
    fi 
	WriteLog "PCU install end"
	WriteLog "$(date)"

} #function Main

Main



