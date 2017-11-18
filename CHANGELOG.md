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
