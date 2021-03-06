#!/bin/bash
#
# Builds HTML files from Sphinx source files.
#
# -- PARAMETERS --
#
# The function expects the following parameters:
# $1: A flow control boolean flag, indicating if the script should be run or not.
# $2: A string, with the path to the Sphinx source files.
#

# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

deploy=${1:-}
path=${2:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

   echo "Building HTML Sphinx docs"
   cd "$path" || exit
   sphinx-build -b html -d ~/sphinx/build/doctrees source ~/sphinx/build/html

else

   echo "HTML Sphinx docs won't be built"

fi