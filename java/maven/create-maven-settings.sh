#!/bin/bash
#
# Function for creating the Maven settings file for the CI process, storing it in the
# ~/settings.xml path.
#
# It will take care of two pieces of data:
# - Servers settings
# - Active profile
#
# Server settings will be read by Maven from the environmental variables, and this
# file will tell him so.
#
# The active profile will depend on the type of version the current code is for.
# Depending on if this is a release or a development version.
#
# REMEMBER: For security reasons the data stored in the generated file should not be
# shared. Never print it on the console or let it be accessed in any way.
#
# --- SERVERS ---
#
# A total of four servers will be set:
# - releases: for deploying release artifacts
# - site: for deploying the Maven site for the release version
# - snapshots: for deploying snapshot artifacts
# - site-development: for deploying the Maven site for the development version
#
# --- PROFILES ---
#
# One of two profiles may be set, depending on the type of version, which is read from
# the VERSION_TYPE environmental variable.
#
# By default these profiles are:
#
# - deployment-release: for setting up the release deployment
# - deployment-development: for setting up the development deployment
#
# They can be changed through the parameters.
#
# -- PARAMETERS --
#
# The function expects the following parameters:
# $1: A string, one of release|develop, otherwise it is ignored.
# $2: A string, the name of the profile with the release deployment configuration.
# $3: A string, the name of the profile with the snapshot deployment configuration.
#
# --- ENVIRONMENTAL VARIABLES ---
#
# The following environmental variables are required by the script, but read by Maven:
#
# - DEPLOY_USER: string, user for the releases repo
# - DEPLOY_PASSWORD: string, password for the releases repo
#
# - DEPLOY_DEVELOP_USER: string, user for the development repo
# - DEPLOY_DEVELOP_PASSWORD: string, password for the development repo
#
# - DEPLOY_DOCS_USER: string, user for the releases documentation site repo
# - DEPLOY_DOCS_PASSWORD: string, password for the releases documentation site repo
#
# - DEPLOY_DOCS_DEVELOP_USER: string, user for the development documentation site repo
# - DEPLOY_DOCS_DEVELOP_PASSWORD: string, password for the development documentation site repo
#
# - DEPLOY_DOCS_SITE: string, path for deploying the Maven site
# - DEPLOY_DOCS_DEVELOP_SITE: string, path for deploying the development Maven site
#

# Fails if any commands returns a non-zero value
set -e

v_type=${1:-}
profile_release=${2:-"deployment-release"}
profile_develop=${3:-"deployment-development"}

echo "Using development profile ${profile_develop}";
echo "Using release profile ${profile_release}";

# The contents of the file are created
{
   echo "<settings>";

   # ----------------
   # Servers settings
   # ----------------

   echo "<servers>";

   # Release artifacts server
   if [ -n "${DEPLOY_USER}" ]; then
      echo "<server>";
         echo "<id>releases</id>";
         echo "<username>\${DEPLOY_USER}</username>";
         echo "<password>\${DEPLOY_PASSWORD}</password>";
      echo "</server>";
   fi
   # Release site server
   if [ -n "${DEPLOY_DOCS_USER}" ]; then
      echo "<server>";
         echo "<id>site</id>";
         echo "<username>\${DEPLOY_DOCS_USER}</username>";
         echo "<password>\${DEPLOY_DOCS_PASSWORD}</password>";
      echo "</server>";
   fi

   # Development artifacts server
   if [ -n "${DEPLOY_DEVELOP_USER}" ]; then
      echo "<server>";
         echo "<id>snapshots</id>";
         echo "<username>\${DEPLOY_DEVELOP_USER}</username>";
         echo "<password>\${DEPLOY_DEVELOP_PASSWORD}</password>";
      echo "</server>";
   fi
   # Development site server
   if [ -n "${DEPLOY_DOCS_DEVELOP_USER}" ]; then
      echo "<server>";
         echo "<id>site-development</id>";
         echo "<username>\${DEPLOY_DOCS_DEVELOP_USER}</username>";
         echo "<password>\${DEPLOY_DOCS_DEVELOP_PASSWORD}</password>";
      echo "</server>";
   fi

   echo "</servers>";
   
   # --------
   # Profiles
   # --------
   
   echo "<profiles>";
   
      echo "<profile>";
         echo "<id>deployment_site</id>"
         # This profile is used to define the deployment site URL
         echo "<properties>"
            # Release site
            echo "<site.release.url>${DEPLOY_DOCS_SITE}</site.release.url>"
            # Development site
            echo "<site.develop.url>${DEPLOY_DOCS_DEVELOP_SITE}</site.develop.url>"
         echo "</properties>"
      echo "</profile>";

   echo "</profiles>";

   # --------------
   # Active profile
   # --------------

   # These profiles are used to set configuration specific to a version type
   echo "<activeProfiles>"
      if [ "${v_type}" == "release" ]; then
         # Release version
         echo "<activeProfile>${profile_release}</activeProfile>"
      elif [ "${v_type}" == "develop" ]; then
         # Development version
         echo "<activeProfile>${profile_develop}</activeProfile>"
      fi
      echo "<activeProfile>deployment_site</activeProfile>"
   echo "</activeProfiles>"

   echo "</settings>";
} >> ~/settings.xml

echo "Created Maven settings file"

exit 0
