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

tests=${1:-}
profile=${2:-}

if [ "${tests}" == "true" ]; then

    tox -e "${profile}"

   exit 0

else

   echo "Tests won't be run"

   exit 0

fi