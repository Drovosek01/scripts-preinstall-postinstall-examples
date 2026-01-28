#!/bin/bash

# _Uninstall_AfterCodecs_Checkbox.sh

function deleteFileOrFolder()
{
    echo "deleteFileOrFolder $1"
    rm  -f -dR "$1"
    rmdir "$1"
}

function deleteFileOrFolderBothLocalAndGlobal()
{
    echo "deleteFileOrFolderBothLocalAndGlobal $1"
    deleteFileOrFolder "$1"
    # ~/ doesn't work because it is not expanded https://stackoverflow.com/questions/14561475/use-bash-home-in-shell-script
    # Note that it is OK to have multiple / with no folder name (empty) in between
    deleteFileOrFolder "${HOME}/$1"
}

deleteFileOrFolderBothLocalAndGlobal "/Library/Application Support/Adobe/CEP/extensions/Install.command"
deleteFileOrFolderBothLocalAndGlobal "/Library/Application Support/Adobe/CEP/extensions/Uninstall.command"
deleteFileOrFolderBothLocalAndGlobal "/Library/Application Support/Adobe/CEP/extensions/com.autokroma.afcpanel.zxp"
deleteFileOrFolderBothLocalAndGlobal "/Library/Application Support/Adobe/CEP/extensions/com.autokroma.afcpanel/"

function deleteAllAfterCodecsFromFolder()
{
    echo "deleteAllAfterCodecsFromFolder $1"

    deleteFileOrFolderBothLocalAndGlobal "$1/AfterCodecsAE_OSX.plugin"
    deleteFileOrFolderBothLocalAndGlobal "$1/AfterCodecsAE.plugin"
    
    deleteFileOrFolderBothLocalAndGlobal "$1/AfterCodecsLayer.plugin"
    
    deleteFileOrFolderBothLocalAndGlobal "$1/AfterCodecsPPME_OSX.bundle"
    deleteFileOrFolderBothLocalAndGlobal "$1/AfterCodecsPPME.bundle"

    deleteFileOrFolderBothLocalAndGlobal "$1/AfterCodecs.app"
    deleteFileOrFolderBothLocalAndGlobal "$1/ffkroma"
}

function deleteAllAfterCodecsFromAllFolders()
{
    echo "deleteAllAfterCodecsFromAllFolders $1"

    deleteAllAfterCodecsFromFolder "$1"
    deleteAllAfterCodecsFromFolder "$1/Autokroma AfterCodecs/"
    deleteAllAfterCodecsFromFolder "$1/Manual Installation AfterCodecs/"

    deleteFileOrFolder "$1/Autokroma AfterCodecs/"
    deleteFileOrFolder "$1/Manual Installation AfterCodecs/"
}


deleteAllAfterCodecsFromAllFolders "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects CC 2017/Plug-ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects CC 2017/Plug-ins/Effects/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects CC 2018/Plug-ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects CC 2018/Plug-ins/Effects/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects CC 2019/Plug-ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects CC 2019/Plug-ins/Effects/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects 2020/Plug-ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects 2020/Plug-ins/Effects/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects 2021/Plug-ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects 2021/Plug-ins/Effects/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects 2022/Plug-ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects 2022/Plug-ins/Effects/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects 2023/Plug-ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe After Effects 2023/Plug-ins/Effects/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Premiere Pro CC 2017/Adobe Premiere Pro CC 2017.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Premiere Pro CC 2018/Adobe Premiere Pro CC 2018.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Premiere Pro CC 2019/Adobe Premiere Pro CC 2019.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Premiere Pro 2020/Adobe Premiere Pro 2020.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Premiere Pro 2021/Adobe Premiere Pro 2021.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Premiere Pro 2022/Adobe Premiere Pro 2022.app/Contents/PlugIns/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Premiere Pro 2023/Adobe Premiere Pro 2023.app/Contents/PlugIns/"

deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Media Encoder CC 2017/Adobe Media Encoder CC 2017.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Media Encoder CC 2018/Adobe Media Encoder CC 2018.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Media Encoder CC 2019/Adobe Media Encoder CC 2019.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Media Encoder 2020/Adobe Media Encoder 2020.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Media Encoder 2021/Adobe Media Encoder 2021.app/Contents/Plug-Ins/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Media Encoder 2022/Adobe Media Encoder 2022.app/Contents/PlugIns/"
deleteAllAfterCodecsFromAllFolders "/Applications/Adobe Media Encoder 2023/Adobe Media Encoder 2023.app/Contents/PlugIns/"

deleteFileOrFolderBothLocalAndGlobal "/Applications/AfterCodecs"

# _Uninstall_AfterCodecs_Checkbox.sh



if [ ! -d "/Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/" ];
then

    # https://stackoverflow.com/questions/30452699/make-bash-script-display-system-event-dialog-then-take-its-result-and-use-it-in/30464956
    USELESSVALUE="$(osascript -e 'display dialog "We did not detect Adobe Common MediaCore folder, please double check you installed Adobe apps correctly through Creative Cloud ! We will create this folder for you : /Library/Application Support/Adobe/Common/Plug-ins/7.0/MediaCore/" buttons {"Ok"} default button "Ok" with icon stop with title "Autokroma Installer"')"

    # If we only peform the MediaCore folder it will create the folders recursively but if the previous
    # folders didn't exist there is an issue where the MediaCore folder cannot be written to (permission issue ?)
    # Workaround : first mkdir each previous folder
    # We stop at the Common folder, if it doesn't exist then there's really an issue about the current Install !
    if [ ! -d "/Library/Application Support/Adobe/" ];
    then
        mkdir /Library/Application\ Support/Adobe/
    fi
    
    if [ ! -d "/Library/Application Support/Adobe/Common/" ];
    then
        mkdir /Library/Application\ Support/Adobe/Common/
    fi

    if [ ! -d "/Library/Application Support/Adobe/Common/Plug-ins/" ];
    then
        mkdir /Library/Application\ Support/Adobe/Common/Plug-ins/
    fi

    if [ ! -d "/Library/Application Support/Adobe/Common/Plug-ins/7.0/" ];
    then
        mkdir /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/
    fi

    mkdir /Library/Application\ Support/Adobe/Common/Plug-ins/7.0/MediaCore/
fi



exit 0
