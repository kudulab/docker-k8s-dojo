#!/bin/bash -e

if [[ ! -f "${dojo_home}/.kube/config" ]]; then
  if [[ -z "${K8S_ENDPOINT}" ]]; then
    echo "INFO: K8S_ENDPOINT is not set and kube config does not exist (will not create)"
  else
    echo "INFO: K8S_ENDPOINT is set and kube config does not exist (will create)"
    generate-kubeconfig.sh
  fi
fi
