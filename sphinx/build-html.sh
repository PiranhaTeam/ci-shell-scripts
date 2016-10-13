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

deploy=${1:-}
path=${2:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

   echo "Building HTML Sphinx docs"
   cd "$path"
   sphinx-build -b html -d ~/sphinx/build/doctrees source ~/sphinx/build/html

else

   echo "HTML Sphinx docs won't be built"

fi