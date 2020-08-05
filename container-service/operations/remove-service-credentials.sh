#!/bin/bash
  
# check input parameter
if [ -z $1 ] ; then
  echo "Enter first parameter :: BOSH NAME >> Usage: sh remove-service-credentials.sh {BOSH NAME} {DEPLOYMENT NAME}" && exit 1;
fi

if [ -z $2 ] ; then
  echo "Enter second parameter :: DEPLOYMENT NAME >> Usage: sh remove-service-credentials.sh {BOSH NAME} {DEPLOYMENT NAME}" && exit 2;
fi


BOSH_NAME=$1
DEPLOYMENT_NAME=$2

# CREDHUB CREDENTIAL DELETE
for i in `credhub find --name-like=/${DEPLOYMENT_NAME}/`
do
  credential=`echo "$i" | awk -F " " '/'${BOSH_NAME}'/{print $1}'`
  if [ -n "$credential" ]; then
    echo "delete-credentials ::: [$credential]"
    credhub d -n $credential
  fi
done

