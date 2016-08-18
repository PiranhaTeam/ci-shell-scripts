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

# deploy=${1:-}
package_name=${2:-}
version=${3:-}
architecture=${4:-}
repo_url=${5:-}

deploy=true

# Expects a flow control parameter
if [ "$deploy" == "true" ]; then

   echo "Deploying Debian package"

   file_name="$package_name_$version_$architecture"
   file_path="../$file_name"

   curl -T "$file_path" -u"$DEPLOY_USER":"$DEPLOY_PASSWORD" -H "X-Bintray-Package:$package_name" -H "X-Bintray-Version:$version" "$repo_url$file_name"

   exit 0

else

   echo "Debian package won't be deployed"

   exit 0

fi