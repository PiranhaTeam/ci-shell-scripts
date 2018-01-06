#!/bin/bash
#
# Runs the tests for a specific profile.
#
# -- PARAMETERS --
#
# The function expects the following parameters:
# $1: A flow control boolean flag, indicating if the script should be run or not.
# $1: A string, containing the profile to run.
#

# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

tests=${1:-}
profile=${2:-}

# Expects a flow control parameter
if [ "${tests}" == "true" ]; then

   if [ -n "${profile}" ]; then
      echo "Using profile ${profile}"
      python setup.py test -p "${profile}"
   else
      python setup.py test
   fi

   exit 0

else

   echo "Tests won't be run"

   exit 0

fi