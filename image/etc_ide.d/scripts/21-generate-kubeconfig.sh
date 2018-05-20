#!/bin/bash -e

export K8S_ENDPOINT="${K8S_ENDPOINT:-https://k8s2.ai-traders.com:6443}"
echo "Using K8S_ENDPOINT=${K8S_ENDPOINT}"
export KUBE_USER="${KUBE_USER:-${IDE_USER}}"
echo "Using KUBE_USER=${KUBE_USER}"

mkdir -p "${ide_home}/.kube"
cat <<EOF >${ide_home}/.kube/config
apiVersion: v1
kind: Config
preferences: {}

clusters:
- name: default-cluster
  cluster:
    server: ${K8S_ENDPOINT}
    certificate-authority: ${ide_home}/.kube/ca.crt
users:
- name: ${KUBE_USER}
  user:
    client-certificate: ${ide_home}/.kube/${KUBE_USER}.crt
    client-key: ${ide_home}/.kube/${KUBE_USER}.key

contexts:
- name: default-context
  context:
    cluster: default-cluster
    user: ${KUBE_USER}

current-context: default-context
EOF

chown ide:ide -R "${ide_home}/.kube/"
