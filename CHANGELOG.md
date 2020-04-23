### 1.0.0 (2020-Apr-23)

* use base image alpine:3.11.5
* use dojo scripts 0.8.0
* run chmod on "${dojo_home}/.kube" directory once instead of twice
* remove AI-Traders configuration
* create "${dojo_home}/.kube/config" only if does not exist

### 0.5.0 (2019-Feb-05)

* newer releaser and docker-ops
* transform from ide docker image to dojo docker image #17139
* install kubectl from public location (faster and simpler)

### 0.4.7 (2018-Jul-01)

* use conventional ide configuration scripts
* kubernetes 1.10.4
* helm 2.9.1

### 0.4.6 (2018-Jun-09)

* fix setting ownership of ~/.kube
* use ide image scripts from ide 0.10.3 so that IDE_WORK_INNER has a default value #12045

### 0.4.5 (2018-May-24)

* fix: make this work also if ~/.kube contains no directories

### 0.4.4 (2018-May-22)

* kubernetes 1.10.3

### 0.4.3 (2018-May-20)

* set K8S_ENDPOINT to point to k8s2.ai-traders.com #13024

### 0.4.2 (2018-May-17)

* only use verbose copying of ~/.kube/ files (cp -vr) if AIT_DEBUG is set

### 0.4.1 (2018-May-15)

* fix: the previous version did not work when there were directories in `~/.kube`

### 0.4.0 (2018-May-14)

* in kubeconfig use tls certificates #12953
* add variable: KUBE_USER
* make integration tests independent from our production kubernetes cluster
* kubectl 1.10.2
* wget only kubectl.tar.gz

### 0.3.7 (2018-Apr-27)

* Helm 2.9.0

### 0.3.6 (2018-Apr-24)

* newer base image `alpine:3.7`
* no need to add alpine repository: http://dl-cdn.alpinelinux.org/alpine/edge/community.
 Adding it results in:
 WARNING: This apk-tools is OLD! Some packages might not function properly

### 0.3.5 (2018-Apr-24)

* Helm 2.9.0-rc4 #12502
* Kubernetes 1.10.1 #12502
* dev: do not built tmp docker image

### 0.3.4 (2017-Nov-18)

* Helm 2.6.2 #11922
* Kubernetes 1.7.10 #11922

### 0.3.3 (2017-Nov-17)

* Helm 2.5.2 #11921
* Kubernetes 1.6.12 #11921

### 0.3.2 (2017-Jul-02)

* make the existence of ~/.ssh directory and secrets there optional #11289
* export K8S_ENDPOINT variable

### 0.3.1 (2017-Jul-02)

* make the existence of ~/.ssh directory and secrets there optional #11289

### 0.3.0 (2017-Jun-21)

* Kubernetes 1.6.6 #11219
* Helm 2.4.2 #11219

### 0.2.4 (2017-Jun-20)

* dev
  * do not use ruby, use releaser and docker-ops
  * use ide configs from ide 0.8.2
  * GoCD pipeline with elastic_profile_id

### 0.2.3 (6 Apr 2017)

* \#10814 Helm 2.2.3

### 0.2.2 (7 Mar 2017)

* \#10670 Install bash-completion for kubectl and helm
* \#10672 Helm 2.2.2
* \#10673 colorful bash prompt

### 0.2.1 (2 Mar 2017)

\#10646: initialize Helm as ide user (was as root)

### 0.2.0 (1 Mar 2017)

\#10646:
* Kubernetes 1.5.3
* Helm 2.2.1
* make k8s endpoint configurable when setting ~/.kube/config
* rename from kubernetes-ide to k8s-ide

### 0.1.0 (26 Jan 2017)

Initial release of docker-kubernetes-ide
* add inputrc file so that shortcuts like ctrl+left work
* install openssh-client
* install kubectl version 1.5.0-beta.3
