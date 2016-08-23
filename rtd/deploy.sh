#!/bin/bash
# This script deploys the documentation

deploy=${1:-}
project=${2:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

   echo "Deploying docs"
   curl -X POST http://readthedocs.org/build/"${project}"

else

   echo "Docs won't be deployed"

fi