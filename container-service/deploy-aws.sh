#!/bin/bash

# VARIABLES
BOSH_NAME="<BOSH_NAME>"                            # bosh name (e.g. micro-bosh)
IAAS="aws"                                         # IaaS (e.g. aws/azure/gcp/openstack/vsphere)
COMMON_VARS_PATH="<COMMON_VARS_FILE_PATH>"         # common_vars.yml File Path (e.g. /home/ubuntu/paasta-5.0/common/common_vars.yml)

# DEPLOY
bosh -e ${BOSH_NAME} -n -d container-service deploy --no-redact container-service.yml \
    -l ${COMMON_VARS_PATH} \
    -l ${IAAS}-vars.yml \
    -o operations/paasta-container-service/${IAAS}-network.yml \
    -o operations/iaas/${IAAS}/cloud-provider.yml \
    -o operations/iaas/${IAAS}/add-master-credentials.yml \
    -o operations/iaas/${IAAS}/add-worker-credentials.yml \
    -o operations/iaas/${IAAS}/bosh/tags.yml \
    -o operations/iaas/${IAAS}/lb.yml \
    -o operations/rename.yml \
    -o operations/misc/single-master.yml \
    -o operations/misc/first-time-deploy.yml
