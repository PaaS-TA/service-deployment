#!/bin/bash

# VARIABLES
COMMON_VARS_PATH="<COMMON_VARS_FILE_PATH>"      # common_vars.yml File Path (e.g. ../../common/common_vars.yml)

bosh -e ${BOSH_ENVIRONMENT} -n -d glusterfs deploy --no-redact glusterfs.yml \
    -l ${COMMON_VARS_PATH} \
    -l vars.yml
