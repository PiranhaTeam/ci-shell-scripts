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
# - A comma separated list of profiles, or an empty string for no profile.
#

# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

deploy=${1:-}
profile=${2:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

   echo "Deploying Maven site"

   if [ ! -z "${profile}" ]; then
      mvn site site:deploy -P "${profile}" --settings ~/settings.xml > site_output.txt
   else
      mvn site site:deploy --settings ~/settings.xml > site_output.txt
   fi

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
