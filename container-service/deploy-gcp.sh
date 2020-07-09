#!/bin/bash

# VARIABLES
BOSH_NAME="<BOSH_NAME>"                             # bosh name (e.g. micro-bosh)
IAAS="gcp"                                          # IaaS (e.g. aws/azure/gcp/openstack/vsphere)
COMMON_VARS_PATH="<COMMON_VARS_FILE_PATH>"          # common_vars.yml File Path (e.g. /home/ubuntu/paasta-5.0/common/common_vars.yml)

# DEPLOY
bosh -e ${BOSH_NAME} -n -d container-service deploy --no-redact container-service.yml \
    -l ${COMMON_VARS_PATH} \
    -l ${IAAS}-vars.yml \
    -o operations/paasta-container-service/${IAAS}-network.yml \
    -o operations/iaas/${IAAS}/cloud-provider.yml \
    -o operations/iaas/${IAAS}/add-service-key-master.yml \
    -o operations/iaas/${IAAS}/add-service-key-worker.yml \
    -o operations/rename.yml \
    -o operations/misc/single-master.yml \
    -o operations/misc/first-time-deploy.yml \
    --var-file service_key_master=~/.ssh/paas-ta-240504-ed67134dc5e3.json \
    --var-file service_key_worker=~/.ssh/paas-ta-240504-ed67134dc5e3.json
