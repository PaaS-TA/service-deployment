#!/bin/bash
bosh -e micro-bosh -d paasta-object-storage deploy paasta-object-storage-bosh2.0.yml \
   -v releases_name="paasta-portal-release"\
   -v stemcell_os="ubuntu-trusty"\
   -v stemcell_version="3468.51"\
   -v stemcell_alias="default"\
   -v vm_type_small="small"\
   -v internal_networks_name=service_private \
   -v external_networks_name=vip \
   -v mariadb_disk_type="10GB"\
   -v mariadb_port="3306"\
   -v mariadb_user_password="master"\
   -v binary_storage_disk_type="10GB"\
   -v binary_storage_username="paasta-portal"\
   -v binary_storage_password="paasta"\
   -v binary_storage_tenantname="paasta-portal"\
   -v binary_storage_email="paasta@paas-ta.kr"\
