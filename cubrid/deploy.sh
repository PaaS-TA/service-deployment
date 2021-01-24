#!/bin/bash

# VARIABLES
COMMON_VARS_PATH="<COMMON_VARS_FILE_PATH>"       # common_vars.yml File Path (e.g. ../../common/common_vars.yml)

# DEPLOY
bosh -e ${BOSH_ENVIRONMENT} -n -d cubrid deploy --no-redact cubrid.yml \
    -l ${COMMON_VARS_PATH} \
    -l vars.yml 
