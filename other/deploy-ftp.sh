#!/bin/bash
# This script deploys files to a FTP.

deploy=${1:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

    echo "Deploying files"

    find . -not -path '*/\.*' -type f -exec curl --user "$DEPLOY_USERNAME:$DEPLOY_PASSWORD" --ftp-create-dirs -T {} "$DEPLOY_HOST{}" \;

else

    echo "Files won't be deployed"

fi
