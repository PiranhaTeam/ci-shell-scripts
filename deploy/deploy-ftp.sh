#!/bin/bash
#
# Deploys files to a FTP server.
#
# This script will upload all the files in the current folder into a FTP server.
#
# The connection configuration will be set through parameters.
#
# -- PARAMETERS --
#
# The function expects the following parameters:
# $1: A flow control boolean flag, indicating if the script should be run or not.
# $2: username, for deployment server.
# $3: password, for deployment server.
# $4: host, for the server where the files will be deployed.
#

# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

deploy=${1:-}
username=${2:-}
password=${3:-}
host=${4:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

    echo "Deploying files"

    find . -not -path '*/\.*' -type f -exec curl --user "$username:$password" --ftp-create-dirs -T {} "$host{}" \;

else

    echo "Files won't be deployed"

fi
