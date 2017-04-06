FROM k8s-ide_configs:temp

# this must be the same as used by infra-kubernetes
ENV KUBERNETES_VERSION=1.5.3
ENV HELM_VERSION=2.2.3

# * wget, nano, openssh-client, curl, curl-dev are installed just in case
# * ca-certificates are needed to wget helm tar.gz
# * install bash-completion for kubectl and helm. 2 files from /etc/profile.d/
# have to be sourced which will happen on running bash login shell.
# And install colorful bash prompt.
COPY bashrc /home/ide/.bashrc
RUN apk add --no-cache wget nano openssh-client curl curl-dev ca-certificates bash-completion &&\
  chown ide:ide /home/ide/.bashrc
ADD http://http.archive.ai-traders.com/kubernetes/v${KUBERNETES_VERSION}/kubernetes-server-linux-amd64.tar.gz ./

# install kubectl
RUN mkdir /tmp/kubernetes && cd /tmp/kubernetes &&\
  tar -xzf "/kubernetes-server-linux-amd64.tar.gz" &&\
  mv /tmp/kubernetes/kubernetes/server/bin/kubectl /usr/local/bin/ && chmod 755 /usr/local/bin/kubectl &&\
  rm /kubernetes-server-linux-amd64.tar.gz &&\
  cd / && rm -r /tmp/kubernetes

# install Helm
RUN mkdir -p /tmp/helm && cd /tmp/helm &&\
  wget -O helm.tar.gz --quiet https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz &&\
  tar -xvf helm.tar.gz && mv ./linux-amd64/helm /usr/local/bin/ &&\
  sudo -E -H -u ide /bin/bash -lc "helm init --client-only"
