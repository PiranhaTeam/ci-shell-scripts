#!/bin/bash
# This script deploys files through SSH.

deploy=${1:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

    echo "Deploying files"

    sshpass -p "$DEPLOY_PASSWORD" scp -P "$DEPLOY_PORT" -r . "$DEPLOY_USERNAME@$DEPLOY_HOST:$DEPLOY_PATH";

else

    echo "Files won't be deployed"

fi
