#!/bin/bash

# Move old stuff to the trash.
function trash()
{	
	if [ -e "$1" ]; then
	
		local dst=${1##*/}
		while [ -e ~/.Trash/"$dst" ]; do
			dst="`expr "$dst" : '\(.*\)\.[^.]*'` `date +%H-%M-%S`.`expr "$dst" : '.*\.\([^.]*\)'`"
		done
      
      	echo ~/.Trash"$dst"
		mv -f "$1" ~/.Trash"/$dst"
	fi
}

trash "/Applications/Moho.app"
