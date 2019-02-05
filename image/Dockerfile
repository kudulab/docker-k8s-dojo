FROM alpine:3.7

# For Dojo:
# * entrypoint requires sudo and shadow
# * git is needed to install dojo image configs
RUN apk add --no-cache bash shadow sudo git && \
  git clone --depth 1 -b 0.2.1 https://github.com/ai-traders/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git && \
  echo 'dojo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# * wget, nano, openssh-client, curl, curl-dev are installed just in case
# * ca-certificates are needed to wget helm tar.gz
# * install bash-completion for kubectl and helm. 2 files from /etc/profile.d/
# have to be sourced which will happen on running bash login shell.
# And install colorful bash prompt.
COPY bashrc /home/dojo/.bashrc
COPY profile /home/dojo/.profile
RUN apk add --no-cache wget nano openssh-client curl curl-dev ca-certificates bash-completion &&\
  chown dojo:dojo -R /home/dojo

# this must be the same as used by infra-kubernetes
ENV KUBERNETES_VERSION=1.10.4
ENV HELM_VERSION=2.9.1

# install kubectl
RUN cd /tmp/ && wget -O kubectl.tar.gz http://os2.ai-traders.com:6780/swift/v1/k8s-binaries/v${KUBERNETES_VERSION}/kubectl.tar.gz &&\
  mkdir /tmp/kubernetes && cd /tmp/kubernetes &&\
  tar -xzf "/tmp/kubectl.tar.gz" &&\
  mv /tmp/kubernetes/kubectl /usr/local/bin/ && chmod 755 /usr/local/bin/kubectl &&\
  rm /tmp/kubectl.tar.gz &&\
  cd / && rm -r /tmp/kubernetes

# install Helm
RUN mkdir -p /tmp/helm && cd /tmp/helm &&\
  wget -O helm.tar.gz --quiet https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz &&\
  tar -xvf helm.tar.gz && mv ./linux-amd64/helm /usr/local/bin/ &&\
  sudo -E -H -u dojo /bin/bash -lc "helm init --client-only" &&\
  rm -r /tmp/helm

COPY etc_dojo.d/scripts/* /etc/dojo.d/scripts/
# COPY etc_dojo.d/variables/* /etc/dojo.d/variables/
COPY inputrc /etc/inputrc

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]
