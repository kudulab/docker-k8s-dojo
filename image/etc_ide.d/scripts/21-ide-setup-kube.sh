#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from ide_identity into ide_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

if [ ! -d "${ide_identity}/.kube" ]; then
  echo "ERROR: ${ide_identity}/.kube does not exist"
  exit 1
else
  if [[ "${AIT_DEBUG}" != "true" ]]; then
	   cp -r "${ide_identity}/.kube" "${ide_home}"
  else
	   cp -vr "${ide_identity}/.kube" "${ide_home}"
  fi
fi
chown ide:ide -R "${ide_home}/.kube"
