#!/bin/sh
#

# Remove Melodyne singletrack binaries
# (incompatible with M4, which is a true upgrade anyways)
# see OT F1074
pkgutil --force --forget com.celemony.melodyne.singletrack
rm -rf "/Applications/Melodyne singletrack"

exit 0
