#!/bin/bash

WORKSPACE=$(pwd)

cat << EOF >> ${WORKSPACE}/operations/paasta-sidecar-type.yml
---

- type: remove
  path: /instance_groups/name=fluentd

- type: remove
  path: /instance_groups/name=collector

- type: replace
  path: /instance_groups/name=log-api/properties/paastaType?
  value: sidecar

EOF

if [[ ${PORTAL_DEPLOY_TYPE} =~ "app" ]]; then
  sed -i "s/http:\/\/portal-registration/http:\/\/portal-registration.apps/" ${WORKSPACE}/operations/portal-app-type.yml
fi