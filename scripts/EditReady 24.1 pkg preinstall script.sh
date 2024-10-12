#!/bin/bash

##########################################################
## HEDGE - EditReady Pre installer script
##
## Created by The Sync Factory in 2023.
## Copyright  2023 The Sync Factory. All rights reserved.
##########################################################

# Remove current EditReady
if [[ -d "${HOME}/Applications/EditReady.app" ]]; then
    echo "Remove ${HOME}/Applications/EditReady.app"
    rm -rf "${HOME}/Applications/EditReady.app"
fi

if [[ -d "/Applications/EditReady.app" ]]; then
    echo "Remove /Applications/EditReady.app"
    rm -rf "/Applications/EditReady.app"
fi

exit 0
