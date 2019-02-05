#!/bin/bash -e

export K8S_ENDPOINT="${K8S_ENDPOINT:-https://k8s2.ai-traders.com:6443}"
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
EOF

chown dojo:dojo -R "${dojo_home}/.kube/"
