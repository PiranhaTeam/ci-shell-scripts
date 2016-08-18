#!/bin/bash
#
# Deploys a Debian file to Bintray.
#
# To increase security it takes authentication data from environmental
# variables, using parameters only for non-sensitive data.
#
# --- ENVIRONMENTAL VARIABLES ---
#
# The following environmental variables are required by the script, but read by Maven:
# - DEPLOY_USER: string, user for the packages repo
# - DEPLOY_PASSWORD: string, password for the packages repo
#

# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

deploy=${1:-}
file_path=${2:-}
deploy_url=${3:-}
distribution=${4:-}
component=${5:-}
architecture=${6:-}

# Expects a flow control parameter
if [ "$deploy" == "true" ]; then

   echo "Deploying Debian package"

   curl -T $file_path -u$DEPLOY_USER:$DEPLOY_PASSWORD $deploy_url;deb_distribution=$distribution;deb_component=$component;deb_architecture=$architecture

   exit 0

else

   echo "Debian package won't be deployed"

   exit 0

fi