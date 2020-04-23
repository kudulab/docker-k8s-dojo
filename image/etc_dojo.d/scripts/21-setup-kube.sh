#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from dojo_identity into dojo_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

if [ ! -d "${dojo_identity}/.kube" ]; then
  # TODO: does it have to exist locally outside of cotnainer?
  echo "ERROR: ${dojo_identity}/.kube does not exist"
  exit 1
else
  if [[ "${AIT_DEBUG}" != "true" ]]; then
	   cp -r "${dojo_identity}/.kube" "${dojo_home}"
  else
	   cp -vr "${dojo_identity}/.kube" "${dojo_home}"
  fi
fi
