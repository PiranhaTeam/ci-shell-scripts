#!/bin/bash
#
# Sets up the CI environment for python.
#
# This script handles just the Python specific variables, and should be run
# along the main Travis CI environment script.
#
# Setting environmental variables through a script is not allowed by default
# in Travis. To avoid this problem run this script as part of the parent shell
# commands by using the 'source' command. This is also the reason for not
# returning any value, and for not using the 'set' command.
#
# --- ENVIRONMENTAL VARIABLES ---
#
# The following environmental variables are required by the script:
# - TRAVIS_PYTHON_VERSION : string, Travis variable with the version of Python being used
#
# The following environmental variables will be set by the script:
# - PYTHON_VERSION: string, contains the version of Python being used
# - PYTHON_VERSION_TEST: string, contains the version of Python for testing
#
# The following environmental variables will be set by the script if they don't exist:
#

# Python version to use
PYTHON_VERSION=${TRAVIS_PYTHON_VERSION}

# Python version to use in testing
PYTHON_VERSION_TEST="$(echo py"${PYTHON_VERSION}" | tr -d . | sed -e 's/pypypy/pypy/')"

echo "CI environmental variables set:";
echo "PYTHON_VERSION: ${PYTHON_VERSION}";
echo "PYTHON_VERSION_TEST: ${PYTHON_VERSION_TEST}";
