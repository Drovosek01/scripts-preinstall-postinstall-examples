#!/bin/bash
#
# This postflight script echoes the values of the available 
# arguments and environmental variables.

# $1: full path to the installation package
# $2: full path to the installation destination
# $3: mountpoint of the destination volume
# $4: root directory \"/\" for the current System folder"
# Environment variables available to a postflight executable:
# 	$INSTALLER_TEMP: scratch area used by Installer for temporary work files
# 	$PACKAGE_PATH: full path to the installation package; should be same as $1
# 	$RECEIPT_PATH: full path to directory containing the file being executed
# 	$SCRIPT_NAME: name of the file being executed"
# 	$TMPDIR: if set, a path to a location on a writable destination volume
# 

mkdir "$2""Library/Arturia/Shared"

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

# sqlite : copy to shared only if the version to install is greater than the present version
libsql_new=3.8.12
libsql_old=0.0.0.0

if [ -f "$2""Library/Arturia/Shared/libsqlite_version.info" ]; then
	libsql_old=`cat "$2""Library/Arturia/Shared/libsqlite_version.info"`
fi

if [ $(version $libsql_new) -ge $(version $libsql_old) ] || [! -f "$2""Library/Arturia/Shared/libsqlite.dylib"]; then
	mv "$2""Library/Arturia/Analog Lab V/Shared/libsqlite.dylib" "$2""Library/Arturia/Shared/libsqlite.dylib"
	
	# recreate libsqlite_version.info file to store the new version
	rm -f "$2""Library/Arturia/Shared/libsqlite_version.info"
	echo 3.8.12 > "$2""Library/Arturia/Shared/libsqlite_version.info"
fi

# sndfile : copy to shared only if the version to install is greater than the present version
if [ -f "$2""Library/Arturia/Analog Lab V/Shared/libsndfile-2.dylib" ]; then
	libsndfile_new=1.0.31
	libsndfile_old=0.0.0.0

	if [ -f "$2""Library/Arturia/Shared/libsndfile-2_version.info" ]; then
		libsndfile_old=`cat "$2""Library/Arturia/Shared/libsndfile-2_version.info"`
	fi
	if [ $(version $libsndfile_new) -ge $(version $libsndfile_old) ] || [! -f "$2""Library/Arturia/Shared/libsndfile-2.dylib"]; then 
		mv "$2""Library/Arturia/Analog Lab V/Shared/libsndfile-2.dylib" "$2""Library/Arturia/Shared/libsndfile-2.dylib"
		
		# recreate libsndfile-2_version.info file to store the new version
		rm -f "$2""Library/Arturia/Shared/libsndfile-2_version.info"
		echo 1.0.31 > "$2""Library/Arturia/Shared/libsndfile-2_version.info"
	fi
fi
rm -rf "$2""Library/Arturia/Analog Lab V/Shared"

cd "$2""Library/Arturia/Presets/"

"$2""Library/Arturia/Presets/databaseCreator" -u -p "./Analog Lab V" -i "Analog Lab V" -d "./db.db3"
rm -rf "$2""Library/Arturia/Presets/databaseCreator"

chmod -R 777 "$2""Library/Arturia/Analog Lab V"
chmod -R 777 "$2""Library/Arturia/Presets"
chmod -R 777 "$2""Library/Arturia/Samples"
chmod -R 777 "$2""Library/Arturia/Shared"
chmod -R 777 "$2""Library/Arturia/Presets/Analog Lab V"
chmod 755 "$2""Library/Arturia/Analog Lab V/resources/uninstall.sh"

# Importing concerts from AL4
if [ ! -f "$2""Library/Arturia/Analog Lab V/resources/projects/AL4ConcertsImported.tmp" ]
then
	touch "$2""Library/Arturia/Analog Lab V/resources/projects/AL4ConcertsImported.tmp"

	# Copy and update their extensions
	for f in "$2""Library/Arturia/Analog Lab 4/resources/projects"/*.alconcert; do 
		if [[ ${f:0:1} != "*" ]] ; then 
			fileName=$(basename "$f")
			if [[ $fileName != "Demo Concert.alconcert" ]] ; then
				cp -n -- "$f" "$2""Library/Arturia/Analog Lab V/resources/projects/${fileName%.alconcert}.aplst";
			fi
		fi
	done
fi

exit 0
