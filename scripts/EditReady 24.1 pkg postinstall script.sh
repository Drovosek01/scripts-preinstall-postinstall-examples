#!/bin/bash

##########################################################
## HEDGE - EditReady post installer script
##
## Created by The Sync Factory in 2023.
## Copyright  2023 The Sync Factory. All rights reserved.
##########################################################

# global vars
SCRIPT_NAME=$(basename "$0")

## FUNCTIONS ##
# logging functions
log() {
	echo "$@"
	logger -p user.notice -t "$SCRIPT_NAME" "$@"
}

err() {
	echo "$@" >&2
	logger -p user.error -t "$SCRIPT_NAME" "$@"
}


##### main program #####
# EditReady requires running once with elevated permissions to correctly handle license management.
sudo /Applications/EditReady.app/Contents/MacOS/EditReady PROTOCOLACTIONSAVEPKEY ""

open "/Applications/EditReady.app"
exit 0