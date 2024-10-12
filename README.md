Language: [Русский](README_RU.md) | English

## What kind of repository is this and for what

It's just preinstall and postinstall and slightly different scripts extracted from pkg files (installers for macOS).

I collected them for myself just to see examples of how other developers make the logic of installing their products on macOS. Perhaps these scripts will help someone else as examples for writing shell/bash/zsh code or their preinstall/postinstall scripts.

Moreover, at the moment there is no documentation on how to properly make pkg files on macOS. The manual pages for the `pkgbuild` and `productbuild` utilities do not say anything about environment variables `$0`, `$1`, `$2`, `$3`, `$4`, but in some preinstall/postinstall scripts, these variables are documented directly and clearly. 

In general, preinstall/postinstall scripts do not have to be written in shell/bash/zsh. Preinstall/postinstall files can be any executable file, including binary (this is done in the Clip Studio Paint installer), and can also be scripts in `perl` (this is done in the ON1 Photo RAW installer) and I have not seen any documentation in which this is written.

You can extract or explore the insides of pkg files, for example, using the [Pacifist](https://www.charlessoft.com) applications and [Suspicious Package](https://mothersruin.com/software/SuspiciousPackage/) or using `pkgutil` or `xar` or other smart archivers.

In general, the topic of researching and creating pkg files is a separate topic, which, alas, is not documented by Apple (I did not find any documentation about this from them).

[Here](./scripts/) are only examples of preinstall and postinstall and some other scripts from pkg files.