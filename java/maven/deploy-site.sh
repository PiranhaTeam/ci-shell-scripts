#!/bin/bash
#
# Function for deploying the project Maven site. A flow flag is received, indicating
# if the deployment should be done or not.
#
# Deployment should be done thoughtfully. Make sure everything is ready before
# running this script.
#
# If everything is correct, the deployment will only occur with release or development
# versions. Any pull request, in case the code comes from SCM, will be ignored.
#
# Also a settings file will be read from the ~/settings.xml path.
#
# -- PARAMETERS --
#
# The function expects the following parameters:
# - A flow control boolean flag, indicating if the script should be run or not.
#

set -o nounset
set -e

deploy_site () {

    # Expects a flow control parameter
    if [ "$1" == "true" ]; then

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

}
