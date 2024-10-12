#!/bin/bash
# Some simple functions to be used to "uninstall" the previous version

function DeleteDirectory
{
	for folder in "$@"
	do
		if  [ -d "$folder" ] ; then
			rm -Rdf "$folder"
		fi
	done	
	return 0
}

function DeleteDirectoryIfEmpty
{
	nDirEmpty=0
  DirectoryEmpty "$1" && true || nDirEmpty=1
  if [ $nDirEmpty == 1 ] ; then
  	DeleteDirectory "$1"
  fi
}

function DeleteFile
{
	for file in "$@"
	do
		if  [ -e "$file" ] ; then
			rm -f "$file"
		fi
	done
	return 0
}

function FileExists
{
	if  [ -e $1 ] ; then
		return 0
	fi
	return 1
}

function DirectoryExists
{
	if  [ -d $1 ] ; then
		return 0
	fi
	return 1
}

function DirectoryEmpty
{
	if [ -d "$1" ] ; then 
		if [ -z "$(ls -A "$1")" ] ; then
			return 1
		fi
	fi
	
	return 0
}
