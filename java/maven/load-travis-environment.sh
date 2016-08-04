#!/bin/bash
#
# Sets up the CI environment.
#
# The script is meant to be run just after the CI process begins, to prepare
# the environmental variables to be used for flow control, for example to
# know if artifacts should be deployed or not.
#
# It is prepared for the Travis CI service, and expects several environmental
# variables which exist by default on Travis environments.
#
# Setting environmental variables through a script is not allowed by default.
# To avoid this problem run this script as part of the parent shell commands
# by using the 'source' command. This is also the reason for not returning any
# value, and for not using the 'set' command.
#
# The following environmental variables are required by the script:
# - TRAVIS_BRANCH: string, Travis variable with the name of the SCM branch from which the code was taken
# - TRAVIS_PULL_REQUEST: boolean, Travis CI flag indicating if this is a pull request
# - DEPLOY: boolean, flag indicating if the artifacts will be deployed
# - DEPLOY_DOCS: boolean, flag indicating if the documents will be deployed
#
# The following environmental variables will be set by the script:
# - VERSION_TYPE: string, indicates if this is a release or development version
# - PULL_REQUEST: boolean, indicates if this is a pull request
#
# The following environmental variables will be set by the script if they don't exist:
# - DEPLOY: boolean, set to a default of false
# - DEPLOY_DOCS: boolean, set to a default of false
#

# Flag to know if this is a pull request
export PULL_REQUEST=$TRAVIS_PULL_REQUEST

# Flag for deploying artifacts
# Defaults to false
if [ -z "$DEPLOY" ]; then
   export DEPLOY=false;
fi

# Flag for deploying documentation
# Defaults to false
if [ -z "$DEPLOY_DOCS" ]; then
   export DEPLOY_DOCS=false;
fi

# Flag to know if this is a release or a development version
if [ "$TRAVIS_BRANCH" == "master" ]; then
   export VERSION_TYPE=release;
elif [ "$TRAVIS_BRANCH" == "develop" ]; then
   export VERSION_TYPE=develop;
else
   export VERSION_TYPE=other;
fi

echo "CI environmental variables set:";
echo "PULL_REQUEST: $PULL_REQUEST";
echo "VERSION_TYPE: $VERSION_TYPE";
echo "DEPLOY: $DEPLOY";
echo "DEPLOY_DOCS: $DEPLOY_DOCS";
