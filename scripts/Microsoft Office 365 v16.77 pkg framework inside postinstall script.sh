#!/bin/zsh
result=0

echo Initializing log. > /tmp/com.microsoft.package.DFonts.generic.postinstall.log
echo Beginning "/Applications/Microsoft Word.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

payload_version="16.77.23091003"

ditto_command=(/usr/bin/ditto)
autoload is-at-least
if is-at-least 14.0 $(/usr/bin/sw_vers -productVersion); then
	ditto_command=(/usr/bin/ditto --clone)
fi

INSTALL_FILES=0
install_path_bundle_info_plist_path="$3/Applications/Microsoft Word.app/Contents/Info.plist"
if ! /bin/test -e "$install_path_bundle_info_plist_path"
then
	echo Not installing files because bundle Info.plist $install_path_bundle_info_plist_path does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
else
	installed_version="`/usr/bin/defaults read "$install_path_bundle_info_plist_path" CFBundleVersion`"
	echo Comparing installed version "$installed_version" with payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
	versions_array=(`printf "$installed_version\n$payload_version\n" | sort -n -t .`)
	if [ "$payload_version" = "$installed_version" ]
	then
		INSTALL_FILES=1
	else
		if [ "$payload_version" = "${versions_array[1]}" ]
		then
			echo Not installing files because installed version "$installed_version" is greater than payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		else
			INSTALL_FILES=1
		fi
	fi
fi

if [ $INSTALL_FILES -eq 1 ]
then
	echo Installing files... >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

	if /bin/test -e "$2/DFonts/Rockwell Extra Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Extra Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Rockwell Extra Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Extra Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Extra Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Extra Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/webdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/webdings.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/webdings.ttf"
		then
			echo Error copying "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/webdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dengb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dengb.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Dengb.ttf"
		then
			echo Error copying "$2/DFonts/Dengb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dengb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dengb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candarai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candarai.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Candarai.ttf"
		then
			echo Error copying "$2/DFonts/Candarai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candarai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candarai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambria.ttc"
	then
		if ! $ditto_command "$2/DFonts/Cambria.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Cambria.ttc"
		then
			echo Error copying "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambria.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Verdana Bold.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GillSansUltraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/GillSansUltraBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/GillSansUltraBold.ttf"
		then
			echo Error copying "$2/DFonts/GillSansUltraBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GillSansUltraBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GillSansUltraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BernardMTCondensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/BernardMTCondensed.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/BernardMTCondensed.ttf"
		then
			echo Error copying "$2/DFonts/BernardMTCondensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BernardMTCondensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BernardMTCondensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constani.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constani.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Constani.ttf"
		then
			echo Error copying "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constani.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriab.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Cambriab.ttf"
		then
			echo Error copying "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palab.ttf"
	then
		if ! $ditto_command "$2/DFonts/palab.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/palab.ttf"
		then
			echo Error copying "$2/DFonts/palab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Medium.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Medium.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Dubai-Medium.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Medium.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BritannicBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/BritannicBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/BritannicBold.ttf"
		then
			echo Error copying "$2/DFonts/BritannicBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BritannicBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BritannicBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxRegular.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxRegular.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaFaxRegular.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxRegular.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxRegular.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxRegular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbd.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/arialbd.ttf"
		then
			echo Error copying "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/symbol.ttf"
	then
		if ! $ditto_command "$2/DFonts/symbol.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/symbol.ttf"
		then
			echo Error copying "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/symbol.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Verdana Italic.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Narrow.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguisym.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguisym.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/seguisym.ttf"
		then
			echo Error copying "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguisym.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Fangsong.ttf"
	then
		if ! $ditto_command "$2/DFonts/Fangsong.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Fangsong.ttf"
		then
			echo Error copying "$2/DFonts/Fangsong.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Fangsong.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Fangsong.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRGE.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRGE.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/HGRGE.ttc"
		then
			echo Error copying "$2/DFonts/HGRGE.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRGE.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRGE.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gabriola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gabriola.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gabriola.ttf"
		then
			echo Error copying "$2/DFonts/Gabriola.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gabriola.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gabriola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CalistoMTBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/CalistoMTBoldItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/CalistoMTBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/CalistoMTBoldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CalistoMTBoldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CalistoMTBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ComicSansMSBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/ComicSansMSBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ComicSansMSBold.ttf"
		then
			echo Error copying "$2/DFonts/ComicSansMSBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ComicSansMSBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ComicSansMSBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/News Gothic MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/Kaiti.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Kaiti.ttf"
		then
			echo Error copying "$2/DFonts/Kaiti.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kaiti.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Regular.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Regular.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Dubai-Regular.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Regular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yumin.ttf"
	then
		if ! $ditto_command "$2/DFonts/yumin.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/yumin.ttf"
		then
			echo Error copying "$2/DFonts/yumin.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yumin.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yumin.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Display-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Perpetua Italic.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightDemiboldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightDemiboldItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaBrightDemiboldItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightDemiboldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightDemiboldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightDemiboldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/simsunb.ttf"
	then
		if ! $ditto_command "$2/DFonts/simsunb.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/simsunb.ttf"
		then
			echo Error copying "$2/DFonts/simsunb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/simsunb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/simsunb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/AbadiMTCondensedLight.ttf"
	then
		if ! $ditto_command "$2/DFonts/AbadiMTCondensedLight.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/AbadiMTCondensedLight.ttf"
		then
			echo Error copying "$2/DFonts/AbadiMTCondensedLight.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/AbadiMTCondensedLight.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/AbadiMTCondensedLight.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/COOPBL.TTF"
	then
		if ! $ditto_command "$2/DFonts/COOPBL.TTF" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/COOPBL.TTF"
		then
			echo Error copying "$2/DFonts/COOPBL.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/COOPBL.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/COOPBL.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgunsl.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgunsl.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/malgunsl.ttf"
		then
			echo Error copying "$2/DFonts/malgunsl.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgunsl.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgunsl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanz.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Constanz.ttf"
		then
			echo Error copying "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBlackletter.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBlackletter.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaBlackletter.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBlackletter.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBlackletter.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBlackletter.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Light-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tw Cen MT.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Medium Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbel.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbel.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Corbel.ttf"
		then
			echo Error copying "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbel.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mmrtext.ttf"
	then
		if ! $ditto_command "$2/DFonts/mmrtext.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/mmrtext.ttf"
		then
			echo Error copying "$2/DFonts/mmrtext.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mmrtext.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mmrtext.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MS Reference Specialty.ttf"
	then
		if ! $ditto_command "$2/DFonts/MS Reference Specialty.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MS Reference Specialty.ttf"
		then
			echo Error copying "$2/DFonts/MS Reference Specialty.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MS Reference Specialty.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MS Reference Specialty.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi Cond.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi Cond.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Demi Cond.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi Cond.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi Cond.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi Cond.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candaraz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candaraz.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Candaraz.ttf"
		then
			echo Error copying "$2/DFonts/Candaraz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candaraz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candaraz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Segoe Print Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Segoe Print Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Segoe Print Bold.ttf"
		then
			echo Error copying "$2/DFonts/Segoe Print Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Segoe Print Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Segoe Print Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Display-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolab.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Consolab.ttf"
		then
			echo Error copying "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century Schoolbook.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium Cond.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium Cond.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Medium Cond.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium Cond.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium Cond.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium Cond.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STLITI.ttf"
	then
		if ! $ditto_command "$2/DFonts/STLITI.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/STLITI.ttf"
		then
			echo Error copying "$2/DFonts/STLITI.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STLITI.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STLITI.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ntailub.ttf"
	then
		if ! $ditto_command "$2/DFonts/ntailub.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ntailub.ttf"
		then
			echo Error copying "$2/DFonts/ntailub.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ntailub.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ntailub.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyhl.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyhl.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/msyhl.ttc"
		then
			echo Error copying "$2/DFonts/msyhl.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyhl.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyhl.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/SimHei.ttf"
	then
		if ! $ditto_command "$2/DFonts/SimHei.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/SimHei.ttf"
		then
			echo Error copying "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/SimHei.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMTItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMTItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/BellMTItalic.ttf"
		then
			echo Error copying "$2/DFonts/BellMTItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMTItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMTItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Condensed.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gill Sans MT Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Condensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Condensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century Schoolbook Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautami.TTF"
	then
		if ! $ditto_command "$2/DFonts/Gautami.TTF" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gautami.TTF"
		then
			echo Error copying "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautami.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterOblique.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterOblique.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaSansTypewriterOblique.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterOblique.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterOblique.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterOblique.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrii.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrii.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Calibrii.ttf"
		then
			echo Error copying "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrii.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msgothic.ttc"
	then
		if ! $ditto_command "$2/DFonts/msgothic.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/msgothic.ttc"
		then
			echo Error copying "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msgothic.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothR.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothR.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/YuGothR.ttc"
		then
			echo Error copying "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothR.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Perpetua Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Bookman Old Style Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/pala.ttf"
	then
		if ! $ditto_command "$2/DFonts/pala.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/pala.ttf"
		then
			echo Error copying "$2/DFonts/pala.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/pala.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/pala.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahomabd.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahomabd.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/tahomabd.ttf"
		then
			echo Error copying "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahomabd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Lucida Sans Italic.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsai.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsai.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/angsai.ttf"
		then
			echo Error copying "$2/DFonts/angsai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Stencil.ttf"
	then
		if ! $ditto_command "$2/DFonts/Stencil.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Stencil.ttf"
		then
			echo Error copying "$2/DFonts/Stencil.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Stencil.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Stencil.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GloucesterMTExtraCondensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/GloucesterMTExtraCondensed.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/GloucesterMTExtraCondensed.ttf"
		then
			echo Error copying "$2/DFonts/GloucesterMTExtraCondensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GloucesterMTExtraCondensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GloucesterMTExtraCondensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/davidbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/davidbd.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/davidbd.ttf"
		then
			echo Error copying "$2/DFonts/davidbd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/davidbd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/davidbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/TrebuchetMSBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/TrebuchetMSBoldItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/TrebuchetMSBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/TrebuchetMSBoldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/TrebuchetMSBoldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/TrebuchetMSBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookshelf Symbol 7.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookshelf Symbol 7.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Bookshelf Symbol 7.ttf"
		then
			echo Error copying "$2/DFonts/Bookshelf Symbol 7.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookshelf Symbol 7.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookshelf Symbol 7.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gill Sans MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-SemiBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Condensed.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Rockwell Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Condensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Condensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ModernNo.20.ttf"
	then
		if ! $ditto_command "$2/DFonts/ModernNo.20.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ModernNo.20.ttf"
		then
			echo Error copying "$2/DFonts/ModernNo.20.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ModernNo.20.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ModernNo.20.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/times.ttf"
	then
		if ! $ditto_command "$2/DFonts/times.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/times.ttf"
		then
			echo Error copying "$2/DFonts/times.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/times.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/times.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaFaxItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelb.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Corbelb.ttf"
		then
			echo Error copying "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century Gothic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yuminl.ttf"
	then
		if ! $ditto_command "$2/DFonts/yuminl.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/yuminl.ttf"
		then
			echo Error copying "$2/DFonts/yuminl.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yuminl.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yuminl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Simsun.ttc"
	then
		if ! $ditto_command "$2/DFonts/Simsun.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Simsun.ttc"
		then
			echo Error copying "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Simsun.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Bookman Old Style.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Titling MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Titling MT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Perpetua Titling MT.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Titling MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Titling MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Titling MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Marlett.ttf"
	then
		if ! $ditto_command "$2/DFonts/Marlett.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Marlett.ttf"
		then
			echo Error copying "$2/DFonts/Marlett.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Marlett.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Marlett.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRME.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRME.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/HGRME.ttc"
		then
			echo Error copying "$2/DFonts/HGRME.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRME.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRME.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRSGU.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRSGU.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/HGRSGU.ttc"
		then
			echo Error copying "$2/DFonts/HGRSGU.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRSGU.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRSGU.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/cordia.ttc"
	then
		if ! $ditto_command "$2/DFonts/cordia.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/cordia.ttc"
		then
			echo Error copying "$2/DFonts/cordia.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/cordia.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/cordia.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BaskervilleOldFace.ttf"
	then
		if ! $ditto_command "$2/DFonts/BaskervilleOldFace.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/BaskervilleOldFace.ttf"
		then
			echo Error copying "$2/DFonts/BaskervilleOldFace.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BaskervilleOldFace.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BaskervilleOldFace.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothB.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothB.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/YuGothB.ttc"
		then
			echo Error copying "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothB.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tw Cen MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century Gothic Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialNarrowItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialNarrowItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ArialNarrowItalic.ttf"
		then
			echo Error copying "$2/DFonts/ArialNarrowItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialNarrowItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialNarrowItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/WideLatin.ttf"
	then
		if ! $ditto_command "$2/DFonts/WideLatin.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/WideLatin.ttf"
		then
			echo Error copying "$2/DFonts/WideLatin.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/WideLatin.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/WideLatin.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EngraversMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/EngraversMT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/EngraversMT.ttf"
		then
			echo Error copying "$2/DFonts/EngraversMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EngraversMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EngraversMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryob.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryob.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/meiryob.ttc"
		then
			echo Error copying "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryob.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Book Antiqua Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyh.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyh.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/msyh.ttc"
		then
			echo Error copying "$2/DFonts/msyh.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyh.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyh.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Rockwell Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tungab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tungab.TTF" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tungab.TTF"
		then
			echo Error copying "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tungab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbd.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/timesbd.ttf"
		then
			echo Error copying "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsaz.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/angsaz.ttf"
		then
			echo Error copying "$2/DFonts/angsaz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsaz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgunbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgunbd.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/malgunbd.ttf"
		then
			echo Error copying "$2/DFonts/malgunbd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgunbd.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgunbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century.ttf"
		then
			echo Error copying "$2/DFonts/Century.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Console.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Console.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Lucida Console.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Console.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Console.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Console.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EngraversMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/EngraversMTBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/EngraversMTBold.ttf"
		then
			echo Error copying "$2/DFonts/EngraversMTBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EngraversMTBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EngraversMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Haettenschweiler.ttf"
	then
		if ! $ditto_command "$2/DFonts/Haettenschweiler.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Haettenschweiler.ttf"
		then
			echo Error copying "$2/DFonts/Haettenschweiler.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Haettenschweiler.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Haettenschweiler.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibriz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibriz.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Calibriz.ttf"
		then
			echo Error copying "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibriz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century Gothic Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguihis.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguihis.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/seguihis.ttf"
		then
			echo Error copying "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguihis.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Goudy Old Style.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Narrow-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesi.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/timesi.ttf"
		then
			echo Error copying "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Bookman Old Style Bold.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 3.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 3.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Wingdings 3.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 3.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightDemibold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightDemibold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaBrightDemibold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightDemibold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightDemibold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightDemibold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 2.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 2.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Wingdings 2.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 2.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Goudy Old Style Bold.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibril.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibril.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/calibril.ttf"
		then
			echo Error copying "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibril.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STXINGKA.ttf"
	then
		if ! $ditto_command "$2/DFonts/STXINGKA.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/STXINGKA.ttf"
		then
			echo Error copying "$2/DFonts/STXINGKA.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STXINGKA.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STXINGKA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Narrow-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Black.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consola.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Consola.ttf"
		then
			echo Error copying "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gill Sans MT Ext Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century Schoolbook Bold.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialNarrowBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialNarrowBoldItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ArialNarrowBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/ArialNarrowBoldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialNarrowBoldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialNarrowBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Display-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/monbaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/monbaiti.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/monbaiti.ttf"
		then
			echo Error copying "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/monbaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothM.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothM.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/YuGothM.ttc"
		then
			echo Error copying "$2/DFonts/YuGothM.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothM.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothM.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Demibold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Demibold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Lucida Sans Demibold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Demibold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Demibold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Demibold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbeli.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbeli.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Corbeli.ttf"
		then
			echo Error copying "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbeli.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARA.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARA.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/GARA.ttf"
		then
			echo Error copying "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABD.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABD.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/GARABD.ttf"
		then
			echo Error copying "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CurlzMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/CurlzMT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/CurlzMT.ttf"
		then
			echo Error copying "$2/DFonts/CurlzMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CurlzMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CurlzMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msmincho.ttc"
	then
		if ! $ditto_command "$2/DFonts/msmincho.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/msmincho.ttc"
		then
			echo Error copying "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msmincho.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Goudy Old Style Italic.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsa.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsa.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/angsa.ttf"
		then
			echo Error copying "$2/DFonts/angsa.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsa.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsa.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/gulim.ttc"
	then
		if ! $ditto_command "$2/DFonts/gulim.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/gulim.ttc"
		then
			echo Error copying "$2/DFonts/gulim.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/gulim.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/gulim.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lathab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lathab.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Lathab.ttf"
		then
			echo Error copying "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lathab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothL.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothL.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/YuGothL.ttc"
		then
			echo Error copying "$2/DFonts/YuGothL.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothL.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothL.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candara.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candara.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Candara.ttf"
		then
			echo Error copying "$2/DFonts/Candara.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candara.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candara.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsab.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsab.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/angsab.ttf"
		then
			echo Error copying "$2/DFonts/angsab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MTEXTRA.ttf"
	then
		if ! $ditto_command "$2/DFonts/MTEXTRA.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MTEXTRA.ttf"
		then
			echo Error copying "$2/DFonts/MTEXTRA.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MTEXTRA.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MTEXTRA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tunga.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tunga.TTF" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tunga.TTF"
		then
			echo Error copying "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tunga.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Deng.ttf"
	then
		if ! $ditto_command "$2/DFonts/Deng.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Deng.ttf"
		then
			echo Error copying "$2/DFonts/Deng.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Deng.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Deng.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaBrightItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/thsarabun.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRSMP.ttf"
	then
		if ! $ditto_command "$2/DFonts/HGRSMP.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/HGRSMP.ttf"
		then
			echo Error copying "$2/DFonts/HGRSMP.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRSMP.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRSMP.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Titling MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Titling MT Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Perpetua Titling MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Titling MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Titling MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Titling MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/TaiLeb.ttf"
	then
		if ! $ditto_command "$2/DFonts/TaiLeb.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/TaiLeb.ttf"
		then
			echo Error copying "$2/DFonts/TaiLeb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/TaiLeb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/TaiLeb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Medium.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Rockwell Italic.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/batang.ttc"
	then
		if ! $ditto_command "$2/DFonts/batang.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/batang.ttc"
		then
			echo Error copying "$2/DFonts/batang.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/batang.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/batang.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Braggadocio.ttf"
	then
		if ! $ditto_command "$2/DFonts/Braggadocio.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Braggadocio.ttf"
		then
			echo Error copying "$2/DFonts/Braggadocio.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Braggadocio.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Braggadocio.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Unicode.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Unicode.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Lucida Sans Unicode.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Unicode.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Unicode.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Unicode.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaCalligraphyItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaCalligraphyItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaCalligraphyItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaCalligraphyItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaCalligraphyItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaCalligraphyItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbi.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/timesbi.ttf"
		then
			echo Error copying "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MSJHBD.ttf"
	then
		if ! $ditto_command "$2/DFonts/MSJHBD.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MSJHBD.ttf"
		then
			echo Error copying "$2/DFonts/MSJHBD.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MSJHBD.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MSJHBD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos.ttf"
		then
			echo Error copying "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrib.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Calibrib.ttf"
		then
			echo Error copying "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Light.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arial.ttf"
	then
		if ! $ditto_command "$2/DFonts/arial.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/arial.ttf"
		then
			echo Error copying "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arial.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariblk.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariblk.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ariblk.ttf"
		then
			echo Error copying "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariblk.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/KinoMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/KinoMT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/KinoMT.ttf"
		then
			echo Error copying "$2/DFonts/KinoMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/KinoMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/KinoMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Rockwell.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Condensed Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Rockwell Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Condensed Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Condensed Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-ExtraBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Heavy.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Heavy.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Heavy.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Heavy.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Heavy.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Heavy.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STHUPO.ttf"
	then
		if ! $ditto_command "$2/DFonts/STHUPO.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/STHUPO.ttf"
		then
			echo Error copying "$2/DFonts/STHUPO.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STHUPO.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STHUPO.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Book Antiqua.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MangalB.ttf"
	then
		if ! $ditto_command "$2/DFonts/MangalB.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MangalB.ttf"
		then
			echo Error copying "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MangalB.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yumindb.ttf"
	then
		if ! $ditto_command "$2/DFonts/yumindb.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/yumindb.ttf"
		then
			echo Error copying "$2/DFonts/yumindb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yumindb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yumindb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMTBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/BellMTBold.ttf"
		then
			echo Error copying "$2/DFonts/BellMTBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMTBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaSansTypewriterBold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Book.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Book.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Book.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Book.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Book.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Book.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century Schoolbook Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Black-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Narrow-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MSJH.ttf"
	then
		if ! $ditto_command "$2/DFonts/MSJH.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MSJH.ttf"
		then
			echo Error copying "$2/DFonts/MSJH.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MSJH.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MSJH.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/BellMT.ttf"
		then
			echo Error copying "$2/DFonts/BellMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryo.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryo.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/meiryo.ttc"
		then
			echo Error copying "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryo.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliu.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliu.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/mingliu.ttc"
		then
			echo Error copying "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliu.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palabi.ttf"
	then
		if ! $ditto_command "$2/DFonts/palabi.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/palabi.ttf"
		then
			echo Error copying "$2/DFonts/palabi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palabi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palabi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constan.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constan.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Constan.ttf"
		then
			echo Error copying "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constan.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tw Cen MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaHandwritingItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaHandwritingItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaHandwritingItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaHandwritingItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaHandwritingItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaHandwritingItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tw Cen MT Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliub.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliub.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/mingliub.ttc"
		then
			echo Error copying "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliub.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold-italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/thsarabun-bold-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/thsarabun-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Perpetua.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Bookman Old Style Italic.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/taile.ttf"
	then
		if ! $ditto_command "$2/DFonts/taile.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/taile.ttf"
		then
			echo Error copying "$2/DFonts/taile.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/taile.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/taile.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialRoundedMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialRoundedMTBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ArialRoundedMTBold.ttf"
		then
			echo Error copying "$2/DFonts/ArialRoundedMTBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialRoundedMTBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialRoundedMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mmrtextb.ttf"
	then
		if ! $ditto_command "$2/DFonts/mmrtextb.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/mmrtextb.ttf"
		then
			echo Error copying "$2/DFonts/mmrtextb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mmrtextb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mmrtextb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-Display.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelz.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Corbelz.ttf"
		then
			echo Error copying "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-ExtraBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABDIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABDIT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/GARABDIT.ttf"
		then
			echo Error copying "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABDIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Wingdings.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyhbd.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyhbd.ttc" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/msyhbd.ttc"
		then
			echo Error copying "$2/DFonts/msyhbd.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyhbd.ttc" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyhbd.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gill Sans MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahoma.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahoma.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/tahoma.ttf"
		then
			echo Error copying "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahoma.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/himalaya.ttf"
	then
		if ! $ditto_command "$2/DFonts/himalaya.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/himalaya.ttf"
		then
			echo Error copying "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/himalaya.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/FootlightMTLight.ttf"
	then
		if ! $ditto_command "$2/DFonts/FootlightMTLight.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/FootlightMTLight.ttf"
		then
			echo Error copying "$2/DFonts/FootlightMTLight.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/FootlightMTLight.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/FootlightMTLight.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MS Reference Sans Serif.ttf"
	then
		if ! $ditto_command "$2/DFonts/MS Reference Sans Serif.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MS Reference Sans Serif.ttf"
		then
			echo Error copying "$2/DFonts/MS Reference Sans Serif.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MS Reference Sans Serif.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MS Reference Sans Serif.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tw Cen MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Verdana Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Heavy Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Heavy Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Heavy Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Heavy Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Heavy Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Heavy Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Onyx.ttf"
	then
		if ! $ditto_command "$2/DFonts/Onyx.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Onyx.ttf"
		then
			echo Error copying "$2/DFonts/Onyx.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Onyx.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Onyx.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Segoe Script Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Segoe Script Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Segoe Script Bold.ttf"
		then
			echo Error copying "$2/DFonts/Segoe Script Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Segoe Script Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Segoe Script Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxDemibold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxDemibold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaFaxDemibold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxDemibold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxDemibold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxDemibold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MaturaMTScriptCapitals.ttf"
	then
		if ! $ditto_command "$2/DFonts/MaturaMTScriptCapitals.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MaturaMTScriptCapitals.ttf"
		then
			echo Error copying "$2/DFonts/MaturaMTScriptCapitals.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MaturaMTScriptCapitals.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MaturaMTScriptCapitals.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariali.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariali.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ariali.ttf"
		then
			echo Error copying "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariali.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ColonnaMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/ColonnaMT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ColonnaMT.ttf"
		then
			echo Error copying "$2/DFonts/ColonnaMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ColonnaMT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ColonnaMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/News Gothic MT.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palai.ttf"
	then
		if ! $ditto_command "$2/DFonts/palai.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/palai.ttf"
		then
			echo Error copying "$2/DFonts/palai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriai.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Cambriai.ttf"
		then
			echo Error copying "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterRegular.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterRegular.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaSansTypewriterRegular.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterRegular.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterRegular.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterRegular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanb.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Constanb.ttf"
		then
			echo Error copying "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Harrington.ttf"
	then
		if ! $ditto_command "$2/DFonts/Harrington.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Harrington.ttf"
		then
			echo Error copying "$2/DFonts/Harrington.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Harrington.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Harrington.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gill Sans MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Book Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Book Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Book Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Book Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Book Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Book Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STZHONGS.ttf"
	then
		if ! $ditto_command "$2/DFonts/STZHONGS.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/STZHONGS.ttf"
		then
			echo Error copying "$2/DFonts/STZHONGS.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STZHONGS.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STZHONGS.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Mistral.ttf"
	then
		if ! $ditto_command "$2/DFonts/Mistral.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Mistral.ttf"
		then
			echo Error copying "$2/DFonts/Mistral.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Mistral.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Mistral.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tw Cen MT Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARAIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARAIT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/GARAIT.ttf"
		then
			echo Error copying "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARAIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartika.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartika.TTF" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Kartika.TTF"
		then
			echo Error copying "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartika.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ntailu.ttf"
	then
		if ! $ditto_command "$2/DFonts/ntailu.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ntailu.ttf"
		then
			echo Error copying "$2/DFonts/ntailu.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ntailu.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ntailu.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/News Gothic MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candarab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candarab.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Candarab.ttf"
		then
			echo Error copying "$2/DFonts/Candarab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candarab.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candarab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ImprintMTShadow.ttf"
	then
		if ! $ditto_command "$2/DFonts/ImprintMTShadow.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/ImprintMTShadow.ttf"
		then
			echo Error copying "$2/DFonts/ImprintMTShadow.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ImprintMTShadow.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ImprintMTShadow.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Calisto MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolaz.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Consolaz.ttf"
		then
			echo Error copying "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/thsarabun-bold.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaSansTypewriterBoldOblique.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/david.ttf"
	then
		if ! $ditto_command "$2/DFonts/david.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/david.ttf"
		then
			echo Error copying "$2/DFonts/david.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/david.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/david.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBright.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBright.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaBright.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBright.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBright.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBright.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Calisto MT.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Eurostile Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Eurostile Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Eurostile Bold.ttf"
		then
			echo Error copying "$2/DFonts/Eurostile Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Eurostile Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Eurostile Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STXINWEI.ttf"
	then
		if ! $ditto_command "$2/DFonts/STXINWEI.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/STXINWEI.ttf"
		then
			echo Error copying "$2/DFonts/STXINWEI.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STXINWEI.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STXINWEI.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MonotypeSorts.ttf"
	then
		if ! $ditto_command "$2/DFonts/MonotypeSorts.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MonotypeSorts.ttf"
		then
			echo Error copying "$2/DFonts/MonotypeSorts.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MonotypeSorts.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MonotypeSorts.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Desdemona.ttf"
	then
		if ! $ditto_command "$2/DFonts/Desdemona.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Desdemona.ttf"
		then
			echo Error copying "$2/DFonts/Desdemona.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Desdemona.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Desdemona.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolai.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Consolai.ttf"
		then
			echo Error copying "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxDemiboldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxDemiboldItalic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/LucidaFaxDemiboldItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxDemiboldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxDemiboldItalic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxDemiboldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Lucida Sans.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Aptos-SemiBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Light.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Dubai-Light.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Bold Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Rockwell Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Bold Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mangal.ttf"
	then
		if ! $ditto_command "$2/DFonts/mangal.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/mangal.ttf"
		then
			echo Error copying "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mangal.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Eurostile.ttf"
	then
		if ! $ditto_command "$2/DFonts/Eurostile.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Eurostile.ttf"
		then
			echo Error copying "$2/DFonts/Eurostile.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Eurostile.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Eurostile.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/latha.ttf"
	then
		if ! $ditto_command "$2/DFonts/latha.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/latha.ttf"
		then
			echo Error copying "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/latha.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dengl.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dengl.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Dengl.ttf"
		then
			echo Error copying "$2/DFonts/Dengl.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dengl.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dengl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautamib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gautamib.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gautamib.ttf"
		then
			echo Error copying "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautamib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EdwardianScriptITC.ttf"
	then
		if ! $ditto_command "$2/DFonts/EdwardianScriptITC.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/EdwardianScriptITC.ttf"
		then
			echo Error copying "$2/DFonts/EdwardianScriptITC.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EdwardianScriptITC.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EdwardianScriptITC.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbi.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/arialbi.ttf"
		then
			echo Error copying "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Book Antiqua Bold.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Century Gothic Bold.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/News Gothic MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriaz.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Cambriaz.ttf"
		then
			echo Error copying "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Gill Sans MT.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibri.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibri.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Calibri.ttf"
		then
			echo Error copying "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibri.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Demibold Roman.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Demibold Roman.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Lucida Sans Demibold Roman.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Demibold Roman.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Demibold Roman.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Demibold Roman.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Demi Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Tw Cen MT Condensed Extra Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MonotypeCorsiva.ttf"
	then
		if ! $ditto_command "$2/DFonts/MonotypeCorsiva.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/MonotypeCorsiva.ttf"
		then
			echo Error copying "$2/DFonts/MonotypeCorsiva.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MonotypeCorsiva.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MonotypeCorsiva.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgun.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgun.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/malgun.ttf"
		then
			echo Error copying "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibrili.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibrili.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/calibrili.ttf"
		then
			echo Error copying "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibrili.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/AbadiMTCondensedExtraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/AbadiMTCondensedExtraBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/AbadiMTCondensedExtraBold.ttf"
		then
			echo Error copying "$2/DFonts/AbadiMTCondensedExtraBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/AbadiMTCondensedExtraBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/AbadiMTCondensedExtraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Franklin Gothic Demi.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Italic.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Book Antiqua Italic.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Italic.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CopperplateGothicBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/CopperplateGothicBold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/CopperplateGothicBold.ttf"
		then
			echo Error copying "$2/DFonts/CopperplateGothicBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CopperplateGothicBold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CopperplateGothicBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyi.ttf"
	then
		if ! $ditto_command "$2/DFonts/msyi.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/msyi.ttf"
		then
			echo Error copying "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Verdana.ttf"
		then
			echo Error copying "$2/DFonts/Verdana.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Dubai-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bauhaus93.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bauhaus93.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Bauhaus93.ttf"
		then
			echo Error copying "$2/DFonts/Bauhaus93.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bauhaus93.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bauhaus93.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Calisto MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartikab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartikab.TTF" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Kartikab.TTF"
		then
			echo Error copying "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartikab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Bold.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/Perpetua Bold.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Bold.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/nyala.ttf"
	then
		if ! $ditto_command "$2/DFonts/nyala.ttf" "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts/nyala.ttf"
		then
			echo Error copying "$2/DFonts/nyala.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/nyala.ttf" to "$3/Applications/Microsoft Word.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/nyala.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	echo Finished installing files. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
fi

echo Ending "/Applications/Microsoft Word.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

echo Beginning "/Applications/Microsoft Excel.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

payload_version="16.77.23091003"

ditto_command=(/usr/bin/ditto)
autoload is-at-least
if is-at-least 14.0 $(/usr/bin/sw_vers -productVersion); then
	ditto_command=(/usr/bin/ditto --clone)
fi

INSTALL_FILES=0
install_path_bundle_info_plist_path="$3/Applications/Microsoft Excel.app/Contents/Info.plist"
if ! /bin/test -e "$install_path_bundle_info_plist_path"
then
	echo Not installing files because bundle Info.plist $install_path_bundle_info_plist_path does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
else
	installed_version="`/usr/bin/defaults read "$install_path_bundle_info_plist_path" CFBundleVersion`"
	echo Comparing installed version "$installed_version" with payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
	versions_array=(`printf "$installed_version\n$payload_version\n" | sort -n -t .`)
	if [ "$payload_version" = "$installed_version" ]
	then
		INSTALL_FILES=1
	else
		if [ "$payload_version" = "${versions_array[1]}" ]
		then
			echo Not installing files because installed version "$installed_version" is greater than payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		else
			INSTALL_FILES=1
		fi
	fi
fi

if [ $INSTALL_FILES -eq 1 ]
then
	echo Installing files... >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

	if /bin/test -e "$2/DFonts/Rockwell Extra Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Extra Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Rockwell Extra Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Extra Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Extra Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Extra Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/webdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/webdings.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/webdings.ttf"
		then
			echo Error copying "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/webdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dengb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dengb.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Dengb.ttf"
		then
			echo Error copying "$2/DFonts/Dengb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dengb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dengb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candarai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candarai.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Candarai.ttf"
		then
			echo Error copying "$2/DFonts/Candarai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candarai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candarai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambria.ttc"
	then
		if ! $ditto_command "$2/DFonts/Cambria.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Cambria.ttc"
		then
			echo Error copying "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambria.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Verdana Bold.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GillSansUltraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/GillSansUltraBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/GillSansUltraBold.ttf"
		then
			echo Error copying "$2/DFonts/GillSansUltraBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GillSansUltraBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GillSansUltraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BernardMTCondensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/BernardMTCondensed.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/BernardMTCondensed.ttf"
		then
			echo Error copying "$2/DFonts/BernardMTCondensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BernardMTCondensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BernardMTCondensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constani.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constani.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Constani.ttf"
		then
			echo Error copying "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constani.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriab.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Cambriab.ttf"
		then
			echo Error copying "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palab.ttf"
	then
		if ! $ditto_command "$2/DFonts/palab.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/palab.ttf"
		then
			echo Error copying "$2/DFonts/palab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Medium.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Medium.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Dubai-Medium.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Medium.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BritannicBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/BritannicBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/BritannicBold.ttf"
		then
			echo Error copying "$2/DFonts/BritannicBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BritannicBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BritannicBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxRegular.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxRegular.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaFaxRegular.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxRegular.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxRegular.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxRegular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbd.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/arialbd.ttf"
		then
			echo Error copying "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/symbol.ttf"
	then
		if ! $ditto_command "$2/DFonts/symbol.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/symbol.ttf"
		then
			echo Error copying "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/symbol.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Verdana Italic.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Narrow.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguisym.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguisym.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/seguisym.ttf"
		then
			echo Error copying "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguisym.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Fangsong.ttf"
	then
		if ! $ditto_command "$2/DFonts/Fangsong.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Fangsong.ttf"
		then
			echo Error copying "$2/DFonts/Fangsong.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Fangsong.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Fangsong.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRGE.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRGE.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/HGRGE.ttc"
		then
			echo Error copying "$2/DFonts/HGRGE.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRGE.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRGE.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gabriola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gabriola.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gabriola.ttf"
		then
			echo Error copying "$2/DFonts/Gabriola.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gabriola.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gabriola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CalistoMTBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/CalistoMTBoldItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/CalistoMTBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/CalistoMTBoldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CalistoMTBoldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CalistoMTBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ComicSansMSBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/ComicSansMSBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ComicSansMSBold.ttf"
		then
			echo Error copying "$2/DFonts/ComicSansMSBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ComicSansMSBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ComicSansMSBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/News Gothic MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/Kaiti.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Kaiti.ttf"
		then
			echo Error copying "$2/DFonts/Kaiti.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kaiti.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Regular.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Regular.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Dubai-Regular.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Regular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yumin.ttf"
	then
		if ! $ditto_command "$2/DFonts/yumin.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/yumin.ttf"
		then
			echo Error copying "$2/DFonts/yumin.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yumin.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yumin.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Display-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Perpetua Italic.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightDemiboldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightDemiboldItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaBrightDemiboldItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightDemiboldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightDemiboldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightDemiboldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/simsunb.ttf"
	then
		if ! $ditto_command "$2/DFonts/simsunb.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/simsunb.ttf"
		then
			echo Error copying "$2/DFonts/simsunb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/simsunb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/simsunb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/AbadiMTCondensedLight.ttf"
	then
		if ! $ditto_command "$2/DFonts/AbadiMTCondensedLight.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/AbadiMTCondensedLight.ttf"
		then
			echo Error copying "$2/DFonts/AbadiMTCondensedLight.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/AbadiMTCondensedLight.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/AbadiMTCondensedLight.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/COOPBL.TTF"
	then
		if ! $ditto_command "$2/DFonts/COOPBL.TTF" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/COOPBL.TTF"
		then
			echo Error copying "$2/DFonts/COOPBL.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/COOPBL.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/COOPBL.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgunsl.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgunsl.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/malgunsl.ttf"
		then
			echo Error copying "$2/DFonts/malgunsl.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgunsl.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgunsl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanz.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Constanz.ttf"
		then
			echo Error copying "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBlackletter.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBlackletter.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaBlackletter.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBlackletter.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBlackletter.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBlackletter.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Light-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tw Cen MT.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Medium Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbel.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbel.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Corbel.ttf"
		then
			echo Error copying "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbel.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mmrtext.ttf"
	then
		if ! $ditto_command "$2/DFonts/mmrtext.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/mmrtext.ttf"
		then
			echo Error copying "$2/DFonts/mmrtext.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mmrtext.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mmrtext.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MS Reference Specialty.ttf"
	then
		if ! $ditto_command "$2/DFonts/MS Reference Specialty.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MS Reference Specialty.ttf"
		then
			echo Error copying "$2/DFonts/MS Reference Specialty.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MS Reference Specialty.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MS Reference Specialty.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi Cond.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi Cond.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Demi Cond.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi Cond.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi Cond.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi Cond.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candaraz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candaraz.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Candaraz.ttf"
		then
			echo Error copying "$2/DFonts/Candaraz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candaraz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candaraz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Segoe Print Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Segoe Print Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Segoe Print Bold.ttf"
		then
			echo Error copying "$2/DFonts/Segoe Print Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Segoe Print Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Segoe Print Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Display-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolab.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Consolab.ttf"
		then
			echo Error copying "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century Schoolbook.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium Cond.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium Cond.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Medium Cond.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium Cond.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium Cond.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium Cond.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STLITI.ttf"
	then
		if ! $ditto_command "$2/DFonts/STLITI.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/STLITI.ttf"
		then
			echo Error copying "$2/DFonts/STLITI.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STLITI.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STLITI.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ntailub.ttf"
	then
		if ! $ditto_command "$2/DFonts/ntailub.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ntailub.ttf"
		then
			echo Error copying "$2/DFonts/ntailub.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ntailub.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ntailub.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyhl.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyhl.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/msyhl.ttc"
		then
			echo Error copying "$2/DFonts/msyhl.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyhl.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyhl.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/SimHei.ttf"
	then
		if ! $ditto_command "$2/DFonts/SimHei.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/SimHei.ttf"
		then
			echo Error copying "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/SimHei.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMTItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMTItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/BellMTItalic.ttf"
		then
			echo Error copying "$2/DFonts/BellMTItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMTItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMTItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Condensed.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gill Sans MT Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Condensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Condensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century Schoolbook Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautami.TTF"
	then
		if ! $ditto_command "$2/DFonts/Gautami.TTF" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gautami.TTF"
		then
			echo Error copying "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautami.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterOblique.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterOblique.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaSansTypewriterOblique.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterOblique.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterOblique.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterOblique.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrii.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrii.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Calibrii.ttf"
		then
			echo Error copying "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrii.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msgothic.ttc"
	then
		if ! $ditto_command "$2/DFonts/msgothic.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/msgothic.ttc"
		then
			echo Error copying "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msgothic.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothR.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothR.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/YuGothR.ttc"
		then
			echo Error copying "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothR.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Perpetua Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Bookman Old Style Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/pala.ttf"
	then
		if ! $ditto_command "$2/DFonts/pala.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/pala.ttf"
		then
			echo Error copying "$2/DFonts/pala.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/pala.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/pala.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahomabd.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahomabd.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/tahomabd.ttf"
		then
			echo Error copying "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahomabd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Lucida Sans Italic.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsai.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsai.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/angsai.ttf"
		then
			echo Error copying "$2/DFonts/angsai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Stencil.ttf"
	then
		if ! $ditto_command "$2/DFonts/Stencil.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Stencil.ttf"
		then
			echo Error copying "$2/DFonts/Stencil.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Stencil.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Stencil.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GloucesterMTExtraCondensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/GloucesterMTExtraCondensed.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/GloucesterMTExtraCondensed.ttf"
		then
			echo Error copying "$2/DFonts/GloucesterMTExtraCondensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GloucesterMTExtraCondensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GloucesterMTExtraCondensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/davidbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/davidbd.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/davidbd.ttf"
		then
			echo Error copying "$2/DFonts/davidbd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/davidbd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/davidbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/TrebuchetMSBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/TrebuchetMSBoldItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/TrebuchetMSBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/TrebuchetMSBoldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/TrebuchetMSBoldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/TrebuchetMSBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookshelf Symbol 7.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookshelf Symbol 7.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Bookshelf Symbol 7.ttf"
		then
			echo Error copying "$2/DFonts/Bookshelf Symbol 7.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookshelf Symbol 7.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookshelf Symbol 7.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gill Sans MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-SemiBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Condensed.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Rockwell Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Condensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Condensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ModernNo.20.ttf"
	then
		if ! $ditto_command "$2/DFonts/ModernNo.20.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ModernNo.20.ttf"
		then
			echo Error copying "$2/DFonts/ModernNo.20.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ModernNo.20.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ModernNo.20.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/times.ttf"
	then
		if ! $ditto_command "$2/DFonts/times.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/times.ttf"
		then
			echo Error copying "$2/DFonts/times.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/times.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/times.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaFaxItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelb.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Corbelb.ttf"
		then
			echo Error copying "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century Gothic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yuminl.ttf"
	then
		if ! $ditto_command "$2/DFonts/yuminl.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/yuminl.ttf"
		then
			echo Error copying "$2/DFonts/yuminl.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yuminl.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yuminl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Simsun.ttc"
	then
		if ! $ditto_command "$2/DFonts/Simsun.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Simsun.ttc"
		then
			echo Error copying "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Simsun.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Bookman Old Style.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Titling MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Titling MT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Perpetua Titling MT.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Titling MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Titling MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Titling MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Marlett.ttf"
	then
		if ! $ditto_command "$2/DFonts/Marlett.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Marlett.ttf"
		then
			echo Error copying "$2/DFonts/Marlett.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Marlett.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Marlett.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRME.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRME.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/HGRME.ttc"
		then
			echo Error copying "$2/DFonts/HGRME.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRME.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRME.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRSGU.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRSGU.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/HGRSGU.ttc"
		then
			echo Error copying "$2/DFonts/HGRSGU.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRSGU.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRSGU.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/cordia.ttc"
	then
		if ! $ditto_command "$2/DFonts/cordia.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/cordia.ttc"
		then
			echo Error copying "$2/DFonts/cordia.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/cordia.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/cordia.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BaskervilleOldFace.ttf"
	then
		if ! $ditto_command "$2/DFonts/BaskervilleOldFace.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/BaskervilleOldFace.ttf"
		then
			echo Error copying "$2/DFonts/BaskervilleOldFace.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BaskervilleOldFace.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BaskervilleOldFace.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothB.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothB.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/YuGothB.ttc"
		then
			echo Error copying "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothB.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tw Cen MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century Gothic Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialNarrowItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialNarrowItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ArialNarrowItalic.ttf"
		then
			echo Error copying "$2/DFonts/ArialNarrowItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialNarrowItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialNarrowItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/WideLatin.ttf"
	then
		if ! $ditto_command "$2/DFonts/WideLatin.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/WideLatin.ttf"
		then
			echo Error copying "$2/DFonts/WideLatin.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/WideLatin.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/WideLatin.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EngraversMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/EngraversMT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/EngraversMT.ttf"
		then
			echo Error copying "$2/DFonts/EngraversMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EngraversMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EngraversMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryob.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryob.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/meiryob.ttc"
		then
			echo Error copying "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryob.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Book Antiqua Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyh.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyh.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/msyh.ttc"
		then
			echo Error copying "$2/DFonts/msyh.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyh.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyh.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Rockwell Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tungab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tungab.TTF" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tungab.TTF"
		then
			echo Error copying "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tungab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbd.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/timesbd.ttf"
		then
			echo Error copying "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsaz.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/angsaz.ttf"
		then
			echo Error copying "$2/DFonts/angsaz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsaz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgunbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgunbd.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/malgunbd.ttf"
		then
			echo Error copying "$2/DFonts/malgunbd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgunbd.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgunbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century.ttf"
		then
			echo Error copying "$2/DFonts/Century.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Console.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Console.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Lucida Console.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Console.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Console.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Console.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EngraversMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/EngraversMTBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/EngraversMTBold.ttf"
		then
			echo Error copying "$2/DFonts/EngraversMTBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EngraversMTBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EngraversMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Haettenschweiler.ttf"
	then
		if ! $ditto_command "$2/DFonts/Haettenschweiler.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Haettenschweiler.ttf"
		then
			echo Error copying "$2/DFonts/Haettenschweiler.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Haettenschweiler.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Haettenschweiler.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibriz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibriz.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Calibriz.ttf"
		then
			echo Error copying "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibriz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century Gothic Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguihis.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguihis.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/seguihis.ttf"
		then
			echo Error copying "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguihis.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Goudy Old Style.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Narrow-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesi.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/timesi.ttf"
		then
			echo Error copying "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Bookman Old Style Bold.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 3.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 3.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Wingdings 3.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 3.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightDemibold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightDemibold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaBrightDemibold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightDemibold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightDemibold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightDemibold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 2.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 2.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Wingdings 2.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 2.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Goudy Old Style Bold.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibril.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibril.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/calibril.ttf"
		then
			echo Error copying "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibril.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STXINGKA.ttf"
	then
		if ! $ditto_command "$2/DFonts/STXINGKA.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/STXINGKA.ttf"
		then
			echo Error copying "$2/DFonts/STXINGKA.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STXINGKA.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STXINGKA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Narrow-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Black.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consola.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Consola.ttf"
		then
			echo Error copying "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gill Sans MT Ext Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century Schoolbook Bold.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialNarrowBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialNarrowBoldItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ArialNarrowBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/ArialNarrowBoldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialNarrowBoldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialNarrowBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Display-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/monbaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/monbaiti.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/monbaiti.ttf"
		then
			echo Error copying "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/monbaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothM.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothM.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/YuGothM.ttc"
		then
			echo Error copying "$2/DFonts/YuGothM.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothM.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothM.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Demibold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Demibold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Lucida Sans Demibold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Demibold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Demibold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Demibold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbeli.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbeli.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Corbeli.ttf"
		then
			echo Error copying "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbeli.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARA.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARA.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/GARA.ttf"
		then
			echo Error copying "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABD.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABD.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/GARABD.ttf"
		then
			echo Error copying "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CurlzMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/CurlzMT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/CurlzMT.ttf"
		then
			echo Error copying "$2/DFonts/CurlzMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CurlzMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CurlzMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msmincho.ttc"
	then
		if ! $ditto_command "$2/DFonts/msmincho.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/msmincho.ttc"
		then
			echo Error copying "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msmincho.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Goudy Old Style Italic.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsa.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsa.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/angsa.ttf"
		then
			echo Error copying "$2/DFonts/angsa.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsa.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsa.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/gulim.ttc"
	then
		if ! $ditto_command "$2/DFonts/gulim.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/gulim.ttc"
		then
			echo Error copying "$2/DFonts/gulim.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/gulim.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/gulim.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lathab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lathab.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Lathab.ttf"
		then
			echo Error copying "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lathab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothL.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothL.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/YuGothL.ttc"
		then
			echo Error copying "$2/DFonts/YuGothL.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothL.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothL.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candara.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candara.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Candara.ttf"
		then
			echo Error copying "$2/DFonts/Candara.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candara.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candara.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsab.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsab.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/angsab.ttf"
		then
			echo Error copying "$2/DFonts/angsab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MTEXTRA.ttf"
	then
		if ! $ditto_command "$2/DFonts/MTEXTRA.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MTEXTRA.ttf"
		then
			echo Error copying "$2/DFonts/MTEXTRA.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MTEXTRA.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MTEXTRA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tunga.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tunga.TTF" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tunga.TTF"
		then
			echo Error copying "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tunga.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Deng.ttf"
	then
		if ! $ditto_command "$2/DFonts/Deng.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Deng.ttf"
		then
			echo Error copying "$2/DFonts/Deng.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Deng.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Deng.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaBrightItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/thsarabun.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRSMP.ttf"
	then
		if ! $ditto_command "$2/DFonts/HGRSMP.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/HGRSMP.ttf"
		then
			echo Error copying "$2/DFonts/HGRSMP.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRSMP.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRSMP.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Titling MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Titling MT Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Perpetua Titling MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Titling MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Titling MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Titling MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/TaiLeb.ttf"
	then
		if ! $ditto_command "$2/DFonts/TaiLeb.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/TaiLeb.ttf"
		then
			echo Error copying "$2/DFonts/TaiLeb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/TaiLeb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/TaiLeb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Medium.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Rockwell Italic.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/batang.ttc"
	then
		if ! $ditto_command "$2/DFonts/batang.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/batang.ttc"
		then
			echo Error copying "$2/DFonts/batang.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/batang.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/batang.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Braggadocio.ttf"
	then
		if ! $ditto_command "$2/DFonts/Braggadocio.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Braggadocio.ttf"
		then
			echo Error copying "$2/DFonts/Braggadocio.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Braggadocio.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Braggadocio.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Unicode.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Unicode.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Lucida Sans Unicode.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Unicode.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Unicode.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Unicode.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaCalligraphyItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaCalligraphyItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaCalligraphyItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaCalligraphyItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaCalligraphyItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaCalligraphyItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbi.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/timesbi.ttf"
		then
			echo Error copying "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MSJHBD.ttf"
	then
		if ! $ditto_command "$2/DFonts/MSJHBD.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MSJHBD.ttf"
		then
			echo Error copying "$2/DFonts/MSJHBD.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MSJHBD.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MSJHBD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos.ttf"
		then
			echo Error copying "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrib.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Calibrib.ttf"
		then
			echo Error copying "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Light.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arial.ttf"
	then
		if ! $ditto_command "$2/DFonts/arial.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/arial.ttf"
		then
			echo Error copying "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arial.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariblk.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariblk.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ariblk.ttf"
		then
			echo Error copying "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariblk.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/KinoMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/KinoMT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/KinoMT.ttf"
		then
			echo Error copying "$2/DFonts/KinoMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/KinoMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/KinoMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Rockwell.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Condensed Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Rockwell Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Condensed Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Condensed Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-ExtraBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Heavy.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Heavy.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Heavy.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Heavy.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Heavy.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Heavy.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STHUPO.ttf"
	then
		if ! $ditto_command "$2/DFonts/STHUPO.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/STHUPO.ttf"
		then
			echo Error copying "$2/DFonts/STHUPO.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STHUPO.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STHUPO.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Book Antiqua.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MangalB.ttf"
	then
		if ! $ditto_command "$2/DFonts/MangalB.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MangalB.ttf"
		then
			echo Error copying "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MangalB.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yumindb.ttf"
	then
		if ! $ditto_command "$2/DFonts/yumindb.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/yumindb.ttf"
		then
			echo Error copying "$2/DFonts/yumindb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yumindb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yumindb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMTBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/BellMTBold.ttf"
		then
			echo Error copying "$2/DFonts/BellMTBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMTBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaSansTypewriterBold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Book.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Book.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Book.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Book.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Book.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Book.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century Schoolbook Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Black-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Narrow-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MSJH.ttf"
	then
		if ! $ditto_command "$2/DFonts/MSJH.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MSJH.ttf"
		then
			echo Error copying "$2/DFonts/MSJH.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MSJH.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MSJH.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/BellMT.ttf"
		then
			echo Error copying "$2/DFonts/BellMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryo.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryo.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/meiryo.ttc"
		then
			echo Error copying "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryo.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliu.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliu.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/mingliu.ttc"
		then
			echo Error copying "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliu.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palabi.ttf"
	then
		if ! $ditto_command "$2/DFonts/palabi.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/palabi.ttf"
		then
			echo Error copying "$2/DFonts/palabi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palabi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palabi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constan.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constan.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Constan.ttf"
		then
			echo Error copying "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constan.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tw Cen MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaHandwritingItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaHandwritingItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaHandwritingItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaHandwritingItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaHandwritingItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaHandwritingItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tw Cen MT Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliub.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliub.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/mingliub.ttc"
		then
			echo Error copying "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliub.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold-italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/thsarabun-bold-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/thsarabun-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Perpetua.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Bookman Old Style Italic.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/taile.ttf"
	then
		if ! $ditto_command "$2/DFonts/taile.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/taile.ttf"
		then
			echo Error copying "$2/DFonts/taile.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/taile.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/taile.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialRoundedMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialRoundedMTBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ArialRoundedMTBold.ttf"
		then
			echo Error copying "$2/DFonts/ArialRoundedMTBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialRoundedMTBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialRoundedMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mmrtextb.ttf"
	then
		if ! $ditto_command "$2/DFonts/mmrtextb.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/mmrtextb.ttf"
		then
			echo Error copying "$2/DFonts/mmrtextb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mmrtextb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mmrtextb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-Display.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelz.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Corbelz.ttf"
		then
			echo Error copying "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-ExtraBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABDIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABDIT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/GARABDIT.ttf"
		then
			echo Error copying "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABDIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Wingdings.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyhbd.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyhbd.ttc" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/msyhbd.ttc"
		then
			echo Error copying "$2/DFonts/msyhbd.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyhbd.ttc" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyhbd.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gill Sans MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahoma.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahoma.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/tahoma.ttf"
		then
			echo Error copying "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahoma.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/himalaya.ttf"
	then
		if ! $ditto_command "$2/DFonts/himalaya.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/himalaya.ttf"
		then
			echo Error copying "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/himalaya.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/FootlightMTLight.ttf"
	then
		if ! $ditto_command "$2/DFonts/FootlightMTLight.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/FootlightMTLight.ttf"
		then
			echo Error copying "$2/DFonts/FootlightMTLight.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/FootlightMTLight.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/FootlightMTLight.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MS Reference Sans Serif.ttf"
	then
		if ! $ditto_command "$2/DFonts/MS Reference Sans Serif.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MS Reference Sans Serif.ttf"
		then
			echo Error copying "$2/DFonts/MS Reference Sans Serif.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MS Reference Sans Serif.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MS Reference Sans Serif.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tw Cen MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Verdana Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Heavy Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Heavy Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Heavy Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Heavy Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Heavy Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Heavy Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Onyx.ttf"
	then
		if ! $ditto_command "$2/DFonts/Onyx.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Onyx.ttf"
		then
			echo Error copying "$2/DFonts/Onyx.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Onyx.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Onyx.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Segoe Script Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Segoe Script Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Segoe Script Bold.ttf"
		then
			echo Error copying "$2/DFonts/Segoe Script Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Segoe Script Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Segoe Script Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxDemibold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxDemibold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaFaxDemibold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxDemibold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxDemibold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxDemibold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MaturaMTScriptCapitals.ttf"
	then
		if ! $ditto_command "$2/DFonts/MaturaMTScriptCapitals.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MaturaMTScriptCapitals.ttf"
		then
			echo Error copying "$2/DFonts/MaturaMTScriptCapitals.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MaturaMTScriptCapitals.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MaturaMTScriptCapitals.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariali.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariali.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ariali.ttf"
		then
			echo Error copying "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariali.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ColonnaMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/ColonnaMT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ColonnaMT.ttf"
		then
			echo Error copying "$2/DFonts/ColonnaMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ColonnaMT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ColonnaMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/News Gothic MT.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palai.ttf"
	then
		if ! $ditto_command "$2/DFonts/palai.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/palai.ttf"
		then
			echo Error copying "$2/DFonts/palai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriai.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Cambriai.ttf"
		then
			echo Error copying "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterRegular.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterRegular.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaSansTypewriterRegular.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterRegular.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterRegular.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterRegular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanb.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Constanb.ttf"
		then
			echo Error copying "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Harrington.ttf"
	then
		if ! $ditto_command "$2/DFonts/Harrington.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Harrington.ttf"
		then
			echo Error copying "$2/DFonts/Harrington.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Harrington.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Harrington.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gill Sans MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Book Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Book Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Book Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Book Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Book Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Book Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STZHONGS.ttf"
	then
		if ! $ditto_command "$2/DFonts/STZHONGS.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/STZHONGS.ttf"
		then
			echo Error copying "$2/DFonts/STZHONGS.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STZHONGS.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STZHONGS.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Mistral.ttf"
	then
		if ! $ditto_command "$2/DFonts/Mistral.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Mistral.ttf"
		then
			echo Error copying "$2/DFonts/Mistral.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Mistral.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Mistral.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tw Cen MT Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARAIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARAIT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/GARAIT.ttf"
		then
			echo Error copying "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARAIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartika.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartika.TTF" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Kartika.TTF"
		then
			echo Error copying "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartika.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ntailu.ttf"
	then
		if ! $ditto_command "$2/DFonts/ntailu.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ntailu.ttf"
		then
			echo Error copying "$2/DFonts/ntailu.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ntailu.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ntailu.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/News Gothic MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candarab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candarab.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Candarab.ttf"
		then
			echo Error copying "$2/DFonts/Candarab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candarab.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candarab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ImprintMTShadow.ttf"
	then
		if ! $ditto_command "$2/DFonts/ImprintMTShadow.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/ImprintMTShadow.ttf"
		then
			echo Error copying "$2/DFonts/ImprintMTShadow.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ImprintMTShadow.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ImprintMTShadow.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Calisto MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolaz.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Consolaz.ttf"
		then
			echo Error copying "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/thsarabun-bold.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaSansTypewriterBoldOblique.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/david.ttf"
	then
		if ! $ditto_command "$2/DFonts/david.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/david.ttf"
		then
			echo Error copying "$2/DFonts/david.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/david.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/david.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBright.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBright.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaBright.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBright.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBright.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBright.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Calisto MT.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Eurostile Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Eurostile Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Eurostile Bold.ttf"
		then
			echo Error copying "$2/DFonts/Eurostile Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Eurostile Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Eurostile Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STXINWEI.ttf"
	then
		if ! $ditto_command "$2/DFonts/STXINWEI.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/STXINWEI.ttf"
		then
			echo Error copying "$2/DFonts/STXINWEI.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STXINWEI.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STXINWEI.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MonotypeSorts.ttf"
	then
		if ! $ditto_command "$2/DFonts/MonotypeSorts.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MonotypeSorts.ttf"
		then
			echo Error copying "$2/DFonts/MonotypeSorts.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MonotypeSorts.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MonotypeSorts.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Desdemona.ttf"
	then
		if ! $ditto_command "$2/DFonts/Desdemona.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Desdemona.ttf"
		then
			echo Error copying "$2/DFonts/Desdemona.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Desdemona.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Desdemona.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolai.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Consolai.ttf"
		then
			echo Error copying "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxDemiboldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxDemiboldItalic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/LucidaFaxDemiboldItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxDemiboldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxDemiboldItalic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxDemiboldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Lucida Sans.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Aptos-SemiBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Light.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Dubai-Light.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Bold Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Rockwell Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Bold Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mangal.ttf"
	then
		if ! $ditto_command "$2/DFonts/mangal.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/mangal.ttf"
		then
			echo Error copying "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mangal.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Eurostile.ttf"
	then
		if ! $ditto_command "$2/DFonts/Eurostile.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Eurostile.ttf"
		then
			echo Error copying "$2/DFonts/Eurostile.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Eurostile.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Eurostile.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/latha.ttf"
	then
		if ! $ditto_command "$2/DFonts/latha.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/latha.ttf"
		then
			echo Error copying "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/latha.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dengl.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dengl.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Dengl.ttf"
		then
			echo Error copying "$2/DFonts/Dengl.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dengl.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dengl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautamib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gautamib.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gautamib.ttf"
		then
			echo Error copying "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautamib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EdwardianScriptITC.ttf"
	then
		if ! $ditto_command "$2/DFonts/EdwardianScriptITC.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/EdwardianScriptITC.ttf"
		then
			echo Error copying "$2/DFonts/EdwardianScriptITC.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EdwardianScriptITC.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EdwardianScriptITC.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbi.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/arialbi.ttf"
		then
			echo Error copying "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Book Antiqua Bold.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Century Gothic Bold.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/News Gothic MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriaz.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Cambriaz.ttf"
		then
			echo Error copying "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Gill Sans MT.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibri.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibri.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Calibri.ttf"
		then
			echo Error copying "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibri.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Demibold Roman.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Demibold Roman.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Lucida Sans Demibold Roman.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Demibold Roman.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Demibold Roman.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Demibold Roman.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Demi Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Tw Cen MT Condensed Extra Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MonotypeCorsiva.ttf"
	then
		if ! $ditto_command "$2/DFonts/MonotypeCorsiva.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/MonotypeCorsiva.ttf"
		then
			echo Error copying "$2/DFonts/MonotypeCorsiva.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MonotypeCorsiva.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MonotypeCorsiva.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgun.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgun.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/malgun.ttf"
		then
			echo Error copying "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibrili.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibrili.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/calibrili.ttf"
		then
			echo Error copying "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibrili.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/AbadiMTCondensedExtraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/AbadiMTCondensedExtraBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/AbadiMTCondensedExtraBold.ttf"
		then
			echo Error copying "$2/DFonts/AbadiMTCondensedExtraBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/AbadiMTCondensedExtraBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/AbadiMTCondensedExtraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Franklin Gothic Demi.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Italic.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Book Antiqua Italic.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Italic.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CopperplateGothicBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/CopperplateGothicBold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/CopperplateGothicBold.ttf"
		then
			echo Error copying "$2/DFonts/CopperplateGothicBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CopperplateGothicBold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CopperplateGothicBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyi.ttf"
	then
		if ! $ditto_command "$2/DFonts/msyi.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/msyi.ttf"
		then
			echo Error copying "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Verdana.ttf"
		then
			echo Error copying "$2/DFonts/Verdana.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Dubai-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bauhaus93.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bauhaus93.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Bauhaus93.ttf"
		then
			echo Error copying "$2/DFonts/Bauhaus93.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bauhaus93.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bauhaus93.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Calisto MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartikab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartikab.TTF" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Kartikab.TTF"
		then
			echo Error copying "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartikab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Bold.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/Perpetua Bold.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Bold.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/nyala.ttf"
	then
		if ! $ditto_command "$2/DFonts/nyala.ttf" "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts/nyala.ttf"
		then
			echo Error copying "$2/DFonts/nyala.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/nyala.ttf" to "$3/Applications/Microsoft Excel.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/nyala.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	echo Finished installing files. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
fi

echo Ending "/Applications/Microsoft Excel.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

echo Beginning "/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

payload_version="16.77.23091003"

ditto_command=(/usr/bin/ditto)
autoload is-at-least
if is-at-least 14.0 $(/usr/bin/sw_vers -productVersion); then
	ditto_command=(/usr/bin/ditto --clone)
fi

INSTALL_FILES=0
install_path_bundle_info_plist_path="$3/Applications/Microsoft PowerPoint.app/Contents/Info.plist"
if ! /bin/test -e "$install_path_bundle_info_plist_path"
then
	echo Not installing files because bundle Info.plist $install_path_bundle_info_plist_path does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
else
	installed_version="`/usr/bin/defaults read "$install_path_bundle_info_plist_path" CFBundleVersion`"
	echo Comparing installed version "$installed_version" with payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
	versions_array=(`printf "$installed_version\n$payload_version\n" | sort -n -t .`)
	if [ "$payload_version" = "$installed_version" ]
	then
		INSTALL_FILES=1
	else
		if [ "$payload_version" = "${versions_array[1]}" ]
		then
			echo Not installing files because installed version "$installed_version" is greater than payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		else
			INSTALL_FILES=1
		fi
	fi
fi

if [ $INSTALL_FILES -eq 1 ]
then
	echo Installing files... >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

	if /bin/test -e "$2/DFonts/Rockwell Extra Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Extra Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Rockwell Extra Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Extra Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Extra Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Extra Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/webdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/webdings.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/webdings.ttf"
		then
			echo Error copying "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/webdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dengb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dengb.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Dengb.ttf"
		then
			echo Error copying "$2/DFonts/Dengb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dengb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dengb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candarai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candarai.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Candarai.ttf"
		then
			echo Error copying "$2/DFonts/Candarai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candarai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candarai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambria.ttc"
	then
		if ! $ditto_command "$2/DFonts/Cambria.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Cambria.ttc"
		then
			echo Error copying "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambria.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Verdana Bold.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GillSansUltraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/GillSansUltraBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/GillSansUltraBold.ttf"
		then
			echo Error copying "$2/DFonts/GillSansUltraBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GillSansUltraBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GillSansUltraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BernardMTCondensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/BernardMTCondensed.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/BernardMTCondensed.ttf"
		then
			echo Error copying "$2/DFonts/BernardMTCondensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BernardMTCondensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BernardMTCondensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constani.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constani.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Constani.ttf"
		then
			echo Error copying "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constani.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriab.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Cambriab.ttf"
		then
			echo Error copying "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palab.ttf"
	then
		if ! $ditto_command "$2/DFonts/palab.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/palab.ttf"
		then
			echo Error copying "$2/DFonts/palab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Medium.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Medium.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Dubai-Medium.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Medium.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BritannicBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/BritannicBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/BritannicBold.ttf"
		then
			echo Error copying "$2/DFonts/BritannicBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BritannicBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BritannicBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxRegular.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxRegular.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaFaxRegular.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxRegular.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxRegular.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxRegular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbd.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/arialbd.ttf"
		then
			echo Error copying "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/symbol.ttf"
	then
		if ! $ditto_command "$2/DFonts/symbol.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/symbol.ttf"
		then
			echo Error copying "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/symbol.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Verdana Italic.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Narrow.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguisym.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguisym.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/seguisym.ttf"
		then
			echo Error copying "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguisym.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Fangsong.ttf"
	then
		if ! $ditto_command "$2/DFonts/Fangsong.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Fangsong.ttf"
		then
			echo Error copying "$2/DFonts/Fangsong.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Fangsong.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Fangsong.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRGE.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRGE.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/HGRGE.ttc"
		then
			echo Error copying "$2/DFonts/HGRGE.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRGE.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRGE.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gabriola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gabriola.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gabriola.ttf"
		then
			echo Error copying "$2/DFonts/Gabriola.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gabriola.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gabriola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CalistoMTBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/CalistoMTBoldItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/CalistoMTBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/CalistoMTBoldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CalistoMTBoldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CalistoMTBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ComicSansMSBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/ComicSansMSBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ComicSansMSBold.ttf"
		then
			echo Error copying "$2/DFonts/ComicSansMSBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ComicSansMSBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ComicSansMSBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/News Gothic MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/Kaiti.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Kaiti.ttf"
		then
			echo Error copying "$2/DFonts/Kaiti.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kaiti.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Regular.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Regular.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Dubai-Regular.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Regular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yumin.ttf"
	then
		if ! $ditto_command "$2/DFonts/yumin.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/yumin.ttf"
		then
			echo Error copying "$2/DFonts/yumin.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yumin.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yumin.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Display-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Perpetua Italic.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightDemiboldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightDemiboldItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaBrightDemiboldItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightDemiboldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightDemiboldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightDemiboldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/simsunb.ttf"
	then
		if ! $ditto_command "$2/DFonts/simsunb.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/simsunb.ttf"
		then
			echo Error copying "$2/DFonts/simsunb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/simsunb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/simsunb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/AbadiMTCondensedLight.ttf"
	then
		if ! $ditto_command "$2/DFonts/AbadiMTCondensedLight.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/AbadiMTCondensedLight.ttf"
		then
			echo Error copying "$2/DFonts/AbadiMTCondensedLight.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/AbadiMTCondensedLight.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/AbadiMTCondensedLight.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/COOPBL.TTF"
	then
		if ! $ditto_command "$2/DFonts/COOPBL.TTF" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/COOPBL.TTF"
		then
			echo Error copying "$2/DFonts/COOPBL.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/COOPBL.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/COOPBL.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgunsl.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgunsl.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/malgunsl.ttf"
		then
			echo Error copying "$2/DFonts/malgunsl.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgunsl.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgunsl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanz.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Constanz.ttf"
		then
			echo Error copying "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBlackletter.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBlackletter.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaBlackletter.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBlackletter.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBlackletter.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBlackletter.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Light-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tw Cen MT.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Medium Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbel.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbel.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Corbel.ttf"
		then
			echo Error copying "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbel.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mmrtext.ttf"
	then
		if ! $ditto_command "$2/DFonts/mmrtext.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/mmrtext.ttf"
		then
			echo Error copying "$2/DFonts/mmrtext.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mmrtext.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mmrtext.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MS Reference Specialty.ttf"
	then
		if ! $ditto_command "$2/DFonts/MS Reference Specialty.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MS Reference Specialty.ttf"
		then
			echo Error copying "$2/DFonts/MS Reference Specialty.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MS Reference Specialty.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MS Reference Specialty.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi Cond.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi Cond.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Demi Cond.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi Cond.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi Cond.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi Cond.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candaraz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candaraz.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Candaraz.ttf"
		then
			echo Error copying "$2/DFonts/Candaraz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candaraz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candaraz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Segoe Print Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Segoe Print Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Segoe Print Bold.ttf"
		then
			echo Error copying "$2/DFonts/Segoe Print Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Segoe Print Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Segoe Print Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Display-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolab.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Consolab.ttf"
		then
			echo Error copying "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century Schoolbook.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium Cond.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium Cond.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Medium Cond.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium Cond.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium Cond.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium Cond.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STLITI.ttf"
	then
		if ! $ditto_command "$2/DFonts/STLITI.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/STLITI.ttf"
		then
			echo Error copying "$2/DFonts/STLITI.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STLITI.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STLITI.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ntailub.ttf"
	then
		if ! $ditto_command "$2/DFonts/ntailub.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ntailub.ttf"
		then
			echo Error copying "$2/DFonts/ntailub.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ntailub.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ntailub.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyhl.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyhl.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/msyhl.ttc"
		then
			echo Error copying "$2/DFonts/msyhl.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyhl.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyhl.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/SimHei.ttf"
	then
		if ! $ditto_command "$2/DFonts/SimHei.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/SimHei.ttf"
		then
			echo Error copying "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/SimHei.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMTItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMTItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/BellMTItalic.ttf"
		then
			echo Error copying "$2/DFonts/BellMTItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMTItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMTItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Condensed.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gill Sans MT Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Condensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Condensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century Schoolbook Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautami.TTF"
	then
		if ! $ditto_command "$2/DFonts/Gautami.TTF" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gautami.TTF"
		then
			echo Error copying "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautami.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterOblique.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterOblique.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaSansTypewriterOblique.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterOblique.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterOblique.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterOblique.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrii.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrii.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Calibrii.ttf"
		then
			echo Error copying "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrii.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msgothic.ttc"
	then
		if ! $ditto_command "$2/DFonts/msgothic.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/msgothic.ttc"
		then
			echo Error copying "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msgothic.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothR.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothR.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/YuGothR.ttc"
		then
			echo Error copying "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothR.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Perpetua Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Bookman Old Style Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/pala.ttf"
	then
		if ! $ditto_command "$2/DFonts/pala.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/pala.ttf"
		then
			echo Error copying "$2/DFonts/pala.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/pala.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/pala.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahomabd.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahomabd.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/tahomabd.ttf"
		then
			echo Error copying "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahomabd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Lucida Sans Italic.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsai.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsai.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/angsai.ttf"
		then
			echo Error copying "$2/DFonts/angsai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Stencil.ttf"
	then
		if ! $ditto_command "$2/DFonts/Stencil.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Stencil.ttf"
		then
			echo Error copying "$2/DFonts/Stencil.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Stencil.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Stencil.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GloucesterMTExtraCondensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/GloucesterMTExtraCondensed.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/GloucesterMTExtraCondensed.ttf"
		then
			echo Error copying "$2/DFonts/GloucesterMTExtraCondensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GloucesterMTExtraCondensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GloucesterMTExtraCondensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/davidbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/davidbd.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/davidbd.ttf"
		then
			echo Error copying "$2/DFonts/davidbd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/davidbd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/davidbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/TrebuchetMSBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/TrebuchetMSBoldItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/TrebuchetMSBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/TrebuchetMSBoldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/TrebuchetMSBoldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/TrebuchetMSBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookshelf Symbol 7.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookshelf Symbol 7.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Bookshelf Symbol 7.ttf"
		then
			echo Error copying "$2/DFonts/Bookshelf Symbol 7.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookshelf Symbol 7.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookshelf Symbol 7.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gill Sans MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-SemiBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Condensed.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Rockwell Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Condensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Condensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ModernNo.20.ttf"
	then
		if ! $ditto_command "$2/DFonts/ModernNo.20.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ModernNo.20.ttf"
		then
			echo Error copying "$2/DFonts/ModernNo.20.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ModernNo.20.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ModernNo.20.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/times.ttf"
	then
		if ! $ditto_command "$2/DFonts/times.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/times.ttf"
		then
			echo Error copying "$2/DFonts/times.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/times.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/times.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaFaxItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelb.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Corbelb.ttf"
		then
			echo Error copying "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century Gothic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yuminl.ttf"
	then
		if ! $ditto_command "$2/DFonts/yuminl.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/yuminl.ttf"
		then
			echo Error copying "$2/DFonts/yuminl.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yuminl.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yuminl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Simsun.ttc"
	then
		if ! $ditto_command "$2/DFonts/Simsun.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Simsun.ttc"
		then
			echo Error copying "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Simsun.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Bookman Old Style.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Titling MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Titling MT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Perpetua Titling MT.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Titling MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Titling MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Titling MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Marlett.ttf"
	then
		if ! $ditto_command "$2/DFonts/Marlett.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Marlett.ttf"
		then
			echo Error copying "$2/DFonts/Marlett.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Marlett.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Marlett.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRME.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRME.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/HGRME.ttc"
		then
			echo Error copying "$2/DFonts/HGRME.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRME.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRME.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRSGU.ttc"
	then
		if ! $ditto_command "$2/DFonts/HGRSGU.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/HGRSGU.ttc"
		then
			echo Error copying "$2/DFonts/HGRSGU.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRSGU.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRSGU.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/cordia.ttc"
	then
		if ! $ditto_command "$2/DFonts/cordia.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/cordia.ttc"
		then
			echo Error copying "$2/DFonts/cordia.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/cordia.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/cordia.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BaskervilleOldFace.ttf"
	then
		if ! $ditto_command "$2/DFonts/BaskervilleOldFace.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/BaskervilleOldFace.ttf"
		then
			echo Error copying "$2/DFonts/BaskervilleOldFace.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BaskervilleOldFace.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BaskervilleOldFace.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothB.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothB.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/YuGothB.ttc"
		then
			echo Error copying "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothB.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tw Cen MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century Gothic Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialNarrowItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialNarrowItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ArialNarrowItalic.ttf"
		then
			echo Error copying "$2/DFonts/ArialNarrowItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialNarrowItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialNarrowItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/WideLatin.ttf"
	then
		if ! $ditto_command "$2/DFonts/WideLatin.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/WideLatin.ttf"
		then
			echo Error copying "$2/DFonts/WideLatin.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/WideLatin.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/WideLatin.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EngraversMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/EngraversMT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/EngraversMT.ttf"
		then
			echo Error copying "$2/DFonts/EngraversMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EngraversMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EngraversMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryob.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryob.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/meiryob.ttc"
		then
			echo Error copying "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryob.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Book Antiqua Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyh.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyh.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/msyh.ttc"
		then
			echo Error copying "$2/DFonts/msyh.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyh.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyh.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Rockwell Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tungab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tungab.TTF" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tungab.TTF"
		then
			echo Error copying "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tungab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbd.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/timesbd.ttf"
		then
			echo Error copying "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsaz.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/angsaz.ttf"
		then
			echo Error copying "$2/DFonts/angsaz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsaz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgunbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgunbd.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/malgunbd.ttf"
		then
			echo Error copying "$2/DFonts/malgunbd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgunbd.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgunbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century.ttf"
		then
			echo Error copying "$2/DFonts/Century.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Console.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Console.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Lucida Console.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Console.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Console.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Console.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EngraversMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/EngraversMTBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/EngraversMTBold.ttf"
		then
			echo Error copying "$2/DFonts/EngraversMTBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EngraversMTBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EngraversMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Haettenschweiler.ttf"
	then
		if ! $ditto_command "$2/DFonts/Haettenschweiler.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Haettenschweiler.ttf"
		then
			echo Error copying "$2/DFonts/Haettenschweiler.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Haettenschweiler.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Haettenschweiler.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibriz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibriz.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Calibriz.ttf"
		then
			echo Error copying "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibriz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century Gothic Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguihis.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguihis.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/seguihis.ttf"
		then
			echo Error copying "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguihis.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Goudy Old Style.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Narrow-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesi.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/timesi.ttf"
		then
			echo Error copying "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Bookman Old Style Bold.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 3.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 3.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Wingdings 3.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 3.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightDemibold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightDemibold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaBrightDemibold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightDemibold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightDemibold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightDemibold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 2.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 2.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Wingdings 2.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 2.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Goudy Old Style Bold.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibril.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibril.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/calibril.ttf"
		then
			echo Error copying "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibril.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STXINGKA.ttf"
	then
		if ! $ditto_command "$2/DFonts/STXINGKA.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/STXINGKA.ttf"
		then
			echo Error copying "$2/DFonts/STXINGKA.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STXINGKA.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STXINGKA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Narrow-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Black.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consola.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Consola.ttf"
		then
			echo Error copying "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gill Sans MT Ext Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Ext Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century Schoolbook Bold.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialNarrowBoldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialNarrowBoldItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ArialNarrowBoldItalic.ttf"
		then
			echo Error copying "$2/DFonts/ArialNarrowBoldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialNarrowBoldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialNarrowBoldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Display-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/monbaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/monbaiti.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/monbaiti.ttf"
		then
			echo Error copying "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/monbaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothM.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothM.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/YuGothM.ttc"
		then
			echo Error copying "$2/DFonts/YuGothM.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothM.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothM.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Demibold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Demibold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Lucida Sans Demibold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Demibold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Demibold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Demibold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbeli.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbeli.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Corbeli.ttf"
		then
			echo Error copying "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbeli.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARA.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARA.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/GARA.ttf"
		then
			echo Error copying "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABD.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABD.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/GARABD.ttf"
		then
			echo Error copying "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CurlzMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/CurlzMT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/CurlzMT.ttf"
		then
			echo Error copying "$2/DFonts/CurlzMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CurlzMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CurlzMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msmincho.ttc"
	then
		if ! $ditto_command "$2/DFonts/msmincho.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/msmincho.ttc"
		then
			echo Error copying "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msmincho.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Goudy Old Style Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Goudy Old Style Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Goudy Old Style Italic.ttf"
		then
			echo Error copying "$2/DFonts/Goudy Old Style Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Goudy Old Style Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Goudy Old Style Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsa.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsa.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/angsa.ttf"
		then
			echo Error copying "$2/DFonts/angsa.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsa.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsa.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/gulim.ttc"
	then
		if ! $ditto_command "$2/DFonts/gulim.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/gulim.ttc"
		then
			echo Error copying "$2/DFonts/gulim.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/gulim.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/gulim.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lathab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lathab.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Lathab.ttf"
		then
			echo Error copying "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lathab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothL.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothL.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/YuGothL.ttc"
		then
			echo Error copying "$2/DFonts/YuGothL.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothL.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothL.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candara.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candara.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Candara.ttf"
		then
			echo Error copying "$2/DFonts/Candara.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candara.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candara.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/angsab.ttf"
	then
		if ! $ditto_command "$2/DFonts/angsab.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/angsab.ttf"
		then
			echo Error copying "$2/DFonts/angsab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/angsab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/angsab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MTEXTRA.ttf"
	then
		if ! $ditto_command "$2/DFonts/MTEXTRA.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MTEXTRA.ttf"
		then
			echo Error copying "$2/DFonts/MTEXTRA.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MTEXTRA.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MTEXTRA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tunga.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tunga.TTF" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tunga.TTF"
		then
			echo Error copying "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tunga.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Deng.ttf"
	then
		if ! $ditto_command "$2/DFonts/Deng.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Deng.ttf"
		then
			echo Error copying "$2/DFonts/Deng.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Deng.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Deng.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBrightItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBrightItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaBrightItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBrightItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBrightItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBrightItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/thsarabun.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/HGRSMP.ttf"
	then
		if ! $ditto_command "$2/DFonts/HGRSMP.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/HGRSMP.ttf"
		then
			echo Error copying "$2/DFonts/HGRSMP.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/HGRSMP.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/HGRSMP.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Titling MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Titling MT Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Perpetua Titling MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Titling MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Titling MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Titling MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/TaiLeb.ttf"
	then
		if ! $ditto_command "$2/DFonts/TaiLeb.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/TaiLeb.ttf"
		then
			echo Error copying "$2/DFonts/TaiLeb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/TaiLeb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/TaiLeb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Medium.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Medium.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Medium.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Medium.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Medium.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Medium.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Rockwell Italic.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/batang.ttc"
	then
		if ! $ditto_command "$2/DFonts/batang.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/batang.ttc"
		then
			echo Error copying "$2/DFonts/batang.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/batang.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/batang.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Braggadocio.ttf"
	then
		if ! $ditto_command "$2/DFonts/Braggadocio.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Braggadocio.ttf"
		then
			echo Error copying "$2/DFonts/Braggadocio.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Braggadocio.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Braggadocio.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Unicode.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Unicode.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Lucida Sans Unicode.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Unicode.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Unicode.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Unicode.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaCalligraphyItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaCalligraphyItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaCalligraphyItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaCalligraphyItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaCalligraphyItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaCalligraphyItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbi.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/timesbi.ttf"
		then
			echo Error copying "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MSJHBD.ttf"
	then
		if ! $ditto_command "$2/DFonts/MSJHBD.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MSJHBD.ttf"
		then
			echo Error copying "$2/DFonts/MSJHBD.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MSJHBD.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MSJHBD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos.ttf"
		then
			echo Error copying "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrib.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Calibrib.ttf"
		then
			echo Error copying "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Light.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arial.ttf"
	then
		if ! $ditto_command "$2/DFonts/arial.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/arial.ttf"
		then
			echo Error copying "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arial.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariblk.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariblk.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ariblk.ttf"
		then
			echo Error copying "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariblk.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/KinoMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/KinoMT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/KinoMT.ttf"
		then
			echo Error copying "$2/DFonts/KinoMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/KinoMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/KinoMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Rockwell.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Condensed Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Rockwell Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Condensed Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Condensed Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-ExtraBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Heavy.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Heavy.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Heavy.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Heavy.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Heavy.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Heavy.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STHUPO.ttf"
	then
		if ! $ditto_command "$2/DFonts/STHUPO.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/STHUPO.ttf"
		then
			echo Error copying "$2/DFonts/STHUPO.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STHUPO.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STHUPO.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Book Antiqua.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MangalB.ttf"
	then
		if ! $ditto_command "$2/DFonts/MangalB.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MangalB.ttf"
		then
			echo Error copying "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MangalB.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yumindb.ttf"
	then
		if ! $ditto_command "$2/DFonts/yumindb.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/yumindb.ttf"
		then
			echo Error copying "$2/DFonts/yumindb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yumindb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yumindb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMTBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/BellMTBold.ttf"
		then
			echo Error copying "$2/DFonts/BellMTBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMTBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaSansTypewriterBold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Book.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Book.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Book.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Book.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Book.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Book.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century Schoolbook Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Black-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Narrow-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MSJH.ttf"
	then
		if ! $ditto_command "$2/DFonts/MSJH.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MSJH.ttf"
		then
			echo Error copying "$2/DFonts/MSJH.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MSJH.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MSJH.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/BellMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/BellMT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/BellMT.ttf"
		then
			echo Error copying "$2/DFonts/BellMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/BellMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/BellMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryo.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryo.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/meiryo.ttc"
		then
			echo Error copying "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryo.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliu.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliu.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/mingliu.ttc"
		then
			echo Error copying "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliu.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palabi.ttf"
	then
		if ! $ditto_command "$2/DFonts/palabi.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/palabi.ttf"
		then
			echo Error copying "$2/DFonts/palabi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palabi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palabi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constan.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constan.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Constan.ttf"
		then
			echo Error copying "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constan.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tw Cen MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaHandwritingItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaHandwritingItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaHandwritingItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaHandwritingItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaHandwritingItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaHandwritingItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tw Cen MT Condensed Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliub.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliub.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/mingliub.ttc"
		then
			echo Error copying "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliub.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold-italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/thsarabun-bold-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/thsarabun-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Perpetua.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bookman Old Style Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bookman Old Style Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Bookman Old Style Italic.ttf"
		then
			echo Error copying "$2/DFonts/Bookman Old Style Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bookman Old Style Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bookman Old Style Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/taile.ttf"
	then
		if ! $ditto_command "$2/DFonts/taile.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/taile.ttf"
		then
			echo Error copying "$2/DFonts/taile.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/taile.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/taile.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ArialRoundedMTBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/ArialRoundedMTBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ArialRoundedMTBold.ttf"
		then
			echo Error copying "$2/DFonts/ArialRoundedMTBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ArialRoundedMTBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ArialRoundedMTBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mmrtextb.ttf"
	then
		if ! $ditto_command "$2/DFonts/mmrtextb.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/mmrtextb.ttf"
		then
			echo Error copying "$2/DFonts/mmrtextb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mmrtextb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mmrtextb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-Display.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelz.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Corbelz.ttf"
		then
			echo Error copying "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-ExtraBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABDIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABDIT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/GARABDIT.ttf"
		then
			echo Error copying "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABDIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Wingdings.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyhbd.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyhbd.ttc" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/msyhbd.ttc"
		then
			echo Error copying "$2/DFonts/msyhbd.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyhbd.ttc" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyhbd.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gill Sans MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahoma.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahoma.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/tahoma.ttf"
		then
			echo Error copying "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahoma.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/himalaya.ttf"
	then
		if ! $ditto_command "$2/DFonts/himalaya.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/himalaya.ttf"
		then
			echo Error copying "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/himalaya.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/FootlightMTLight.ttf"
	then
		if ! $ditto_command "$2/DFonts/FootlightMTLight.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/FootlightMTLight.ttf"
		then
			echo Error copying "$2/DFonts/FootlightMTLight.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/FootlightMTLight.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/FootlightMTLight.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MS Reference Sans Serif.ttf"
	then
		if ! $ditto_command "$2/DFonts/MS Reference Sans Serif.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MS Reference Sans Serif.ttf"
		then
			echo Error copying "$2/DFonts/MS Reference Sans Serif.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MS Reference Sans Serif.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MS Reference Sans Serif.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tw Cen MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Verdana Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Verdana Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Heavy Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Heavy Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Heavy Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Heavy Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Heavy Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Heavy Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Onyx.ttf"
	then
		if ! $ditto_command "$2/DFonts/Onyx.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Onyx.ttf"
		then
			echo Error copying "$2/DFonts/Onyx.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Onyx.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Onyx.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Segoe Script Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Segoe Script Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Segoe Script Bold.ttf"
		then
			echo Error copying "$2/DFonts/Segoe Script Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Segoe Script Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Segoe Script Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxDemibold.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxDemibold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaFaxDemibold.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxDemibold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxDemibold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxDemibold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MaturaMTScriptCapitals.ttf"
	then
		if ! $ditto_command "$2/DFonts/MaturaMTScriptCapitals.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MaturaMTScriptCapitals.ttf"
		then
			echo Error copying "$2/DFonts/MaturaMTScriptCapitals.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MaturaMTScriptCapitals.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MaturaMTScriptCapitals.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariali.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariali.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ariali.ttf"
		then
			echo Error copying "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariali.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ColonnaMT.ttf"
	then
		if ! $ditto_command "$2/DFonts/ColonnaMT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ColonnaMT.ttf"
		then
			echo Error copying "$2/DFonts/ColonnaMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ColonnaMT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ColonnaMT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/News Gothic MT.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/palai.ttf"
	then
		if ! $ditto_command "$2/DFonts/palai.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/palai.ttf"
		then
			echo Error copying "$2/DFonts/palai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/palai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/palai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriai.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Cambriai.ttf"
		then
			echo Error copying "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterRegular.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterRegular.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaSansTypewriterRegular.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterRegular.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterRegular.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterRegular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanb.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Constanb.ttf"
		then
			echo Error copying "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Harrington.ttf"
	then
		if ! $ditto_command "$2/DFonts/Harrington.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Harrington.ttf"
		then
			echo Error copying "$2/DFonts/Harrington.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Harrington.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Harrington.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gill Sans MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Book Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Book Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Book Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Book Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Book Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Book Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STZHONGS.ttf"
	then
		if ! $ditto_command "$2/DFonts/STZHONGS.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/STZHONGS.ttf"
		then
			echo Error copying "$2/DFonts/STZHONGS.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STZHONGS.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STZHONGS.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Mistral.ttf"
	then
		if ! $ditto_command "$2/DFonts/Mistral.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Mistral.ttf"
		then
			echo Error copying "$2/DFonts/Mistral.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Mistral.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Mistral.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tw Cen MT Condensed.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARAIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARAIT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/GARAIT.ttf"
		then
			echo Error copying "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARAIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartika.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartika.TTF" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Kartika.TTF"
		then
			echo Error copying "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartika.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ntailu.ttf"
	then
		if ! $ditto_command "$2/DFonts/ntailu.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ntailu.ttf"
		then
			echo Error copying "$2/DFonts/ntailu.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ntailu.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ntailu.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/News Gothic MT Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candarab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candarab.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Candarab.ttf"
		then
			echo Error copying "$2/DFonts/Candarab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candarab.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candarab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ImprintMTShadow.ttf"
	then
		if ! $ditto_command "$2/DFonts/ImprintMTShadow.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/ImprintMTShadow.ttf"
		then
			echo Error copying "$2/DFonts/ImprintMTShadow.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ImprintMTShadow.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ImprintMTShadow.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Calisto MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolaz.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Consolaz.ttf"
		then
			echo Error copying "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/thsarabun-bold.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaSansTypewriterBoldOblique.ttf"
		then
			echo Error copying "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaSansTypewriterBoldOblique.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/david.ttf"
	then
		if ! $ditto_command "$2/DFonts/david.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/david.ttf"
		then
			echo Error copying "$2/DFonts/david.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/david.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/david.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaBright.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaBright.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaBright.ttf"
		then
			echo Error copying "$2/DFonts/LucidaBright.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaBright.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaBright.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Calisto MT.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Eurostile Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Eurostile Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Eurostile Bold.ttf"
		then
			echo Error copying "$2/DFonts/Eurostile Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Eurostile Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Eurostile Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/STXINWEI.ttf"
	then
		if ! $ditto_command "$2/DFonts/STXINWEI.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/STXINWEI.ttf"
		then
			echo Error copying "$2/DFonts/STXINWEI.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/STXINWEI.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/STXINWEI.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MonotypeSorts.ttf"
	then
		if ! $ditto_command "$2/DFonts/MonotypeSorts.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MonotypeSorts.ttf"
		then
			echo Error copying "$2/DFonts/MonotypeSorts.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MonotypeSorts.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MonotypeSorts.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Desdemona.ttf"
	then
		if ! $ditto_command "$2/DFonts/Desdemona.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Desdemona.ttf"
		then
			echo Error copying "$2/DFonts/Desdemona.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Desdemona.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Desdemona.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolai.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Consolai.ttf"
		then
			echo Error copying "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/LucidaFaxDemiboldItalic.ttf"
	then
		if ! $ditto_command "$2/DFonts/LucidaFaxDemiboldItalic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/LucidaFaxDemiboldItalic.ttf"
		then
			echo Error copying "$2/DFonts/LucidaFaxDemiboldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/LucidaFaxDemiboldItalic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/LucidaFaxDemiboldItalic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Lucida Sans.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Aptos-SemiBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Light.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Dubai-Light.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Rockwell Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Rockwell Bold Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Rockwell Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Rockwell Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Rockwell Bold Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Rockwell Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mangal.ttf"
	then
		if ! $ditto_command "$2/DFonts/mangal.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/mangal.ttf"
		then
			echo Error copying "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mangal.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Eurostile.ttf"
	then
		if ! $ditto_command "$2/DFonts/Eurostile.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Eurostile.ttf"
		then
			echo Error copying "$2/DFonts/Eurostile.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Eurostile.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Eurostile.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/latha.ttf"
	then
		if ! $ditto_command "$2/DFonts/latha.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/latha.ttf"
		then
			echo Error copying "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/latha.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dengl.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dengl.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Dengl.ttf"
		then
			echo Error copying "$2/DFonts/Dengl.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dengl.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dengl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautamib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gautamib.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gautamib.ttf"
		then
			echo Error copying "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautamib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/EdwardianScriptITC.ttf"
	then
		if ! $ditto_command "$2/DFonts/EdwardianScriptITC.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/EdwardianScriptITC.ttf"
		then
			echo Error copying "$2/DFonts/EdwardianScriptITC.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/EdwardianScriptITC.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/EdwardianScriptITC.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbi.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/arialbi.ttf"
		then
			echo Error copying "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Book Antiqua Bold.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Century Gothic Bold.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/News Gothic MT Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/News Gothic MT Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/News Gothic MT Italic.ttf"
		then
			echo Error copying "$2/DFonts/News Gothic MT Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/News Gothic MT Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/News Gothic MT Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriaz.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Cambriaz.ttf"
		then
			echo Error copying "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gill Sans MT.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gill Sans MT.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Gill Sans MT.ttf"
		then
			echo Error copying "$2/DFonts/Gill Sans MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gill Sans MT.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gill Sans MT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibri.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibri.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Calibri.ttf"
		then
			echo Error copying "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibri.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lucida Sans Demibold Roman.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lucida Sans Demibold Roman.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Lucida Sans Demibold Roman.ttf"
		then
			echo Error copying "$2/DFonts/Lucida Sans Demibold Roman.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lucida Sans Demibold Roman.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lucida Sans Demibold Roman.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Demi Italic.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Tw Cen MT Condensed Extra Bold.ttf"
		then
			echo Error copying "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tw Cen MT Condensed Extra Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MonotypeCorsiva.ttf"
	then
		if ! $ditto_command "$2/DFonts/MonotypeCorsiva.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/MonotypeCorsiva.ttf"
		then
			echo Error copying "$2/DFonts/MonotypeCorsiva.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MonotypeCorsiva.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MonotypeCorsiva.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgun.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgun.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/malgun.ttf"
		then
			echo Error copying "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibrili.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibrili.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/calibrili.ttf"
		then
			echo Error copying "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibrili.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/AbadiMTCondensedExtraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/AbadiMTCondensedExtraBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/AbadiMTCondensedExtraBold.ttf"
		then
			echo Error copying "$2/DFonts/AbadiMTCondensedExtraBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/AbadiMTCondensedExtraBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/AbadiMTCondensedExtraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Franklin Gothic Demi.ttf"
	then
		if ! $ditto_command "$2/DFonts/Franklin Gothic Demi.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Franklin Gothic Demi.ttf"
		then
			echo Error copying "$2/DFonts/Franklin Gothic Demi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Franklin Gothic Demi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Franklin Gothic Demi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Book Antiqua Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Book Antiqua Italic.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Book Antiqua Italic.ttf"
		then
			echo Error copying "$2/DFonts/Book Antiqua Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Book Antiqua Italic.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Book Antiqua Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/CopperplateGothicBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/CopperplateGothicBold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/CopperplateGothicBold.ttf"
		then
			echo Error copying "$2/DFonts/CopperplateGothicBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/CopperplateGothicBold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/CopperplateGothicBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyi.ttf"
	then
		if ! $ditto_command "$2/DFonts/msyi.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/msyi.ttf"
		then
			echo Error copying "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Verdana.ttf"
	then
		if ! $ditto_command "$2/DFonts/Verdana.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Verdana.ttf"
		then
			echo Error copying "$2/DFonts/Verdana.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Verdana.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Verdana.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Dubai-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Bauhaus93.ttf"
	then
		if ! $ditto_command "$2/DFonts/Bauhaus93.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Bauhaus93.ttf"
		then
			echo Error copying "$2/DFonts/Bauhaus93.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Bauhaus93.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Bauhaus93.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calisto MT Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calisto MT Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Calisto MT Bold.ttf"
		then
			echo Error copying "$2/DFonts/Calisto MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calisto MT Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calisto MT Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartikab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartikab.TTF" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Kartikab.TTF"
		then
			echo Error copying "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartikab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Perpetua Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Perpetua Bold.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/Perpetua Bold.ttf"
		then
			echo Error copying "$2/DFonts/Perpetua Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Perpetua Bold.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Perpetua Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/nyala.ttf"
	then
		if ! $ditto_command "$2/DFonts/nyala.ttf" "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts/nyala.ttf"
		then
			echo Error copying "$2/DFonts/nyala.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/nyala.ttf" to "$3/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/nyala.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	echo Finished installing files. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
fi

echo Ending "/Applications/Microsoft PowerPoint.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

echo Beginning "/Applications/Microsoft OneNote.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

payload_version="16.77.23091003"

ditto_command=(/usr/bin/ditto)
autoload is-at-least
if is-at-least 14.0 $(/usr/bin/sw_vers -productVersion); then
	ditto_command=(/usr/bin/ditto --clone)
fi

INSTALL_FILES=0
install_path_bundle_info_plist_path="$3/Applications/Microsoft OneNote.app/Contents/Info.plist"
if ! /bin/test -e "$install_path_bundle_info_plist_path"
then
	echo Not installing files because bundle Info.plist $install_path_bundle_info_plist_path does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
else
	installed_version="`/usr/bin/defaults read "$install_path_bundle_info_plist_path" CFBundleVersion`"
	echo Comparing installed version "$installed_version" with payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
	versions_array=(`printf "$installed_version\n$payload_version\n" | sort -n -t .`)
	if [ "$payload_version" = "$installed_version" ]
	then
		INSTALL_FILES=1
	else
		if [ "$payload_version" = "${versions_array[1]}" ]
		then
			echo Not installing files because installed version "$installed_version" is greater than payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		else
			INSTALL_FILES=1
		fi
	fi
fi

if [ $INSTALL_FILES -eq 1 ]
then
	echo Installing files... >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

	if /bin/test -e "$2/DFonts/webdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/webdings.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/webdings.ttf"
		then
			echo Error copying "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/webdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candarai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candarai.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Candarai.ttf"
		then
			echo Error copying "$2/DFonts/Candarai.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candarai.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candarai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambria.ttc"
	then
		if ! $ditto_command "$2/DFonts/Cambria.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Cambria.ttc"
		then
			echo Error copying "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambria.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constani.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constani.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Constani.ttf"
		then
			echo Error copying "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constani.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriab.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Cambriab.ttf"
		then
			echo Error copying "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Medium.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Medium.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Dubai-Medium.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Medium.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbd.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/arialbd.ttf"
		then
			echo Error copying "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/symbol.ttf"
	then
		if ! $ditto_command "$2/DFonts/symbol.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/symbol.ttf"
		then
			echo Error copying "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/symbol.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Narrow.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguisym.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguisym.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/seguisym.ttf"
		then
			echo Error copying "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguisym.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Fangsong.ttf"
	then
		if ! $ditto_command "$2/DFonts/Fangsong.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Fangsong.ttf"
		then
			echo Error copying "$2/DFonts/Fangsong.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Fangsong.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Fangsong.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gabriola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gabriola.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Gabriola.ttf"
		then
			echo Error copying "$2/DFonts/Gabriola.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gabriola.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gabriola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/Kaiti.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Kaiti.ttf"
		then
			echo Error copying "$2/DFonts/Kaiti.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kaiti.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Regular.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Regular.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Dubai-Regular.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Regular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Display-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanz.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Constanz.ttf"
		then
			echo Error copying "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Light-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbel.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbel.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Corbel.ttf"
		then
			echo Error copying "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbel.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candaraz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candaraz.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Candaraz.ttf"
		then
			echo Error copying "$2/DFonts/Candaraz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candaraz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candaraz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Display-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolab.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Consolab.ttf"
		then
			echo Error copying "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyhl.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyhl.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/msyhl.ttc"
		then
			echo Error copying "$2/DFonts/msyhl.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyhl.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyhl.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/SimHei.ttf"
	then
		if ! $ditto_command "$2/DFonts/SimHei.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/SimHei.ttf"
		then
			echo Error copying "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/SimHei.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ONAppleIcon.ttf"
	then
		if ! $ditto_command "$2/DFonts/ONAppleIcon.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/ONAppleIcon.ttf"
		then
			echo Error copying "$2/DFonts/ONAppleIcon.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ONAppleIcon.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ONAppleIcon.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautami.TTF"
	then
		if ! $ditto_command "$2/DFonts/Gautami.TTF" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Gautami.TTF"
		then
			echo Error copying "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautami.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrii.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrii.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Calibrii.ttf"
		then
			echo Error copying "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrii.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msgothic.ttc"
	then
		if ! $ditto_command "$2/DFonts/msgothic.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/msgothic.ttc"
		then
			echo Error copying "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msgothic.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothR.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothR.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/YuGothR.ttc"
		then
			echo Error copying "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothR.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahomabd.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahomabd.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/tahomabd.ttf"
		then
			echo Error copying "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahomabd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-SemiBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/times.ttf"
	then
		if ! $ditto_command "$2/DFonts/times.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/times.ttf"
		then
			echo Error copying "$2/DFonts/times.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/times.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/times.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelb.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Corbelb.ttf"
		then
			echo Error copying "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Simsun.ttc"
	then
		if ! $ditto_command "$2/DFonts/Simsun.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Simsun.ttc"
		then
			echo Error copying "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Simsun.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothB.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothB.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/YuGothB.ttc"
		then
			echo Error copying "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothB.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryob.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryob.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/meiryob.ttc"
		then
			echo Error copying "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryob.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyh.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyh.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/msyh.ttc"
		then
			echo Error copying "$2/DFonts/msyh.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyh.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyh.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tungab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tungab.TTF" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Tungab.TTF"
		then
			echo Error copying "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tungab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbd.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/timesbd.ttf"
		then
			echo Error copying "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgunbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgunbd.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/malgunbd.ttf"
		then
			echo Error copying "$2/DFonts/malgunbd.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgunbd.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgunbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibriz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibriz.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Calibriz.ttf"
		then
			echo Error copying "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibriz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguihis.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguihis.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/seguihis.ttf"
		then
			echo Error copying "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguihis.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Narrow-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesi.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/timesi.ttf"
		then
			echo Error copying "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 3.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 3.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Wingdings 3.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 3.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 2.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 2.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Wingdings 2.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 2.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibril.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibril.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/calibril.ttf"
		then
			echo Error copying "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibril.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Narrow-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Black.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consola.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Consola.ttf"
		then
			echo Error copying "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Display-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/monbaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/monbaiti.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/monbaiti.ttf"
		then
			echo Error copying "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/monbaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbeli.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbeli.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Corbeli.ttf"
		then
			echo Error copying "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbeli.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARA.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARA.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/GARA.ttf"
		then
			echo Error copying "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABD.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABD.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/GARABD.ttf"
		then
			echo Error copying "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msmincho.ttc"
	then
		if ! $ditto_command "$2/DFonts/msmincho.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/msmincho.ttc"
		then
			echo Error copying "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msmincho.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/gulim.ttc"
	then
		if ! $ditto_command "$2/DFonts/gulim.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/gulim.ttc"
		then
			echo Error copying "$2/DFonts/gulim.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/gulim.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/gulim.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lathab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lathab.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Lathab.ttf"
		then
			echo Error copying "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lathab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candara.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candara.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Candara.ttf"
		then
			echo Error copying "$2/DFonts/Candara.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candara.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candara.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MTEXTRA.ttf"
	then
		if ! $ditto_command "$2/DFonts/MTEXTRA.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/MTEXTRA.ttf"
		then
			echo Error copying "$2/DFonts/MTEXTRA.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MTEXTRA.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MTEXTRA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tunga.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tunga.TTF" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Tunga.TTF"
		then
			echo Error copying "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tunga.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/thsarabun.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/leeluisl.ttf"
	then
		if ! $ditto_command "$2/DFonts/leeluisl.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/leeluisl.ttf"
		then
			echo Error copying "$2/DFonts/leeluisl.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/leeluisl.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/leeluisl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/batang.ttc"
	then
		if ! $ditto_command "$2/DFonts/batang.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/batang.ttc"
		then
			echo Error copying "$2/DFonts/batang.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/batang.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/batang.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbi.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/timesbi.ttf"
		then
			echo Error copying "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MSJHBD.ttf"
	then
		if ! $ditto_command "$2/DFonts/MSJHBD.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/MSJHBD.ttf"
		then
			echo Error copying "$2/DFonts/MSJHBD.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MSJHBD.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MSJHBD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos.ttf"
		then
			echo Error copying "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Leelawui.ttf"
	then
		if ! $ditto_command "$2/DFonts/Leelawui.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Leelawui.ttf"
		then
			echo Error copying "$2/DFonts/Leelawui.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Leelawui.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Leelawui.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrib.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Calibrib.ttf"
		then
			echo Error copying "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Light.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arial.ttf"
	then
		if ! $ditto_command "$2/DFonts/arial.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/arial.ttf"
		then
			echo Error copying "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arial.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariblk.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariblk.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/ariblk.ttf"
		then
			echo Error copying "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariblk.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-ExtraBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MangalB.ttf"
	then
		if ! $ditto_command "$2/DFonts/MangalB.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/MangalB.ttf"
		then
			echo Error copying "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MangalB.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Black-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Nirmala.ttf"
	then
		if ! $ditto_command "$2/DFonts/Nirmala.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Nirmala.ttf"
		then
			echo Error copying "$2/DFonts/Nirmala.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Nirmala.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Nirmala.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Narrow-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MSJH.ttf"
	then
		if ! $ditto_command "$2/DFonts/MSJH.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/MSJH.ttf"
		then
			echo Error copying "$2/DFonts/MSJH.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MSJH.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MSJH.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryo.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryo.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/meiryo.ttc"
		then
			echo Error copying "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryo.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliu.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliu.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/mingliu.ttc"
		then
			echo Error copying "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliu.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constan.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constan.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Constan.ttf"
		then
			echo Error copying "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constan.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliub.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliub.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/mingliub.ttc"
		then
			echo Error copying "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliub.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold-italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/thsarabun-bold-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-italic.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/thsarabun-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-Display.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelz.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Corbelz.ttf"
		then
			echo Error copying "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-ExtraBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABDIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABDIT.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/GARABDIT.ttf"
		then
			echo Error copying "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABDIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Wingdings.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyhbd.ttc"
	then
		if ! $ditto_command "$2/DFonts/msyhbd.ttc" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/msyhbd.ttc"
		then
			echo Error copying "$2/DFonts/msyhbd.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyhbd.ttc" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyhbd.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahoma.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahoma.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/tahoma.ttf"
		then
			echo Error copying "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahoma.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/himalaya.ttf"
	then
		if ! $ditto_command "$2/DFonts/himalaya.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/himalaya.ttf"
		then
			echo Error copying "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/himalaya.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Nirmalab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Nirmalab.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Nirmalab.ttf"
		then
			echo Error copying "$2/DFonts/Nirmalab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Nirmalab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Nirmalab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariali.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariali.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/ariali.ttf"
		then
			echo Error copying "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariali.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriai.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Cambriai.ttf"
		then
			echo Error copying "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanb.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Constanb.ttf"
		then
			echo Error copying "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARAIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARAIT.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/GARAIT.ttf"
		then
			echo Error copying "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARAIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartika.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartika.TTF" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Kartika.TTF"
		then
			echo Error copying "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartika.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Candarab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Candarab.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Candarab.ttf"
		then
			echo Error copying "$2/DFonts/Candarab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Candarab.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Candarab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolaz.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Consolaz.ttf"
		then
			echo Error copying "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/thsarabun-bold.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolai.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Consolai.ttf"
		then
			echo Error copying "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Aptos-SemiBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Light.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Dubai-Light.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mangal.ttf"
	then
		if ! $ditto_command "$2/DFonts/mangal.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/mangal.ttf"
		then
			echo Error copying "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mangal.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/latha.ttf"
	then
		if ! $ditto_command "$2/DFonts/latha.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/latha.ttf"
		then
			echo Error copying "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/latha.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautamib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gautamib.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Gautamib.ttf"
		then
			echo Error copying "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautamib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Nirmalas.ttf"
	then
		if ! $ditto_command "$2/DFonts/Nirmalas.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Nirmalas.ttf"
		then
			echo Error copying "$2/DFonts/Nirmalas.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Nirmalas.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Nirmalas.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbi.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/arialbi.ttf"
		then
			echo Error copying "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Leelauib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Leelauib.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Leelauib.ttf"
		then
			echo Error copying "$2/DFonts/Leelauib.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Leelauib.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Leelauib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriaz.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Cambriaz.ttf"
		then
			echo Error copying "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibri.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibri.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Calibri.ttf"
		then
			echo Error copying "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibri.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgun.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgun.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/malgun.ttf"
		then
			echo Error copying "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibrili.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibrili.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/calibrili.ttf"
		then
			echo Error copying "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibrili.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyi.ttf"
	then
		if ! $ditto_command "$2/DFonts/msyi.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/msyi.ttf"
		then
			echo Error copying "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Bold.ttf" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Dubai-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartikab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartikab.TTF" "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts/Kartikab.TTF"
		then
			echo Error copying "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft OneNote.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartikab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	echo Finished installing files. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
fi

echo Ending "/Applications/Microsoft OneNote.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

echo Beginning "/Applications/Microsoft Outlook.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

payload_version="16.77.23091003"

ditto_command=(/usr/bin/ditto)
autoload is-at-least
if is-at-least 14.0 $(/usr/bin/sw_vers -productVersion); then
	ditto_command=(/usr/bin/ditto --clone)
fi

INSTALL_FILES=0
install_path_bundle_info_plist_path="$3/Applications/Microsoft Outlook.app/Contents/Info.plist"
if ! /bin/test -e "$install_path_bundle_info_plist_path"
then
	echo Not installing files because bundle Info.plist $install_path_bundle_info_plist_path does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
else
	installed_version="`/usr/bin/defaults read "$install_path_bundle_info_plist_path" CFBundleVersion`"
	echo Comparing installed version "$installed_version" with payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
	versions_array=(`printf "$installed_version\n$payload_version\n" | sort -n -t .`)
	if [ "$payload_version" = "$installed_version" ]
	then
		INSTALL_FILES=1
	else
		if [ "$payload_version" = "${versions_array[1]}" ]
		then
			echo Not installing files because installed version "$installed_version" is greater than payload version "$payload_version". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		else
			INSTALL_FILES=1
		fi
	fi
fi

if [ $INSTALL_FILES -eq 1 ]
then
	echo Installing files... >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

	if /bin/test -e "$2/DFonts/webdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/webdings.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/webdings.ttf"
		then
			echo Error copying "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/webdings.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/webdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dengb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dengb.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Dengb.ttf"
		then
			echo Error copying "$2/DFonts/Dengb.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dengb.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dengb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambria.ttc"
	then
		if ! $ditto_command "$2/DFonts/Cambria.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Cambria.ttc"
		then
			echo Error copying "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambria.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambria.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constani.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constani.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Constani.ttf"
		then
			echo Error copying "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constani.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constani.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriab.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Cambriab.ttf"
		then
			echo Error copying "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriab.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Medium.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Medium.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Dubai-Medium.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Medium.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Medium.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbd.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/arialbd.ttf"
		then
			echo Error copying "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbd.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/symbol.ttf"
	then
		if ! $ditto_command "$2/DFonts/symbol.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/symbol.ttf"
		then
			echo Error copying "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/symbol.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/symbol.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Narrow.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguisym.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguisym.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/seguisym.ttf"
		then
			echo Error copying "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguisym.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguisym.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Regular.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Regular.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Dubai-Regular.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Regular.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Regular.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/yumin.ttf"
	then
		if ! $ditto_command "$2/DFonts/yumin.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/yumin.ttf"
		then
			echo Error copying "$2/DFonts/yumin.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/yumin.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/yumin.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Display-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanz.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Constanz.ttf"
		then
			echo Error copying "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Light-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbel.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbel.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Corbel.ttf"
		then
			echo Error copying "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbel.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbel.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mmrtext.ttf"
	then
		if ! $ditto_command "$2/DFonts/mmrtext.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/mmrtext.ttf"
		then
			echo Error copying "$2/DFonts/mmrtext.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mmrtext.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mmrtext.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Bold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Display-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolab.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Consolab.ttf"
		then
			echo Error copying "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolab.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century Schoolbook.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/SimHei.ttf"
	then
		if ! $ditto_command "$2/DFonts/SimHei.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/SimHei.ttf"
		then
			echo Error copying "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/SimHei.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/SimHei.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century Schoolbook Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautami.TTF"
	then
		if ! $ditto_command "$2/DFonts/Gautami.TTF" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Gautami.TTF"
		then
			echo Error copying "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautami.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautami.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrii.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrii.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Calibrii.ttf"
		then
			echo Error copying "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrii.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrii.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msgothic.ttc"
	then
		if ! $ditto_command "$2/DFonts/msgothic.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/msgothic.ttc"
		then
			echo Error copying "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msgothic.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msgothic.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothR.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothR.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/YuGothR.ttc"
		then
			echo Error copying "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothR.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothR.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahomabd.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahomabd.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/tahomabd.ttf"
		then
			echo Error copying "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahomabd.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahomabd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/davidbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/davidbd.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/davidbd.ttf"
		then
			echo Error copying "$2/DFonts/davidbd.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/davidbd.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/davidbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-SemiBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/times.ttf"
	then
		if ! $ditto_command "$2/DFonts/times.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/times.ttf"
		then
			echo Error copying "$2/DFonts/times.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/times.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/times.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelb.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Corbelb.ttf"
		then
			echo Error copying "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelb.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century Gothic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Simsun.ttc"
	then
		if ! $ditto_command "$2/DFonts/Simsun.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Simsun.ttc"
		then
			echo Error copying "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Simsun.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Simsun.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/cordia.ttc"
	then
		if ! $ditto_command "$2/DFonts/cordia.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/cordia.ttc"
		then
			echo Error copying "$2/DFonts/cordia.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/cordia.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/cordia.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothB.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothB.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/YuGothB.ttc"
		then
			echo Error copying "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothB.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothB.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Bold Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century Gothic Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Bold Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Bold Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryob.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryob.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/meiryob.ttc"
		then
			echo Error copying "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryob.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryob.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tungab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tungab.TTF" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Tungab.TTF"
		then
			echo Error copying "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tungab.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tungab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbd.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbd.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/timesbd.ttf"
		then
			echo Error copying "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbd.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbd.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century.ttf"
		then
			echo Error copying "$2/DFonts/Century.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibriz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibriz.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Calibriz.ttf"
		then
			echo Error copying "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibriz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibriz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century Gothic Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/seguihis.ttf"
	then
		if ! $ditto_command "$2/DFonts/seguihis.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/seguihis.ttf"
		then
			echo Error copying "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/seguihis.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/seguihis.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Narrow-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesi.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/timesi.ttf"
		then
			echo Error copying "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesi.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 3.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 3.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Wingdings 3.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 3.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 3.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings 2.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings 2.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Wingdings 2.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings 2.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings 2.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibril.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibril.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/calibril.ttf"
		then
			echo Error copying "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibril.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibril.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Narrow-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Black.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consola.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consola.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Consola.ttf"
		then
			echo Error copying "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consola.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consola.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Bold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century Schoolbook Bold.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Display-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/monbaiti.ttf"
	then
		if ! $ditto_command "$2/DFonts/monbaiti.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/monbaiti.ttf"
		then
			echo Error copying "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/monbaiti.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/monbaiti.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothM.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothM.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/YuGothM.ttc"
		then
			echo Error copying "$2/DFonts/YuGothM.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothM.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothM.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbeli.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbeli.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Corbeli.ttf"
		then
			echo Error copying "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbeli.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbeli.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARA.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARA.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/GARA.ttf"
		then
			echo Error copying "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARA.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARA.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABD.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABD.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/GARABD.ttf"
		then
			echo Error copying "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABD.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABD.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Bold-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Bold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msmincho.ttc"
	then
		if ! $ditto_command "$2/DFonts/msmincho.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/msmincho.ttc"
		then
			echo Error copying "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msmincho.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msmincho.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Lathab.ttf"
	then
		if ! $ditto_command "$2/DFonts/Lathab.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Lathab.ttf"
		then
			echo Error copying "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Lathab.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Lathab.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/YuGothL.ttc"
	then
		if ! $ditto_command "$2/DFonts/YuGothL.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/YuGothL.ttc"
		then
			echo Error copying "$2/DFonts/YuGothL.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/YuGothL.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/YuGothL.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Tunga.TTF"
	then
		if ! $ditto_command "$2/DFonts/Tunga.TTF" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Tunga.TTF"
		then
			echo Error copying "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Tunga.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Tunga.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Deng.ttf"
	then
		if ! $ditto_command "$2/DFonts/Deng.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Deng.ttf"
		then
			echo Error copying "$2/DFonts/Deng.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Deng.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Deng.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/thsarabun.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/timesbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/timesbi.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/timesbi.ttf"
		then
			echo Error copying "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/timesbi.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/timesbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos.ttf"
		then
			echo Error copying "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibrib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibrib.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Calibrib.ttf"
		then
			echo Error copying "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibrib.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibrib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Light.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Light.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Light.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arial.ttf"
	then
		if ! $ditto_command "$2/DFonts/arial.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/arial.ttf"
		then
			echo Error copying "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arial.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arial.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariblk.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariblk.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/ariblk.ttf"
		then
			echo Error copying "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariblk.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariblk.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-ExtraBold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/MangalB.ttf"
	then
		if ! $ditto_command "$2/DFonts/MangalB.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/MangalB.ttf"
		then
			echo Error copying "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/MangalB.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/MangalB.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Schoolbook Bold Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Schoolbook Bold Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century Schoolbook Bold Italic.ttf"
		then
			echo Error copying "$2/DFonts/Century Schoolbook Bold Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Schoolbook Bold Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Schoolbook Bold Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Black-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Black-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Black-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Black-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Black-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Narrow-Bold-Italic.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Narrow-Bold-Italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/meiryo.ttc"
	then
		if ! $ditto_command "$2/DFonts/meiryo.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/meiryo.ttc"
		then
			echo Error copying "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/meiryo.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/meiryo.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliu.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliu.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/mingliu.ttc"
		then
			echo Error copying "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliu.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliu.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constan.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constan.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Constan.ttf"
		then
			echo Error copying "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constan.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constan.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mingliub.ttc"
	then
		if ! $ditto_command "$2/DFonts/mingliub.ttc" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/mingliub.ttc"
		then
			echo Error copying "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mingliub.ttc" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mingliub.ttc" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold-italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/thsarabun-bold-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold-italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-italic.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-italic.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/thsarabun-italic.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-italic.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-italic.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mmrtextb.ttf"
	then
		if ! $ditto_command "$2/DFonts/mmrtextb.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/mmrtextb.ttf"
		then
			echo Error copying "$2/DFonts/mmrtextb.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mmrtextb.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mmrtextb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-Display.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-Display.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-Display.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-Display.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-Display.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Corbelz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Corbelz.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Corbelz.ttf"
		then
			echo Error copying "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Corbelz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Corbelz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-ExtraBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-ExtraBold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-ExtraBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-ExtraBold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-ExtraBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARABDIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARABDIT.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/GARABDIT.ttf"
		then
			echo Error copying "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARABDIT.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARABDIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Wingdings.ttf"
	then
		if ! $ditto_command "$2/DFonts/Wingdings.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Wingdings.ttf"
		then
			echo Error copying "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Wingdings.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Wingdings.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/tahoma.ttf"
	then
		if ! $ditto_command "$2/DFonts/tahoma.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/tahoma.ttf"
		then
			echo Error copying "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/tahoma.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/tahoma.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/himalaya.ttf"
	then
		if ! $ditto_command "$2/DFonts/himalaya.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/himalaya.ttf"
		then
			echo Error copying "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/himalaya.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/himalaya.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ariali.ttf"
	then
		if ! $ditto_command "$2/DFonts/ariali.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/ariali.ttf"
		then
			echo Error copying "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ariali.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ariali.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriai.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Cambriai.ttf"
		then
			echo Error copying "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriai.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Constanb.ttf"
	then
		if ! $ditto_command "$2/DFonts/Constanb.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Constanb.ttf"
		then
			echo Error copying "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Constanb.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Constanb.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/GARAIT.ttf"
	then
		if ! $ditto_command "$2/DFonts/GARAIT.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/GARAIT.ttf"
		then
			echo Error copying "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/GARAIT.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/GARAIT.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartika.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartika.TTF" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Kartika.TTF"
		then
			echo Error copying "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartika.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartika.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/ntailu.ttf"
	then
		if ! $ditto_command "$2/DFonts/ntailu.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/ntailu.ttf"
		then
			echo Error copying "$2/DFonts/ntailu.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/ntailu.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/ntailu.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolaz.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Consolaz.ttf"
		then
			echo Error copying "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolaz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/thsarabun-bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/thsarabun-bold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/thsarabun-bold.ttf"
		then
			echo Error copying "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/thsarabun-bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/thsarabun-bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/david.ttf"
	then
		if ! $ditto_command "$2/DFonts/david.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/david.ttf"
		then
			echo Error copying "$2/DFonts/david.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/david.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/david.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Consolai.ttf"
	then
		if ! $ditto_command "$2/DFonts/Consolai.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Consolai.ttf"
		then
			echo Error copying "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Consolai.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Consolai.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Aptos-SemiBold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Aptos-SemiBold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Aptos-SemiBold.ttf"
		then
			echo Error copying "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Aptos-SemiBold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Aptos-SemiBold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Light.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Light.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Dubai-Light.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Light.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Light.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/mangal.ttf"
	then
		if ! $ditto_command "$2/DFonts/mangal.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/mangal.ttf"
		then
			echo Error copying "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/mangal.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/mangal.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/latha.ttf"
	then
		if ! $ditto_command "$2/DFonts/latha.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/latha.ttf"
		then
			echo Error copying "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/latha.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/latha.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dengl.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dengl.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Dengl.ttf"
		then
			echo Error copying "$2/DFonts/Dengl.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dengl.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dengl.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Gautamib.ttf"
	then
		if ! $ditto_command "$2/DFonts/Gautamib.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Gautamib.ttf"
		then
			echo Error copying "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Gautamib.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Gautamib.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/arialbi.ttf"
	then
		if ! $ditto_command "$2/DFonts/arialbi.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/arialbi.ttf"
		then
			echo Error copying "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/arialbi.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/arialbi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Century Gothic Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Century Gothic Bold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Century Gothic Bold.ttf"
		then
			echo Error copying "$2/DFonts/Century Gothic Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Century Gothic Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Century Gothic Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Cambriaz.ttf"
	then
		if ! $ditto_command "$2/DFonts/Cambriaz.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Cambriaz.ttf"
		then
			echo Error copying "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Cambriaz.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Cambriaz.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Calibri.ttf"
	then
		if ! $ditto_command "$2/DFonts/Calibri.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Calibri.ttf"
		then
			echo Error copying "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Calibri.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Calibri.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/malgun.ttf"
	then
		if ! $ditto_command "$2/DFonts/malgun.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/malgun.ttf"
		then
			echo Error copying "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/malgun.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/malgun.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/calibrili.ttf"
	then
		if ! $ditto_command "$2/DFonts/calibrili.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/calibrili.ttf"
		then
			echo Error copying "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/calibrili.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/calibrili.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/msyi.ttf"
	then
		if ! $ditto_command "$2/DFonts/msyi.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/msyi.ttf"
		then
			echo Error copying "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/msyi.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/msyi.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Dubai-Bold.ttf"
	then
		if ! $ditto_command "$2/DFonts/Dubai-Bold.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Dubai-Bold.ttf"
		then
			echo Error copying "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Dubai-Bold.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Dubai-Bold.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/Kartikab.TTF"
	then
		if ! $ditto_command "$2/DFonts/Kartikab.TTF" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/Kartikab.TTF"
		then
			echo Error copying "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/Kartikab.TTF" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/Kartikab.TTF" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	if /bin/test -e "$2/DFonts/nyala.ttf"
	then
		if ! $ditto_command "$2/DFonts/nyala.ttf" "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts/nyala.ttf"
		then
			echo Error copying "$2/DFonts/nyala.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
			result=1
		else
			echo Copied "$2/DFonts/nyala.ttf" to "$3/Applications/Microsoft Outlook.app/Contents/Resources/DFonts". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		fi
	else
		echo Installed file "$2/DFonts/nyala.ttf" does not exist. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
		result=1
	fi

	echo Finished installing files. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
fi

echo Ending "/Applications/Microsoft Outlook.app/Contents/Resources/DFonts" section. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log

echo Removing temporary installation directory "$2"... >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
/bin/rm -rf "$2"
if [ $? -ne 0 ]
then
	echo Failed removing temporary installation directory "$2". >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
fi

result2=0
parent_dir="`/usr/bin/dirname "$0"`"
_postinstall="$parent_dir/_postinstall"
if /bin/test -e "$_postinstall"
then
	echo Running "$_postinstall"... >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
	"$_postinstall" "$1" "$2" "$3" "$4"
	result2=$?
	echo Running "$_postinstall" returned $result2. >> /tmp/com.microsoft.package.DFonts.generic.postinstall.log
fi

if [[ $result -ne 0 || $result2 -ne 0 ]]
then
	exit 1
fi

ms_install_log_dir="/Library/Logs/Microsoft/InstallLogs"
/bin/mkdir -p "$ms_install_log_dir"

if /bin/test -d "$ms_install_log_dir"
then
	/bin/mv /tmp/com.microsoft.package.DFonts.generic.postinstall.log "$ms_install_log_dir"
fi
exit 0