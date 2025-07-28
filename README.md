Language: [Русский](README_RU.md) | English

## What kind of repository is this and for what

It's just preinstall and postinstall and slightly different scripts extracted from pkg files (installers for macOS).

I collected them for myself just to see examples of how other developers make the logic of installing their products on macOS. Perhaps these scripts will help someone else as examples for writing shell/bash/zsh code or their preinstall/postinstall scripts.

Moreover, at the moment there is no documentation on how to properly make pkg files on macOS. The manual pages for the `pkgbuild` and `productbuild` utilities do not say anything about environment variables `$0`, `$1`, `$2`, `$3`, `$4`, but in some preinstall/postinstall scripts, these variables are documented directly and clearly. 

In general, preinstall/postinstall scripts do not have to be written in shell/bash/zsh. Preinstall/postinstall files can be any executable file, including binary (this is done in the Clip Studio Paint installer), and can also be scripts in `perl` (this is done in the ON1 Photo RAW installer) and I have not seen any documentation in which this is written.

You can extract or explore the insides of pkg files, for example, using the [Pacifist](https://www.charlessoft.com) applications and [Suspicious Package](https://mothersruin.com/software/SuspiciousPackage/) or using `pkgutil` or `xar` or other smart archivers.

In general, the topic of researching and creating pkg files is a separate topic, which, alas, is not documented by Apple (I did not find any documentation about this from them).

[Here](./scripts/) are only examples of preinstall and postinstall and some other scripts from pkg files.

## Information about pkg

### Standard arguments in preinstall/postinstall

When running preinstall/postinstall scripts, some data is passed to them in the form of arguments, and there are also some standard named variables:

| Argument | Description |
|-|-|
|`$0`| Full path to the current script |
|`$1`| The full path to the installation package that the Installer application processes. For example: /Volumes/Users/Vikrams/Desktop/TestPkg.pkg |
|`$2`| Full path to the installation location. For example: /Applications |
|`$3`| The full path to the root of the disk selected for installation. For example: /Volumes/Macintosh HD |
|`$4`| Root directory of the running system: / |
|`$SCRIPT_NAME`| The file name of the executable file of the operation. For example: preinstall |
|`$PACKAGE_PATH`| The same as `$1' |
|`$INSTALLER_TEMP`| the working directory used by the installer to host temporary work files. For example: /private/tmp/.vikrams.pkg.234.install |
| `$COMMAND_LINE_INSTALL` | The variable is set if the installation is performed via `/usr/sbin/installer` |


Information sources:
- https://macinstallers.blogspot.com/2012/07/scripting-in-installer-packages.html
- http://s.sudre.free.fr/Stuff/PackageMaker_Howto.html
- https://cpb-us-e1.wpmucdn.com/sites.psu.edu/dist/4/24696/files/2019/07/psumac2019-345-Installer-Package-Scripting-Making-your-deployments-easier-one-at-a-time.pdf
- https://bpb-us-e1.wpmucdn.com/sites.psu.edu/dist/4/24696/files/2016/07/psumac2016-58-PSUMacAdmins2016-Intro-to-Packaging.pdf?bid=24696
- https://forum.qt.io/topic/60991/understanding-qt-and-mac-pkg-setups/3
- GUI in "Suspicious package" app
