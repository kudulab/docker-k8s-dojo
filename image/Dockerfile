FROM alpine:3.6

# For ide:
# * entrypoint requires sudo and shadow
# * git is needed to install ide image configs
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache bash shadow sudo git && \
  git clone --depth 1 -b 0.10.2 https://github.com/ai-traders/ide.git /tmp/ide_git && \
  /tmp/ide_git/ide_image_scripts/src/install.sh && \
  rm -r /tmp/ide_git && \
  echo 'ide ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# * wget, nano, openssh-client, curl, curl-dev are installed just in case
# * ca-certificates are needed to wget helm tar.gz
# * install bash-completion for kubectl and helm. 2 files from /etc/profile.d/
# have to be sourced which will happen on running bash login shell.
# And install colorful bash prompt.
COPY bashrc /home/ide/.bashrc
RUN apk add --no-cache wget nano openssh-client curl curl-dev ca-certificates bash-completion &&\
  chown ide:ide /home/ide/.bashrc

# this must be the same as used by infra-kubernetes
ENV KUBERNETES_VERSION=1.10.1
ENV HELM_VERSION=2.9.0-rc4

# install kubectl
RUN cd /tmp/ && wget http://os2.ai-traders.com:6780/swift/v1/k8s-binaries/v${KUBERNETES_VERSION}/kubernetes-server-linux-amd64.tar.gz &&\
  mkdir /tmp/kubernetes && cd /tmp/kubernetes &&\
  tar -xzf "/tmp/kubernetes-server-linux-amd64.tar.gz" &&\
  mv /tmp/kubernetes/kubernetes/server/bin/kubectl /usr/local/bin/ && chmod 755 /usr/local/bin/kubectl &&\
  rm /tmp/kubernetes-server-linux-amd64.tar.gz &&\
  cd / && rm -r /tmp/kubernetes

# install Helm
RUN mkdir -p /tmp/helm && cd /tmp/helm &&\
  wget -O helm.tar.gz --quiet https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz &&\
  tar -xvf helm.tar.gz && mv ./linux-amd64/helm /usr/local/bin/ &&\
  sudo -E -H -u ide /bin/bash -lc "helm init --client-only" &&\
  rm -r /tmp/helm

COPY etc_ide.d/scripts/* /etc/ide.d/scripts/
# COPY etc_ide.d/variables/* /etc/ide.d/variables/
COPY inputrc /etc/inputrc

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

ARG this_image_tag_arg
ARG this_image_name_arg
ENV this_image_tag=${this_image_tag_arg} this_image_name=${this_image_name_arg}
