#!/bin/bash
#
# Function for building the documents of a Python project. A flow flag is received,
# indicating if the building should be done or not.
#
# -- PARAMETERS --
#
# The function expects the following parameters:
# $1: A flow control boolean flag, indicating if the script should be run or not.
#

# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

deploy=${1:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

   echo "Building project docs"
   python setup.py build_docs

else

   echo "Project docs won't be built"

fi