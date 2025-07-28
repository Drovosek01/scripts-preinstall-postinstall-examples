Language: Русский | [English](./README.md)

## Что это за репозиторий и для чего

Это просто preinstall и postinstall и немного иные скрипты извлеченные из pkg-файлов (установщиков для macOS).

Я их собирал для себя просто, чтобы видеть примеры как другие разработчики делают логику установки своих продуктов на macOS. Возможно эти скрипты помогут кому-то еще как примеры для написания shell/bash/zsh-кода или своих preinstall/postinstall скриптов.

Тем более что на текущий момент нет документации как правильно делать pkg-файлы на macOS. В manual-страницах по утилитам `pkgbuild` и `productbuild` ничего не сказано про переменные окружения `$0`, `$1`, `$2`, `$3`, `$4`, но в некоторых preinstall/postinstall скриптах эти переменные документируются прямо и понятно. 

Вообще preinstall/postinstall скрипты не обязательно должны быть написаны на shell/bash/zsh. Файлы preinstall/postinstall могут быть любым исполняемым файлом, в том числе бинарным (так сделано в установщике Clip Studio Paint), а также могу быть скриптам на `perl` (так сделано в установщике ON1 Photo RAW) и я не видел какой-либо документации, в которой это написано.

Извлечь или исследовать внутренности pkg-файлов можно, например с помощью приложений [Pacifist](https://www.charlessoft.com/) и [Suspicious Package](https://mothersruin.com/software/SuspiciousPackage/) или с помощью `pkgutil` или `xar` или других умных архиваторов.

Вообще тема исследования и создания pkg-файлов это отдельная тема, которая, увы, не документирована Apple (я не нашел у них документации об этом).

[Здесь](./scripts/) только примеры preinstall и postinstall и некоторых других скриптов из pkg-файлов.

## Информация о pkg

### Стандартные аргументы в preinstall/postinstall

При запуске preinstall/postinstall скриптов в них передаются некоторые данные в виде аргументов, а также есть некоторые стандартные именованные переменные:

| Argument | Description |
|-|-|
|`$0`| Полный путь к текущему скрипту |
|`$1`| Полный путь к установочному пакету, который обрабатывает приложение «Установщик». Например: /Volumes/Users/Vikrams/Desktop/TestPkg.pkg |
|`$2`| Полный путь к месту установки. Например: /Applications |
|`$3`| Полный путь к корню диска, выбранного для установки. Например: /Volumes/Macintosh HD |
|`$4`| Корневой каталог запущенной системы: / |
|`$SCRIPT_NAME`| Имя файла исполняемого файла операции. Например: preinstall |
|`$PACKAGE_PATH`| Тоже самое что и `$1` |
|`$INSTALLER_TEMP`| рабочий каталог, используемый установщиком для размещения временных рабочих файлов. Например: /private/tmp/.vikrams.pkg.234.install |
| `$COMMAND_LINE_INSTALL` | Переменная установлена, если установка выполняется через `/usr/sbin/installer` |


Источники информации:
- https://macinstallers.blogspot.com/2012/07/scripting-in-installer-packages.html
- http://s.sudre.free.fr/Stuff/PackageMaker_Howto.html
- https://cpb-us-e1.wpmucdn.com/sites.psu.edu/dist/4/24696/files/2019/07/psumac2019-345-Installer-Package-Scripting-Making-your-deployments-easier-one-at-a-time.pdf
- https://bpb-us-e1.wpmucdn.com/sites.psu.edu/dist/4/24696/files/2016/07/psumac2016-58-PSUMacAdmins2016-Intro-to-Packaging.pdf?bid=24696
- https://forum.qt.io/topic/60991/understanding-qt-and-mac-pkg-setups/3
- GUI в приложении "Suspicious package"

