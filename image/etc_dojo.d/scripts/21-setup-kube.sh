#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from dojo_identity into dojo_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

if [ ! -d "${dojo_home}/.kube" ]; then
  # This directory should exist locally (outside of the container), because
  # you may be using some tool that generates kubeconfig and it would be gone
  # after you remove the container
  echo "ERROR: ${dojo_home}/.kube does not exist"
  exit 1
fi
