#!/bin/bash
#
# Function for deploying the project artifact. A flow flag is received, indicating
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
# - A flow boolean flag, indicating if the script should be run or not.
#

set -o nounset
set -e

deploy () {

    if [ "$1" == "true" ]; then

       echo "Deploying Java artifact"

       mvn deploy -P deployment --settings ~/settings.xml

       exit 0

    else

       echo "Java artifact won't be deployed"

       exit 0

    fi

}
