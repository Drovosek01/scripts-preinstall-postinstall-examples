#!/bin/bash

# Variables: CI will update these variables value according the packaget type
oldProcess=0
continueVersion=0
ApplicationName="Foxit PDF Editor"
ApplicationDataType="Continuous"
newVersion=13.1.4.62748
#preinstall will set oldversionvalue
oldversionvalue=""
TrialDayValue=""
bNoTrialsValue="0"

updater=0
bPatch=false
setkeyfile=0
setdefaultpdf=0
serial=""
activeName=""
setfpcsdk=1
plistValue=""
editorXmlFileCopy=1
phantompreplistfile="com.foxit-software.Foxit.PDF.Editor.plist"
NewKeyfilePath="/usr/local/share/foxit/Foxit PDF Editor/Licenses/"
ACUpdateDataPath="/usr/local/share/foxit/Foxit PDF Editor/ACUpdate/"
DeactivationPath="/usr/local/share/foxit/Foxit PDF Editor/Deactivation"
ActivationPath="/Applications/Foxit PDF Editor.app/Contents/MacOS/Activation.app"
EditorPath="/Applications/Foxit PDF Editor.app"
keyFileName="fpmmkey.txt"
foxitagentid=""
foxitagentname=""

#set Application vertion type
if [ $continueVersion -eq 0 ]; then
    ApplicationDataType="Classic"
fi

appdatePath="$HOME/Library/Application Support/Foxit Software/${ApplicationDataType}/${ApplicationName}"
destKeyfilepath="${appdatePath}/Licenses/"

echo "home: ${HOME}"

#将目录"/usr/local/share/foxit"权限设置为系统用户可读写,其他用户只读
if [ -d "/usr/local/share/foxit" ]; then
    chmod 755 /usr/local/share/foxit
fi

if [ -d "/usr/local/share/foxit/Foxit PDF Editor" ]; then
    chmod 755 /usr/local/share/foxit/Foxit\ PDF\ Editor
fi

# Obtain the current logged-in user's username through the HOME environment variable
user_from_home=$(basename "${HOME}")

# Check if the user exists
if id -u "${user_from_home}" >/dev/null 2>&1; then
  currentuser="${user_from_home}"
else
  # If the user does not exist, try using other methods to obtain the current logged-in user's username
  # Use the stat command to get the owner of /dev/console as the current logged-in user
  currentuser=$(stat -f "%Su" /dev/console)
fi

#get current path
mydir=$(pwd)

#Compatible with old app data(Foxit PhantomPDF)
Compatible_old_appData() {
    echo "Compatible_old_appData begin"
    local dataPath="$HOME/Library/Application Support/Foxit Software/${ApplicationDataType}"
    local phantomName="Foxit PhantomPDF"
    local editorName=${ApplicationName}

    if [ -d "$dataPath/$editorName" ];then
        /usr/sbin/chown -R "$currentuser" "$dataPath/$editorName"
    fi

    if [ -d "$dataPath/$phantomName" ] && [ ! -d "$dataPath/$editorName" ]; then
        ls "$dataPath/$phantomName"
        su - "${currentuser}" -c "mkdir \"$dataPath/$editorName\""
        declare -a folders=("CertFile"
                            "ConnectedPDF"
                            "FormFiller"
                            "InstaSign"
                            "Licenses"
                            "PredefinedText"
                            "Redaction"
                            "Scans"
                            "Signature"
                            "SpellCheck"
                            "Stamps")

        for folder in "${folders[@]}"
        do
            if [ -d "$dataPath/$phantomName/$folder" ]; then
                su - "${currentuser}" -c "mv -v \"$dataPath/$phantomName/$folder\" \"$dataPath/$editorName/$folder\""
            fi
        done

        #move old keyfile
        if [ -f "$dataPath/$phantomName/fpmmkey.txt" ]; then
            su - "${currentuser}" -c "mv -v \"$dataPath/$phantomName/fpmmkey.txt\" \"$dataPath/$editorName/\""
        fi
    fi
    rm -rf "${dataPath:?}"/"$phantomName"

    su - "${currentuser}" -c "mkdir -p \"$dataPath/$editorName/\""
    echo "Compatible_old_appData end"
}

#Compatible with old preferences(Foxit PhantomPDF.plist/Foxit PDF Editor.plist)
Compatible_old_preferences() {
echo "Compatible_old_preferences begin"
    local preferencePath="$HOME/Library/Preferences/com.foxit-software.Foxit PhantomPDF.plist"
    local oldEditorPreferencePath="$HOME/Library/Preferences/com.foxit-software.Foxit PDF Editor.plist"
    local editorPreferencePath="$HOME/Library/Preferences/$phantompreplistfile"
    local oldUpdaterpreplistfile="$HOME/Library/Preferences/com.foxit-software.Foxit PDF Editor Updater.plist"
    local updaterpreplistfile="$HOME/Library/Preferences/com.foxit-software.Foxit.PDF.Editor.Updater.plist"
    local oldActivationpreplistfile="$HOME/Library/Preferences/com.foxit-software.Foxit PDF Editor Activation.plist"
    local activationpreplistfile="$HOME/Library/Preferences/com.foxit-software.Foxit.PDF.Editor.Activation.plist"

    if [ ! -f "$editorPreferencePath" ]; then
        if [ -f "$oldEditorPreferencePath" ]; then
            mv "$oldEditorPreferencePath" "$editorPreferencePath"
        else
            if [ -f "${preferencePath}" ]; then
                plutil -p "${preferencePath}" |grep PhantomPDF|awk 'BEGIN{FS=" => "} {print $1}' |while read line
                do
                   echo "delete :$line" "${preferencePath}"
                   /usr/libexec/PlistBuddy -c  "Delete :$line" "${preferencePath}"
                done

                su - "${currentuser}" -c "mv \"$preferencePath\" \"$newEditorPreferencePath\""
            fi
       fi
    fi

    if [[ -f "$oldUpdaterpreplistfile" &&  ! -f "$updaterpreplistfile" ]]; then
        mv "$oldUpdaterpreplistfile" "$updaterpreplistfile"
    fi

    if [[ -f "$oldActivationpreplistfile" && ! -f  "$activationpreplistfile" ]]; then
        mv "$oldActivationpreplistfile" "$activationpreplistfile"
    fi

echo "Compatible_old_preferences end"

}

#apply patch
apply_patch() {
    if [ ${bPatch} = true ]; then
        echo "ApplyPatch begin"
        "${mydir}/AllPatch/ApplyPatch"
        if [ $? != 0 ]; then
            echo "ApplyPatch fail!!!!!!!!!!"c
            exit -1
        else
            echo "ApplyPatch success"
        fi
    fi
}

delete_keyfile_and_plist() {
    if [[ $setkeyfile == 1 || -n "$serial" ]]; then
        echo "delete_keyfile_and_plist begin"
        cd ~/Library/Preferences/

        subKeyfile="~/Library/Application Support/Foxit Software/${ApplicationDataType}/${ApplicationName}/fpmmkey.txt"

        if [ -e "${subKeyfile}" ]; then
            rm -rf "${subKeyfile}"
        fi

        echo "delete EnterpriseTenantDomain begin"
        EnterpriseTenantDomain=$(plutil -p "${phantompreplistfile}" | grep EnterpriseTenantDomain | awk 'BEGIN{FS=" => "} {print $1}')
        EnterpriseTenantDomain=${EnterpriseTenantDomain#*\"}
        EnterpriseTenantDomain=${EnterpriseTenantDomain%\"*}
        echo "EnterpriseTenantDomain:${EnterpriseTenantDomain}"
        su - "${currentuser}" -c "defaults delete '${phantompreplistfile}' '${EnterpriseTenantDomain}'"
        echo "delete EnterpriseTenantDomain end"

        echo "delete LoginedService begin"
        LoginedService=$(plutil -p "${phantompreplistfile}" | grep LoginedService | awk 'BEGIN{FS=" => "} {print $1}')
        LoginedService=${LoginedService#*\"}
        LoginedService=${LoginedService%\"*}
        echo "LoginedService:${LoginedService}"
        su - "${currentuser}" -c "defaults delete '${phantompreplistfile}' '${LoginedService}'"
        echo "delete LoginedService end"
        cd -

echo "delete_keyfile_and_plist end"

    fi
}

create_directories() {
echo "create_directories begin"
    if [ -d "${ACUpdateDataPath}" ]; then
        rm -rf "${ACUpdateDataPath}"
    fi
    mkdir -p "${ACUpdateDataPath}"
    chmod 777 "${ACUpdateDataPath}"

    if [ ! -d "${NewKeyfilePath}" ]; then
        mkdir -p "${NewKeyfilePath}"
        chmod 777 "${NewKeyfilePath}"
    fi
echo "create_directories end"
}

copy_DeactivationPath() {
echo "copy_DeactivationPath begin"

    if [ -d "${DeactivationPath}" ]; then
        rm -rf "${DeactivationPath}"
    fi
    mkdir -p "${DeactivationPath}"

    cp -Rf "${ActivationPath}" "${DeactivationPath}"
    mkdir -p "${DeactivationPath}/../Frameworks"
    cp -Rf "${EditorPath}/Contents/Frameworks/QtCore.framework" "${DeactivationPath}/../Frameworks"
    cp -Rf "${EditorPath}/Contents/Frameworks/QtWidgets.framework" "${DeactivationPath}/../Frameworks"
    cp -Rf "${EditorPath}/Contents/Frameworks/QtGui.framework" "${DeactivationPath}/../Frameworks"
    cp -Rf "${EditorPath}/Contents/Frameworks/QtNetwork.framework" "${DeactivationPath}/../Frameworks"
    cp -Rf "${EditorPath}/Contents/Frameworks/QtXml.framework" "${DeactivationPath}/../Frameworks"
    cp -Rf "${EditorPath}/Contents/Frameworks/QtDBus.framework" "${DeactivationPath}/../Frameworks"
    cp -Rf "${EditorPath}/Contents/Frameworks/QtPrintSupport.framework" "${DeactivationPath}/../Frameworks"
    cp -Rf "${EditorPath}/Contents/PlugIns" "${DeactivationPath}/../"
    cp -Rf "${EditorPath}/Contents/fxplugins/libfpcsdk.dylib" "${DeactivationPath}"
    cp -Rf "${EditorPath}/Contents/fxplugins/librpc.dylib" "${DeactivationPath}"
    cp -Rf "${EditorPath}/Contents/fxplugins/libSensor.dylib" "${DeactivationPath}"
    if [ -f "${EditorPath}/Contents/Resources/packagetype.xml" ]; then
        cp -Rf "${EditorPath}/Contents/Resources/packagetype.xml" "${DeactivationPath}"
    fi

    sed -i "" "s/currentUserValue/$currentuser/g" "$mydir/Foxit_deactivate.sh"
    cp -rf "$mydir/Foxit_deactivate.sh" "${DeactivationPath}"

echo "copy_DeactivationPath end"
}

copy_RemoveData(){
echo "copy_RemoveData begin"

    sed -i "" "s/currentUserValue/$currentuser/g" "$mydir/Foxit_removeData.sh"
    if [ -f "/usr/local/share/foxit/Foxit PDF Editor/Foxit_removeData.sh" ]; then
        rm -rf "/usr/local/share/foxit/Foxit PDF Editor/Foxit_removeData.sh"
    fi
    cp -rf "$mydir/Foxit_removeData.sh" "/usr/local/share/foxit/Foxit PDF Editor"

echo "copy_RemoveData end"
}

copy_keyfile() {
echo "copy_keyfile begin"

    if [ $setkeyfile == 1 ]; then
        echo "set keyfile"
        keyfilepath="$mydir/$keyFileName"
        echo "keyfilepath: ${keyfilepath}"
        su - $currentuser -c "cp -f '$keyfilepath' '${NewKeyfilePath}'"
    else
        oldKeyPath="${destKeyfilepath}${keyFileName}"
        if [ -e "${oldKeyPath}" ]; then
            su - $currentuser -c "mv -v '$oldKeyPath' '${NewKeyfilePath}'"
        fi
    fi
    if [ -d "${destKeyfilepath}" ]; then
        rm -rf "${destKeyfilepath}"
    fi

echo "copy_keyfile end"

}

set_default_pdf() {
    if [ $setdefaultpdf == 1 ]; then
        echo "set_default_pdf begin"
        dutipath="$mydir/duti"
        su - "${currentuser}" -c "'$dutipath' -s com.foxit-software.Foxit.PDF.Editor .pdf all"
        su - "${currentuser}" -c "'$dutipath' -s com.foxit-software.Foxit.PDF.Editor .ppdf all"
        echo "set_default_pdf end"
    fi
}

move_sharereview() {
echo "move_sharereview begin"
    cd
    if [ ! -d "Library/Application Support/Foxit Software/${ApplicationDataType}/${ApplicationName}/ShareReview" ] && [ -d "Library/Application Support/Foxit Software/${ApplicationDataType}/${ApplicationName}/Roaming/Foxit Software/Foxit Reader/ShareReview" ]; then
        mv -f "Library/Application Support/Foxit Software/${ApplicationDataType}/${ApplicationName}/Roaming/Foxit Software/Foxit Reader/ShareReview" "Library/Application Support/Foxit Software/${ApplicationDataType}/${ApplicationName}/ShareReview"
        rm -rf "Library/Application Support/Foxit Software/${ApplicationDataType}/${ApplicationName}/Roaming"
    fi
    cd -
echo "move_sharereview end"
}

copy_or_remove_ProfStore() {
    echo "copy_or_remove_ProfStore begin"

    if [ $editorXmlFileCopy == 1 ]; then
        echo "copy editor xml file"
        editorXmlpath="$mydir/ProfStore.xml"
        if [ -e "${editorXmlpath}" ]; then
            echo "editorXmlpath: ${editorXmlpath}"
            NewEditorXmlpath="/Applications/Foxit PDF Editor.app/Contents/Resources/ProfStore"
            mkdir "$NewEditorXmlpath"
            cp -f "$editorXmlpath" "${NewEditorXmlpath}"
        fi
    else
        DeleteEditorXmlpath="/Applications/Foxit PDF Editor.app/Contents/Resources/ProfStore"
        if [ -e "${DeleteEditorXmlpath}" ]; then
            rm -rf "${DeleteEditorXmlpath}"
        fi
    fi

    echo "copy_or_remove_ProfStore end"
}

execute_foxit_copy_other_to_dest() {
echo "execute_foxit_copy_other_to_dest begin"

    if [ -e "${mydir}/FoxitCopyOtherToDest.sh" ]; then
        sh "${mydir}/FoxitCopyOtherToDest.sh"
    else
        echo "file not exit: ${mydir}/FoxitCopyOtherToDest.sh"
    fi

echo "execute_foxit_copy_other_to_dest end"

}

update_classic_version() {

echo "update_classic_version begin"

    if [ $continueVersion -eq 0 ]; then
        #delete update lastupdatedate
        su - "${currentuser}" -c "defaults write '$HOME/Library/Preferences/${phantompreplistfile}' 'Classic' -dict-add 'ReaderLite_LastUpdateDate' '-1'"

        #for MACRD-5410
        bInitDefPlugins="Installed/InitDefPlugins"
        su - "${currentuser}" -c "defaults write '$HOME/Library/Preferences/${phantompreplistfile}' 'Classic' -dict-add '${bInitDefPlugins}' 0"

        #set app version
        su - "${currentuser}" -c "defaults write '$HOME/Library/Preferences/${phantompreplistfile}' 'Classic' -dict-add 'AppVersion' '${newVersion}'"
    else
        #delete update lastupdatedate
        su - "${currentuser}" -c "defaults delete '$HOME/Library/Preferences/${phantompreplistfile}' ReaderLite_LastUpdateDate"

        #for MACRD-5410
        bInitDefPlugins="Installed.InitDefPlugins"
        su - "${currentuser}" -c "defaults write '$HOME/Library/Preferences/${phantompreplistfile}' '${bInitDefPlugins}' 0"

        #set app version
        su - "${currentuser}" -c "defaults write '$HOME/Library/Preferences/${phantompreplistfile}' 'AppVersion' '${newVersion}'"
    fi

echo "update_classic_version end"

}

activate_serial() {
    echo "activate_serial begin"
    if [ -n "$serial" ]; then
        su - "${currentuser}" -c "nohup '${ActivationPath}/Contents/MacOS/Activation' -activateserial -regserial $serial -regactivename "${activeName}" >> /tmp/outputcount.log 2>&1 &"
    fi
    echo "activate_serial end"
}

load_update_service() {

echo "load_update_service begin"

    if [ -e "/Library/LaunchDaemons/com.foxit.PDFEditorUpdateService.plist" ]; then
        launchctl load /Library/LaunchDaemons/com.foxit.PDFEditorUpdateService.plist
    fi

echo "load_update_service end"

}

copy_fpcsdk_config() {
    if [ $setfpcsdk == 1 ]; then
    echo "copy_fpcsdk_config begin"

        fpcsdkfilepath="$mydir/fpcsdk.config"
        if [ -e "${fpcsdkfilepath}" ]; then
            su - "${currentuser}" -c "cp -rf \"${fpcsdkfilepath}\" \"${appdatePath}\""
        fi

    echo "copy_fpcsdk_config end"

    fi
}

count_install() {
    echo "count_install begin"
    rm -f /tmp/outputcount.log
    pkgname=$1

    readsysuuid=$(ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { print $3; }')

    count_install_cmd="/Applications/Foxit PDF Editor.app/Contents/MacOS/countinstalltion.app/Contents/MacOS/countinstalltion"
    count_install_params="/updater ${updater} /version ${newVersion} /uid \"${pkgname:0-25:21}\""


    if [ ${updater} == 0 ]; then
        syslang=$(su - "${currentuser}" -c "osascript -e 'user locale of (get system info)'")
        count_install_params+=" /syslang \"$syslang\""
    fi

    count_install_params+=" /is_old_subscribe $oldProcess"
    count_install_params+=" /is_continue $continueVersion"

    [ -n "$oldversionvalue" ] && count_install_params+=" /oldversion \"${oldversionvalue}\""
    [ -n "$foxitagentid" ] && count_install_params+=" /foxitid \"${foxitagentid}\""
    [ -n "$foxitagentname" ] && count_install_params+=" /foxitname \"${foxitagentname}\""
    [ -n "$readsysuuid" ] && count_install_params+=" /sysuuid $readsysuuid"
    [ -n "$plistValue" ] && count_install_params+=" /SetPlistValue \"${plistValue}\""
    [ -n "$TrialDayValue" ] && count_install_params+=" /TrialDay $TrialDayValue"
    [ -n "$bNoTrialsValue" ] && count_install_params+=" /bNoTrials $bNoTrialsValue"

    echo "count_install_cmd: ${count_install_cmd}"
    echo "count_install_params: ${count_install_params}"

    if [ ! -d "/usr/local/share/foxit/${ApplicationName}/LocalMachine" ]; then
        mkdir -p "/usr/local/share/foxit/${ApplicationName}/LocalMachine"
        chmod 777 "/usr/local/share/foxit/${ApplicationName}/LocalMachine"
    fi

    if [ ! -f "/usr/local/share/foxit/${ApplicationName}/LocalMachine/LocalMachine.plist" ]; then
        if [ -f "/usr/local/share/foxit/${ApplicationName}/LocalMachine.plist" ]; then
            mv "/usr/local/share/foxit/${ApplicationName}/LocalMachine.plist" "/usr/local/share/foxit/${ApplicationName}/LocalMachine"
        else
            cp -f "$mydir/LocalMachine.plist" "/usr/local/share/foxit/${ApplicationName}/LocalMachine"
        fi
        chmod 666 "/usr/local/share/foxit/${ApplicationName}/LocalMachine/LocalMachine.plist"
    fi


    su - "${currentuser}" -c "nohup \"${count_install_cmd}\" ${count_install_params} >> /tmp/outputcount.log 2>&1 &"
echo "count_install end"
}

#兼容旧版本
Compatible_old_appData
Compatible_old_preferences
#如果是补丁包则应用补丁包
apply_patch
#如果安装包有做授权则删除本地旧的keyfile
delete_keyfile_and_plist
#创建目录，为后续拷贝做准备
create_directories
#拷贝激活程序到反激活目录
copy_DeactivationPath
#拷贝removedate脚本
copy_RemoveData
#拷贝安装包中带的keyfile到对应目录
copy_keyfile
#拷贝fpcsdk配置文件
copy_fpcsdk_config
#设置pdf默认阅读器
set_default_pdf
#兼容classic目录
update_classic_version
#将plist修改数据写入文件使其生效
sync
#执行统计小程序
count_install
#code激活
activate_serial
#加载后台更新服务
load_update_service
#sharereview移到新的目录
move_sharereview
#ProfStore文件处理
copy_or_remove_ProfStore
#执行FoxitCopyOtherToDest(自定义数据拷贝)
execute_foxit_copy_other_to_dest

#为了刷新程序图标
touch /Applications/Foxit\ PDF\ Editor.app

exit 0
