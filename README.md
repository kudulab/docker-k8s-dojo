# docker-k8s-ide

Produces IDE docker image with kubectl installed.
Based on alpine docker image.

## Usage
1. Install [IDE](https://github.com/ai-traders/ide)
2. Provide an Idefile:
```
K8S_ENDPOINT=http://10.1.1.123:8080 # defaults to http://k8s.ai-traders.com:8080
IDE_DOCKER_IMAGE="docker-registry.ai-traders.com/k8s-ide:0.3.4"
```
3. Run, example commands:
```bash
kubectl version
kubectl cluster-info
kubectl get pod
helm version
```

By default, current directory in docker container is `/ide/work`.

Main use case: to deploy services on top of k8s infrastructure.

### Configuration
Those files are used inside gitide docker image:

1. `~/.ssh/config` -- will be generated on docker container start
2. `~/.ssh/id_rsa` -- it must exist locally, because it is a secret
 (but the whole `~/.ssh` will be copied)
2. `~/.gitconfig` -- if exists locally, will be copied
3. `~/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/ide/work`.

The `~/.kube/config` file is provided.


## Development
### Dependencies
* Bash
* Docker daemon
* Bats
* Ide

### Tests
There are 2 Dockerfiles:
  * Dockerfile_ide_configs -- to test IDE configuration files and fail fast
  * Dockerfile -- to build the main ide image, based on image built from
   Dockerfile_ide_configs

### Lifecycle
1. In a feature branch:
    * you make changes and add some docs to changelog (do not insert date or version)
    * you build docker image with ide configs: `./tasks build_cfg`
    * you test docker image with ide configs: `./tasks test_cfg`
    * you build docker image: `./tasks build`
    * and test it: `./tasks itest`
1. You decide that your changes are ready and you:
    * merge into master branch
    * run locally:
      * `./tasks set_version` to set version from OVersion to changelog
      * or `./tasks set_version 1.2.3` to bump to a particular version
        Version is bumped in Changelog, variables.sh file and OVersion backend
    * push to master onto private git server
1. CI server (GoCD) tests and releases.
