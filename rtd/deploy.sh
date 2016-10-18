#!/bin/bash
#
# Deploys the documentation to Read the Docs (https://readthedocs.org/).
#
# Actually it pings the RTD project, warning it of changes in the project, and triggering
# an update.
#
# Deployment should be done thoughtfully. Make sure everything is ready before
# running this script.
#
# -- PARAMETERS --
#
# The function expects the following parameters:
# $1: A flow control boolean flag, indicating if the script should be run or not.
# $2: A string, with the name of the project to update.
#

# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

deploy=${1:-}
project=${2:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

   echo "Deploying RTD docs"
   curl -X POST http://readthedocs.org/build/"${project}"

else

   echo "RTD docs won't be deployed"

fi