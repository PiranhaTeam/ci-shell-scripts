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
# --- ENVIRONMENTAL VARIABLES ---
#
# The following environmental variables are required by the script:
# - TRAVIS_BRANCH: string, Travis variable with the name of the SCM branch from which the code was taken
# - TRAVIS_PULL_REQUEST: boolean, Travis CI flag indicating if this is a pull request
#
# The following environmental variables are required by the script but will be set to false if they don't exist:
# - COVERAGE: boolean, flag indicating if a coverage task will be run
# - DEPLOY: boolean, flag indicating if the artifacts will be deployed
# - DEPLOY_DOCS: boolean, flag indicating if the documents will be deployed
# - TEST_DOCS: boolean, flag indicating if the docs will be tested
#
# They will be used as control flags for setting the final environment variables.
#
# The following environmental variables will be set by the script to help generating the final variables:
# - VERSION_TYPE: string, indicates if this is a release or development version
#
# The following environmental variables will be set by the script:
# - DO_DEPLOY: boolean, set to a default of false
# - DO_DEPLOY_RELEASE: boolean, set to a default of false
# - DO_DEPLOY_DEVELOP: boolean, set to a default of false
# - DO_DEPLOY_DOCS: boolean, set to a default of false
# - DO_DEPLOY_DOCS_RELEASE: boolean, set to a default of false
# - DO_DEPLOY_DOCS_DEVELOP: boolean, set to a default of false
# - DO_TEST_DOCS: boolean, set to a default of false
# - DO_COVERAGE: boolean, set to a default of false
#

# Flag to know if this is a pull request
pull_request=${TRAVIS_PULL_REQUEST}

# Flag for testing docs
# Defaults to false
if [ -z "${TEST_DOCS}" ]; then
   export TEST_DOCS=false;
fi

# Flag for test coverage
# Defaults to false
if [ -z "${COVERAGE}" ]; then
   export COVERAGE=false;
fi

# Flag for deploying artifacts
# Defaults to false
if [ -z "${DEPLOY}" ]; then
   export DEPLOY=false;
fi

# Flag for deploying documentation
# Defaults to false
if [ -z "${DEPLOY_DOCS}" ]; then
   export DEPLOY_DOCS=false;
fi

# Flag to know if this is a release or a development version
if [ "${TRAVIS_BRANCH}" == "master" ]; then
   export VERSION_TYPE=release;
elif [ "${TRAVIS_BRANCH}" == "develop" ]; then
   export VERSION_TYPE=develop;
else
   export VERSION_TYPE=other;
fi

# Sets actual documentation testing flag
if [ "${TEST_DOCS}" == "true" ] && [ "${pull_request}" == "false" ] && [ "${VERSION_TYPE}" != "other" ]; then
   export DO_TEST_DOCS=true;
else
   export DO_TEST_DOCS=false;
fi

# Sets actual artifacts deployment flag
if [ "${DEPLOY}" == "true" ] && [ "${pull_request}" == "false" ] && [ "${VERSION_TYPE}" != "other" ]; then
   export DO_DEPLOY=true;

   if [ "${VERSION_TYPE}" == "release" ]; then
      # Release artifacts
      export DO_DEPLOY_RELEASE=true;
      export DO_DEPLOY_DEVELOP=false;
   elif [ "${VERSION_TYPE}" == "develop" ]; then
      # Development artifacts
      export DO_DEPLOY_RELEASE=false;
      export DO_DEPLOY_DEVELOP=true;
   else
      # Unknown version type
      export DO_DEPLOY_RELEASE=false;
      export DO_DEPLOY_DEVELOP=false;
   fi
else
   # Deployment disabled
   echo "Artifacts deployment disabled";
   export DO_DEPLOY=false;
   export DO_DEPLOY_RELEASE=false;
   export DO_DEPLOY_DEVELOP=false;
fi

# Sets actual documentation deployment flag
if [ "${DEPLOY_DOCS}" == "true" ] && [ "${pull_request}" == "false" ] && [ "${VERSION_TYPE}" != "other" ]; then
   export DO_DEPLOY_DOCS=true;

   if [ "${VERSION_TYPE}" == "release" ]; then
      # Release docs
      export DO_DEPLOY_DOCS_RELEASE=true;
      export DO_DEPLOY_DOCS_DEVELOP=false;
   elif [ "${VERSION_TYPE}" == "develop" ]; then
      # Development docs
      export DO_DEPLOY_DOCS_RELEASE=false;
      export DO_DEPLOY_DOCS_DEVELOP=true;
   else
      # Unknown version type
      export DO_DEPLOY_DOCS_RELEASE=false;
      export DO_DEPLOY_DOCS_DEVELOP=false;
   fi
else
   # Deployment disabled
   echo "Docs deployment disabled";
   export DO_DEPLOY_DOCS=false;
   export DO_DEPLOY_DOCS_RELEASE=false;
   export DO_DEPLOY_DOCS_DEVELOP=false;
fi

# Sets actual documentation deployment flag
if [ "${COVERAGE}" == "true" ] && [ "${pull_request}" == "false" ] && [ "${VERSION_TYPE}" != "other" ]; then
   export DO_COVERAGE=true;
else
   # Coverage disabled
   echo "Coverage disabled";
   export DO_COVERAGE=false;
fi

echo "CI environmental variables set:";
echo "VERSION_TYPE: ${VERSION_TYPE}";
echo "DO_DEPLOY: ${DO_DEPLOY}";
echo "DO_DEPLOY_RELEASE: ${DO_DEPLOY_RELEASE}";
echo "DO_DEPLOY_DEVELOP: ${DO_DEPLOY_DEVELOP}";
echo "DO_DEPLOY_DOCS: ${DO_DEPLOY_DOCS}";
echo "DO_DEPLOY_DOCS_RELEASE: ${DO_DEPLOY_DOCS_RELEASE}";
echo "DO_DEPLOY_DOCS_DEVELOP: ${DO_DEPLOY_DOCS_DEVELOP}";
echo "DO_COVERAGE: ${DO_COVERAGE}";
echo "DO_TEST_DOCS: ${DO_TEST_DOCS}";
