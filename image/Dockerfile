FROM alpine:3.11.5

# For Dojo:
# * entrypoint requires sudo and shadow
# * git is needed to install dojo image configs
ENV DOJO_VERSION=0.8.0
RUN apk add --no-cache bash shadow sudo git && \
  git clone --depth 1 -b ${DOJO_VERSION} https://github.com/kudulab/dojo.git /tmp/dojo_git &&\
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
ENV KUBERNETES_VERSION=1.16.8
ENV HELM_VERSION=3.2.0

# install kubectl
RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl &&\
  chmod 775 /usr/local/bin/kubectl

# install Helm
RUN mkdir -p /tmp/helm && cd /tmp/helm &&\
  wget -O helm.tar.gz --quiet https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz &&\
  tar -xvf helm.tar.gz && mv ./linux-amd64/helm /usr/local/bin/ &&\
  sudo -E -H -u dojo /bin/bash -lc "helm repo add stable https://kubernetes-charts.storage.googleapis.com/ &&\
    helm repo update" &&\
  rm -r /tmp/helm

COPY etc_dojo.d/scripts/* /etc/dojo.d/scripts/
# COPY etc_dojo.d/variables/* /etc/dojo.d/variables/
COPY inputrc /etc/inputrc
COPY generate-kubeconfig.sh /usr/bin/generate-kubeconfig.sh
RUN chmod +x /usr/bin/generate-kubeconfig.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]
