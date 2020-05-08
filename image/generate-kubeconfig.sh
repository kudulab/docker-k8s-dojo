#!/bin/bash

if [[ -z "${K8S_ENDPOINT}" ]]; then
  echo "ERROR: K8S_ENDPOINT is not set"
  exit 1
fi

echo "Using K8S_ENDPOINT=${K8S_ENDPOINT}"
export KUBE_USER="${KUBE_USER:-${DOJO_USER}}"
echo "Using KUBE_USER=${KUBE_USER}"

mkdir -p "${dojo_home}/.kube"
cat <<EOF >${dojo_home}/.kube/config
apiVersion: v1
kind: Config
preferences: {}

clusters:
- name: default-cluster
  cluster:
    server: ${K8S_ENDPOINT}
    certificate-authority: ${dojo_home}/.kube/ca.crt
users:
- name: ${KUBE_USER}
  user:
    client-certificate: ${dojo_home}/.kube/${KUBE_USER}.crt
    client-key: ${dojo_home}/.kube/${KUBE_USER}.key

contexts:
- name: default-context
  context:
    cluster: default-cluster
    user: ${KUBE_USER}

current-context: default-context
