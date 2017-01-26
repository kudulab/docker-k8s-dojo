FROM kubernetes-ide_configs:temp

ENV KUBERNETES_VERSION=1.5.0-beta.3

# * wget, nano and openssh-client are installed just in case
RUN apk add --update wget nano openssh-client
ADD http://http.archive.ai-traders.com/kubernetes/v${KUBERNETES_VERSION}/kubernetes-server-linux-amd64.tar.gz ./
COPY kube-config /home/ide/.kube/config

RUN mkdir /tmp/kubernetes && cd /tmp/kubernetes &&\
  tar -xzf "/kubernetes-server-linux-amd64.tar.gz" &&\
  mv /tmp/kubernetes/kubernetes/server/bin/kubectl /usr/local/bin/ && chmod 755 /usr/local/bin/kubectl &&\
  rm /kubernetes-server-linux-amd64.tar.gz &&\
  cd / && rm -r /tmp/kubernetes && chown ide:ide -R /home/ide/.kube/
