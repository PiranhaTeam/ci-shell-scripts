#!/bin/bash
#
# Deploys the Maven site.
#
# Deployment should be done thoughtfully. Make sure everything is ready before
# running this script.
#
# If everything is correct, the deployment will only occur with release or development
# versions. Any pull request, in case the code comes from SCM, will be ignored.
#
# Note that if required the DEPLOY_DOCS environment variable can be used to stop the script
# from running by setting it to 'false'.
#
# The following environmental variables are used:
# - DEPLOY_DOCS: boolean, control flag for deployment, should be true to deploy
# - PULL_REQUEST: boolean, indicates if this is a pull request, should be false for deployment
# - VERSION_TYPE: string, the type of version of the code. One of 'release', 'develop' or 'other'.

set -o nounset
set -e

if [ "$DO_DEPLOY_DOCS" == "true" ]; then

   echo "Deploying Maven site"

   mvn site site:deploy -P deployment --settings ~/settings.xml > site_output.txt

   head -50 site_output.txt
   echo " "
   echo "(...)"
   echo " "
   tail -50 site_output.txt

   exit 0

else

   echo "Maven site won't be deployed"

   exit 0

fi
