#!/bin/bash
#
# Deploys files to a server through SSH.
#
# This script will upload all the files in the current folder into a server
# using a SSH connection.
#
# The connection configuration will be taken from the environmental variables.
#
# --- ENVIRONMENTAL VARIABLES ---
#
# The following environmental variables are required by the script:
# - DEPLOY_USERNAME : string, username for the server
# - DEPLOY_PASSWORD : string, password for the server
# - DEPLOY_HOST : string, host for the server
# - DEPLOY_PORT : string, port to use for the connection
# - DEPLOY_PATH : string, path inside the server to deploy the files
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

    sshpass -p "$DEPLOY_PASSWORD" scp -o 'StrictHostKeyChecking no' -P "$DEPLOY_PORT" -r ./* "$DEPLOY_USERNAME@$DEPLOY_HOST:$DEPLOY_PATH";

else

    echo "Files won't be deployed"

fi
