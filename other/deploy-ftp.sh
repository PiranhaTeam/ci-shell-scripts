#!/bin/bash
#
# Deploys files to a FTP server.
#
# This script will upload all the files in the current folder into a FTP server.
#
# The connection configuration will be taken from the environmental variables.
#
# --- ENVIRONMENTAL VARIABLES ---
#
# The following environmental variables are required by the script:
# - DEPLOY_USERNAME : string, username for the server
# - DEPLOY_PASSWORD : string, password for the server
# - DEPLOY_HOST : string, host for the server
#
# -- PARAMETERS --
#
# The function expects the following parameters:
# $1: A flow control boolean flag, indicating if the script should be run or not.
#

deploy=${1:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

    echo "Deploying files"

    find . -not -path '*/\.*' -type f -exec curl --user "$DEPLOY_USERNAME:$DEPLOY_PASSWORD" --ftp-create-dirs -T {} "$DEPLOY_HOST{}" \;

else

    echo "Files won't be deployed"

fi
