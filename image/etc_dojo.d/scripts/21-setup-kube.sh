#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from dojo_identity into dojo_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

if [ ! -d "${dojo_identity}/.kube" ]; then
  echo "ERROR: ${dojo_identity}/.kube does not exist"
  exit 1
else
  if [[ "${AIT_DEBUG}" != "true" ]]; then
	   cp -r "${dojo_identity}/.kube" "${dojo_home}"
  else
	   cp -vr "${dojo_identity}/.kube" "${dojo_home}"
  fi
fi
chown dojo:dojo -R "${dojo_home}/.kube"
