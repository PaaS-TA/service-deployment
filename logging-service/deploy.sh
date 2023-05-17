#!/bin/bash

# VARIABLES
COMMON_VARS_PATH="<COMMON_VARS_FILE_PATH>"             # common_vars.yml File Path (e.g. ../../common/common_vars.yml)
BOSH_ENVIRONMENT="${BOSH_ENVIRONMENT}"                   # bosh director alias name (PaaS-TA에서 제공되는 create-bosh-login.sh 미 사용시 bosh envs에서 이름을 확인하여 입력)


# PaaS-TA, Portal 설치 타입 및 프로토콜 종류에 따라 옵션 파일 사용 여부를 분기한다.
PAASTA_DEPLOY_TYPE=`grep paasta_deploy_type vars.yml | cut -d "#" -f1`
PORTAL_DEPLOY_TYPE=`grep portal_deploy_type vars.yml | cut -d "#" -f1`
FLUENTD_TRANSPORT=`grep fluentd_transport vars.yml`


if [[ "${PAASTA_DEPLOY_TYPE}" =~ "sidecar" ]]; then
  source operations/create-sidecar-ops.sh
  if [[ "${PORTAL_DEPLOY_TYPE}" =~ "app" ]]; then
      bosh -e ${BOSH_ENVIRONMENT} -d logging-service -n deploy logging-service.yml \
            -o operations/portal-app-type.yml \
            -o operations/paasta-sidecar-type.yml \
            -l vars.yml \
            -l ${COMMON_VARS_PATH}
  else
    echo "Logging Service can't install. Please check 'portal_deploy_type'."
  fi
elif [[ "${PAASTA_DEPLOY_TYPE}" =~ "ap" ]]; then
  if [[ "${PORTAL_DEPLOY_TYPE}" =~ "app" ]]; then
    if [[ "${FLUENTD_TRANSPORT}" =~ "tcp" ]]; then
      bosh -e ${BOSH_ENVIRONMENT} -d logging-service -n deploy logging-service.yml \
            -o operations/portal-app-type.yml \
            -o operations/use-protocol-tcp.yml \
            -l vars.yml \
            -l ${COMMON_VARS_PATH}
    else
      bosh -e ${BOSH_ENVIRONMENT} -d logging-service -n deploy logging-service.yml \
            -o operations/portal-app-type.yml \
            -l vars.yml \
            -l ${COMMON_VARS_PATH}
    fi
  elif [[ "${PORTAL_DEPLOY_TYPE}" =~ "vm" ]]; then
    if [[ "${FLUENTD_TRANSPORT}" =~ "tcp" ]]; then
      bosh -e ${BOSH_ENVIRONMENT} -d logging-service -n deploy logging-service.yml \
            -o operations/use-protocol-tcp.yml \
            -l vars.yml \
            -l ${COMMON_VARS_PATH}
    else
      bosh -e ${BOSH_ENVIRONMENT} -d logging-service -n deploy logging-service.yml \
            -l vars.yml \
            -l ${COMMON_VARS_PATH}
    fi
  else
    echo "Logging Service can't install. Please check 'portal_deploy_type'."
  fi
else
  echo "Logging Service can't install. Please check 'paasta_deploy_type'."
fi