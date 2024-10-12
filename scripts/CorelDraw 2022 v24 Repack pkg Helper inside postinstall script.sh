#!/bin/bash
#$1: Full Path to Package
#$2: Full Path to target installation directory: /Applications
#$3: Mountpoint of installation disk: / or /Volumes/External_Drive
#$4: Root directory of currently booted system
PLISTBUDDY=/usr/libexec/PlistBuddy 
debug="y"

#Get the path script is running from
wkd="$( cd "$( dirname "${BASH_SOURCE0}" )" && pwd )"
plist="$wkd/stubconfig"
pluginsdir="$wkd/Plugins"


pref_dir="/Library/Preferences"
appid=$(defaults read "$plist" ApplicationID)
payload_Draw=$(defaults read "$plist" Payload_Draw)
payload_PP=$(defaults read "$plist" Payload_PP)
payload_FM=$(defaults read "$plist" Payload_FM)
suitedir=$(defaults read "$plist" SuiteDir)
logdir=$(defaults read $plist LogFilePath)
logfile=$(defaults read $plist LogFileName)
dta=$(defaults read $plist DTA)
dta_s=$(defaults read $plist DTA_S)
dta_pf=$(defaults read $plist DTA_PF)
dta_corp=$(defaults read $plist DTA_CORP)
dta_sub=$(defaults read $plist DTA_SUB)
dta_retail=$(defaults read $plist DTA_RETAIL)
nlr=$(defaults read $plist NLR)
nlr_s=$(defaults read $plist NLR_S)
licenseid=$(defaults read $plist PCU_LICID)
licenseid_s=$(defaults read $plist PREMIUMFEATURES_PCU_LICID)
SID_trial=$(defaults read "$plist" SID_trial)
SID_retail=$(defaults read "$plist" SID_retail)
SID_corp=$(defaults read "$plist" SID_corp)
SID_sub=$(defaults read "$plist" SID_sub)
SID=$(defaults read "$plist" PCUSOURCEID)
SID_s=$(defaults read "$plist" PREMIUMFEATURES_PCUSOURCEID)
sourceid=$(defaults read "$plist" SourceID)
channelid=$(defaults read "$plist" CHANNELID)
xat_param=$(defaults read "$plist" XAT_PARAM)
x_channel=$(defaults read "$plist" XCHANNEL)
version=$(defaults read "$plist" PRODUCTDISPLAYVERSION)

reg_plist=$(defaults read "$plist" Reg_PList)
ProductNameKey=$(defaults read "$plist" ProductNameKey)
ProductVersionKey=$(defaults read "$plist" ProductVersionKey)
IPMRegKey=$(defaults read "$plist" IPMRegKey)
Eula=$(defaults read "$plist" Eula)
ShowEula=$(defaults read "$plist" ShowEula)
Reg_DTAFilename="$dtadir/$dta"
Reg_DtaFilename_PF="$dtadir/$dta_s"
App_Pref_Path="$pref_dir/$appid"
CommonDataDir="/Library/Corel/$suitedir/CommonData"
installdir="/Applications/$suitedir"
dtadir="/Library/Application Support/Corel/$suitedir"
ippcfgdir="/Library/Application Support/Corel/$suitedir"
contentdir=$(defaults read "$plist" ContentDir)
defaul_contentdir="$contentdir/$licenseid""_000000"
defaul_contentdir_s="$contentdir/$licenseid_s""_000000"

PCUAppID=$(defaults read "$plist" PCUAppID)
PCU_Plist_path="$pref_dir/$PCUAppID/$reg_plist"
stub_plist="$HOME/Library/Preferences/com.stub.Result.plist"

#applicationconfigdir="/Library/Preferences/$applicationid"

#app_plist=$(defaults read "$plist" ApplicationPlist)
thankyou_url=$(defaults read "$plist" thankyou_url)
#appprefdir=$(defaults read "$plist" AppPrefDir)
buildnumber=$(defaults read "$plist" BuildNumber)
#registry=$(defaults read "$plist" Registry)
skutype="tbyb" #default to trial


# below used only for hard coded
ishardcoded=$(defaults read "$plist" isHardCodedSerial)
dtatype=$(defaults read "$plist" dtatype)
sn=$(defaults read "$plist" serialnumber)
function debugit
{
    echo "wkd=$wkd"
    echo "appid=$appid"
    echo "installdir=$installdir"
    echo "dtadir=$dtadir"
    echo "dta=$dta"
    echo "dta_s=$dta_s"
    echo "licenseid=$licenseid"
    echo "licenseid_s=$licenseid_s"
    echo "SID=$SID"
    echo "SID_s=$SID_s"
    echo "sourceid=$sourceid"
    echo "channelid=$channelid"
    echo "contentdir=$contentdir"
    echo "App_Pref_Path=$App_Pref_Path"
    echo "version=$version"
    echo "appid=$appid"
    echo "skutype=$skutype"
    echo "defaul_contentdir=$defaul_contentdir"
    echo "defaul_contentdir_s=$defaul_contentdir_s"
    echo "sn=$sn"
    echo "stub_plist=$stub_plist"
    echo "thankyou_url=$thankyou_url"
    echo "ShowEula=$ShowEula"

} 
function check_stubplist
{
    if [ "$debug" ]
    then
        echo "********** Start - check_stubplist **********"
    fi
    if [ -f "$stub_plist" ] 
    then

        echo " $stub_plist exists"
        x_channel_override=$(PLISTBUDDY -c "Print :Overrides:X-CHANNEL" $stub_plist)
        echo  "X-CHANNEL override - $x_channel_override"
        x_channel=$x_channel_override

        xat_param_override=$(PLISTBUDDY -c "Print :Overrides:XATParam" $stub_plist)
        echo  "X-AT Param override - $xat_param_override"
        xat_param=$xat_param_override

        sid_override=$(PLISTBUDDY -c "Print :Overrides:SourceID" $stub_plist)
        echo  "sourceid override - $sid_override"
        sourceid=$sid_override

        channelid_override=$(PLISTBUDDY -c "Print :Overrides:CHANNELID" $stub_plist)
        echo  "CHANNELID override - $channelid_override"
        channelid=$channelid_override
        echo "channelid is now $channelid"
           
    fi    

}
function update_stubplist
{
    if [ "$debug" ]
    then
        echo "********** Start - update_stubplist **********"
    fi
    if [ -f "$stub_plist" ] 
    then
        echo " $stub_plist exists"
        $PLISTBUDDY -c "Set InstallResult:errorCode 0" "$stub_plist"
        $PLISTBUDDY -c "Set InstallResult:errorMessage NoError" "$stub_plist"

    fi


}
function set_skutype
{
    if [ "$debug" ]
    then
        echo "********** Start - set_skutype **********"
        echo "check if sourceid is set - $sourceid"
    fi

    if [ -f "/tmp/$dta.dta" ] 
    then
        #is deafult Trial build
        skutype="tbyb"
        tempdta="$dta.dta"
        if [ ! "$sourceid" ]
        then
            sourceid="$SID_trial"
        fi    
    elif [ -f "/tmp/$dta$dta_pf.dta" ] 
    then
        #is pf build
        skutype="pf"
        tempdta="$dta$dta_pf.dta"
        if [ ! "$sourceid" ]
        then
            sourceid="$SID_retail" 
        fi 
    elif [ -f "/tmp/$dta$dta_corp.dta" ] 
    then
        #is corp build
        skutype="corp"
        tempdta="$dta$dta_corp.dta"
        if [ ! "$sourceid" ]
        then
            sourceid="$SID_corp" 
        fi
    elif [ -f "/tmp/$dta$dta_retail.dta" ] 
    then
        #is retail build
        skutype="retail"
        tempdta="$dta$dta_retail.dta"
        if [ ! "$sourceid" ]
        then
            sourceid="$SID_retail" 
        fi
    elif [ -f "/tmp/$dta$dta_sub.dta" ] 
    then
        #is subscription build
        skutype="sub"
        tempdta="$dta$dta_sub.dta"
        if [ ! "$sourceid" ]
        then
            sourceid="$SID_sub" 
        fi

    else
        echo "DTA not found!!!"
        exit 99
    fi
    echo "skutype=$skutype, tempdta=$tempdta"
    $PLISTBUDDY -c "Add :SourceID string '$sourceid'" "$plist.plist"
}
function copy_nlrs
{

    if [ "$debug" ]
    then
        echo "********** Start - copy_nlrs **********"
    fi
    
    nlr_dr="DRPCUNLR.DLL"
    nlr_rm="RMPCUNLR.DLL"
    nlr_ph="PHPCUNLR.DLL"
    nlr_hm="HMPCUNLR.DLL"
    nlr_dc="DCPCUNLR.DLL"

    
    if [ $skutype = "tbyb" ]; then 
        nlrdir="TRIAL"
    elif [ $skutype = "retail" ]; then
        nlrdir="RETAIL_Mandatory"
        #nlrdir="RETAIL"
    elif [ $skutype = "corp" ]; then
        nlrdir="CORPORATE"
    elif [ $skutype = "sub" ]; then
        #we do not require subscription NLRs, just use Trial
        nlrdir="TRIAL"
    fi
    echo "skutype=$skutype, nlrdir=$nlrdir"
    cp "$pluginsdir/_nlrs/$nlrdir/Draw/$nlr_dr" "$CommonDataDir/Draw/$nlr_dr"
    cp "$pluginsdir/_nlrs/$nlrdir/Draw/$nlr_rm" "$CommonDataDir/Draw/$nlr_rm"
    cp "$pluginsdir/_nlrs/$nlrdir/PHOTO-PAINT/$nlr_ph" "$CommonDataDir/PHOTO-PAINT/$nlr_ph"
    cp "$pluginsdir/_nlrs/$nlrdir/PHOTO-PAINT/$nlr_hm" "$CommonDataDir/PHOTO-PAINT/$nlr_hm"
    cp "$pluginsdir/_nlrs/$nlrdir/FontManager/$nlr_dr" "$CommonDataDir/FontManager/$nlr_dr"
    cp "$pluginsdir/_nlrs/$nlrdir/FontManager/$nlr_rm" "$CommonDataDir/FontManager/$nlr_rm"
    cp "$pluginsdir/_nlrs/$nlrdir/CdrConv/$nlr_dc" "$CommonDataDir/CdrConv/$nlr_dc"

}
function copy_config
{
    if [ "$debug" ]
    then
        echo "********** Start - copy_config **********"
    fi
    if [ ! -z $skutype ] 
    then
        if [ ! -d "$dtadir" ] 
        then
            mkdir -p "$dtadir"
        fi
		if [ ! -d "$App_Pref_Path" ]
        then
            mkdir -p "$App_Pref_Path"
        fi
        if [ ! -d "$ippcfgdir" ] 
        then
            mkdir -p "$ippcfgdir"
        fi        
        cp "/tmp/$tempdta" "$dtadir/$dta.dta"
        cp "$pluginsdir/IPP.cfg" "$ippcfgdir/IPP.cfg"
        cp "$pluginsdir/${dta_s}.dta" "$dtadir/${dta_s}.dta"
        cp "$pluginsdir/$reg_plist" "$App_Pref_Path/$reg_plist"
		cp "$pluginsdir/Message.policy" "$App_Pref_Path/Message.policy"

        
        prodcutdict="SOFTWARE:Corel:$ProductNameKey:$ProductVersionKey:$IPMRegKey"
        $PLISTBUDDY -c "Set $prodcutdict:SourceID:1 $sourceid" "$App_Pref_Path/$reg_plist"

        #copy in the NLRs
        copy_nlrs
        
        #if [ $skutype = "corp" ]
        #then 
        #    $PLISTBUDDY -c "Delete $prodcutdict:CCC:ContextMenu" "$applicationconfigdir/$registryfile"
        #fi
        chmod -R 777 "$App_Pref_Path"
        
    fi

}

function copy_content
{
    if [ "$debug" ]
    then
        echo "********** Start - copy_content **********"
    fi
    
    if [ ! -d "$defaul_contentdir" ] 
    then
        mkdir -p "$defaul_contentdir"
    fi
    if [ ! -d "$defaul_contentdir_s" ] 
    then
        mkdir -p "$defaul_contentdir_s"
    fi

    if [ -d "$pluginsdir/$licenseid""_000000" ] 
    then
        cp -R "$pluginsdir/$licenseid""_000000/" "$defaul_contentdir/"
    fi
    if [ ! -z $sourceid ] 
    then
        mkdir -p "$defaul_contentdir/$licenseid"_"$sourceid";
        cp -R "$defaul_contentdir/" "$contentdir/$licenseid"_"$sourceid/"
    fi

    if [ -d "$pluginsdir/$licenseid_s""_000000" ] 
    then
        cp -R "$pluginsdir/$licenseid_s""_000000/" "$defaul_contentdir_s/"
    fi
    if [ ! -z $SID_s ] 
    then
        mkdir -p "$defaul_contentdir/$licenseid_s"_"$SID_s";
        cp -R "$defaul_contentdir_s/" "$contentdir/$licenseid_s"_"$SID_s/" 
    fi 
	chmod -R 777 "$pref_dir/Corel"
    chmod -R 777 "$contentdir"
}

function change_channelID
{
    if [ "$debug" ]
    then
        echo "********** Start - change_channelID **********"
    fi
    
    if test -f "$ippcfgdir/IPP.cfg"
    then
        echo "Found IPP.cfg - $ippcfgdir/IPP.cfg"
        if [[ ! -z "$channelid" ]]; then
            echo "channelid is defined - $channelid"
            export channel=$channelid
            perl -pi -e 's/CHANNEL=(.*)/CHANNEL=$ENV{'channel'}/i' "$ippcfgdir/IPP.cfg"
        fi
    fi
}

function add_xat_param
{
    if [ "$debug" ]
    then
        echo "********** Start - add_xat_param **********"
    fi
    if [ ! -z $xat_param ];then
        echo "xat_param is define - update $reg_plist"
        productdict="SOFTWARE:Corel:$ProductNameKey:$ProductVersionKey:$IPMRegKey"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData dict ''" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-at array ''" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-at: integer '1'" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-at: string '$xat_param'" "$App_Pref_Path/$reg_plist"

        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-channel array ''" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-channel: integer '1'" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-channel: string '$x_channel'" "$App_Pref_Path/$reg_plist"
    fi
    if [ ! -z $x_channel ];then
        echo "x_channel is define - update $reg_plist"
        productdict="SOFTWARE:Corel:$ProductNameKey:$ProductVersionKey:$IPMRegKey:PremiumFeatures"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData dict ''" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-at array ''" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-at: integer '1'" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-at: string '$xat_param'" "$App_Pref_Path/$reg_plist"

        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-channel array ''" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-channel: integer '1'" "$App_Pref_Path/$reg_plist"
        $PLISTBUDDY -c "Add $productdict:CCC:ServerData:x-channel: string '$x_channel'" "$App_Pref_Path/$reg_plist"
    fi
}

function hide_EULA
{
    if [ "$debug" ]
    then
        echo "********** Start - hide_EULA **********"
    fi

    if [ $ShowEula = "0" ];
    then
        echo "set EULA to not show on application launch"
        productdict="SOFTWARE:Corel:$ProductNameKey:$ProductVersionKey:$IPMRegKey"
        $PLISTBUDDY -c "Set $productdict:ShowEULA:1 $ShowEula" "$App_Pref_Path/$reg_plist"
    fi

}


function run_stubhelper
{
    #run the helper
    if [ "$debug" ]
    then
        echo "$wkd/StubHelper/StubHelper"
    fi
    "$wkd/StubHelper/StubHelper"
}

function update_AppRegPlist
{
    
    if [ "$debug" ]
    then
        echo "********** Start - update_AppRegPlist **********"
        productdict="SOFTWARE:Corel:$ProductNameKey:$ProductVersionKey:$IPMRegKey"
        $PLISTBUDDY -c "Set $productdict:version:1 $buildnumber" "$App_Pref_Path/$reg_plist"
    fi


}
function create_dta
{
    if [ "$debug" ]
    then
        echo "********** Start - create_dta **********"
    fi
    "$pluginsdir/Registration.bundle/Contents/MacOS/create_dta" $sn "/tmp/$dta$dtatype.dta"
}

function generate_logs
{
    if [ "$debug" ]
    then
        echo "********** Start - generate_logs **********"
    fi
    #get installer process ID to parse out of system install.log
    Installer_PID="$(ps -A | grep -m1 System/Library/CoreServices/Installer.app/Contents/MacOS/Installer | awk '{print $1}')"

    mkdir -p "$logdir"
    if test -f "$logdir/$logfile"
        then
                rm -f "$logdir/$logfile"
        fi
    
    if test -f "$logdir/tmpsn.plist"
        then
            rm -f "$logdir/tmpsn.plist"
        fi
    
    if test -f "/tmp/tmpsn"
        then
            cp "/tmp/tmpsn" "$logdir/tmpsn.plist"
            rm -f "/tmp/tmpsn"
        fi
    
    #scrap current log input from install.log
    d=$(date "+%b %d")
    logit=false
    while read p; do
        if [[ $p == *"$d"*"Installer[$Installer_PID]"* ]]; then
            logit=true
        fi
        
        if [ $logit = true ]; then 
                echo "$p" >> "$logdir/$logfile"
        fi
    done </var/log/install.log     
}


function cleanup
{
    if [ "$debug" ]
    then
        echo "********** Start - cleanup **********"
    fi
    file2delete="/tmp/$dta$dta_pf.dta"
    if test -f "$file2delete"
    then
        rm -f "$file2delete"
    fi

    file2delete1="/tmp/$dta$dta_corp.dta"
    if test -f "$file2delete1"
    then
        rm -f "$file2delete1"
    fi

    file2delete1="/tmp/$dta$dta_retail.dta"
    if test -f "$file2delete1"
    then
        rm -f "$file2delete1"
    fi

    file2delete1="/tmp/$dta$dta_sub.dta"
    if test -f "$file2delete1"
    then
        rm -f "$file2delete1"
    fi

    file2delete2="/tmp/$dta.dta"
    if test -f "$file2delete2"
    then
        rm -f "$file2delete2"
    fi
}

function updatedpermissions
{
    if [ "$debug" ]
    then
        echo "********** Start - updatepermissions **********"
    fi
    
    chmod -R 777 "$installdir"
    chmod -R 777 "/Library/Corel/$suitedir"
   
}

function createWritableFolders
{
    if [ "$debug" ]
    then
        echo "********** Start - createWritableFolders **********"
    fi
    
    if [ ! -d "$pref_dir/Corel/Downloads" ] 
    then
        mkdir -p "$pref_dir/Corel/Downloads"
    fi

	chmod -R 777 "$pref_dir/Corel/Downloads"

    if [ ! -d "$pref_dir/Corel/Bin" ] 
    then
        mkdir -p "$pref_dir/Corel/Bin"
    fi

	chmod -R 777 "$pref_dir/Corel/Bin"    

    #DTADir
    if [ ! -d "$dtadir" ] 
    then
        mkdir -p "$dtadir"
    fi

	chmod -R 777 "$dtadir"    
}
function thankyou
{

    if [ "$debug" ]
    then
        echo "********** Start - thankyou **********"
    fi
    if [[ $COMMAND_LINE_INSTALL == 1 ]]; then
        echo "This is a silent install - do not launch Thank you page"
        return
    fi    
    tmpsn="/tmp/tmpsn"
    if test -f $tmpsn
    then
        echo "found $tmpsn"
        hfpid=$(PLISTBUDDY -c "Print :hfpid" $tmpsn)
        serialnumber=$(PLISTBUDDY -c "Print :serialnumber" $tmpsn)
        serialtype=$(PLISTBUDDY -c "Print :serialtype" $tmpsn)
        os_language=$(PLISTBUDDY -c "Print :os_language" $tmpsn)
		lang=${os_language:0:2} # get the first 2 letters for the lang code
        echo "lang is $lang"
    fi
    if [ "$lang" = "zh" ];then
        echo "lang is zh, get whole lang code"
        lang=${os_language:0:7}

    fi
#distinguish CT and CS

    shopt -s nocasematch
#cs= zh-Hans-CA
#cz=cs-CA
#ct=zh-Hant-CA

    case "$lang" in
        "zh-Hant" ) lang="CT";;
        "zh-Hans" ) lang="CS";;
        "zh" ) lang="CT";;
        "ct" ) lang="CT";;
        "de" ) lang="DE";;
        "fr" ) lang="FR";;
        "ja" ) lang="JP";;
        "jp" ) lang="JP";;
        "br" ) lang="BR";;
        "pt" ) lang="BR";;
        "cs" ) lang="CZ";;
        "cz" ) lang="CZ";;
        "es" ) lang="ES";;
        "it" ) lang="IT";;
        "nl" ) lang="NL";;
        "pl" ) lang="PL";;
        "ru" ) lang="RU";;
        "tr" ) lang="TR";;
        "sv" ) lang="SV";;
        * ) lang="EN";;
    esac
        echo $lang

#http://apps.corel.com/redirect?_redirect=command&amp;function=track&amp;app=coreldraw_mac&amp;version=22&amp;passprms=1&amp;lang=XX&amp;serialtype=YY&amp;os_language=ZZ&amp;buildnumber=AA&amp;licenseId=BB&amp;sourceId=CC

   lang=$(echo $lang | tr '[:upper:]' '[:lower:]') 
   thankyou_url=$(echo "${thankyou_url/XX/$lang}")
   thankyou_url=$(echo "${thankyou_url/AA/$buildnumber}")
   thankyou_url=$(echo "${thankyou_url/BB/$licenseid}")
   thankyou_url=$(echo "${thankyou_url/CC/$sourceid}")
   thankyou_url=$(echo "${thankyou_url/YY/$serialtype}")
   thankyou_url=$(echo "${thankyou_url/ZZ/$os_language}")

   echo "********$thankyou_url "
   #open -g "$thankyou_url&hfpid=$hfpid&serialnumber=$serialnumber&serialtype=$serialtype&os_language=$lang&lang=$lang&buildnumber=$buildnumber"
   open -g "$thankyou_url"
}
######################################################
#is Debug mode
if  [ $debug ] 
then
    debugit
fi

check_stubplist

if  [ $ishardcoded ] 
then
    create_dta
fi

if [ -f "$dtadir/$dta.dta" ] 
then
    echo "$dtadir/$dta.dta exists"
    update_AppRegPlist
else
    echo "$dta.dta does not exists"
    # determin sku type
    set_skutype

    # copy config files
    copy_config

    # copy messages
    copy_content

    # copy change channel ID
    change_channelID

    add_xat_param

fi

#create downloads folder and make writable
createWritableFolders

hide_EULA
# installportal logging
#not required for Beta
#run_stubhelper

#launch thank you
thankyou

#get the log
generate_logs

#update permissions
updatedpermissions

update_stubplist


# clean it
cleanup

exit 0