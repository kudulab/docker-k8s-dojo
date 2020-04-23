# docker-k8s-dojo

Produces Dojo docker image with kubectl installed.
Based on alpine docker image.

## Usage
1. Install [Dojo](https://github.com/kudulab/dojo)
2. Provide a Dojofile:
```
DOJO_DOCKER_IMAGE="docker-registry.ai-traders.com/k8s-ide:latest"
DOJO_DOCKER_OPTIONS=-e K8S_ENDPOINT="http://my-k8s.example.com:8080" \
  -e KUBE_USER="mykubeuser"
# environment variable KUBE_USER defaults to ${DOJO_USER}
```

3. Ensure mandatory directory exists locally. Nothing will be written to it outside of docker container:
```
mkdir -p ~/.kube
```
4. Run `dojo` to make Dojo run a Docker container.
5. Inside the container you can run e.g.:
```bash
kubectl version
kubectl cluster-info
kubectl get pod
helm version
```

By default, current directory in docker container is `/dojo/work`.

Main use case: to deploy services on top of k8s infrastructure.

### Configuration
Those files are used inside the docker image:

1. `~/.ssh` - if exists locally, will be copied
1. `~/.ssh/config` - will be generated on docker container start
1. `~/.gitconfig` - if exists locally, will be copied
1. `~/.kube` - if exists locally, will be copied; otherwise results in error
1. `~/.kube/config` - if not exists locally, will be generated on docker container start


## Development
### Dependencies
* Bash
* Docker daemon
* Bats
* Dojo


### Lifecycle
1. In a feature branch:
    * make changes and add some docs to changelog (do not insert date or version)
    * build docker image: `./tasks build_local`
    * test it: `./tasks itest`
1. Decide that your changes are ready and if so:
    * merge into master branch
    * set version in changelog by running:
      * `./tasks set_version`
      * or `./tasks set_version 1.2.3` to bump to a particular version
    * push to master
1. CI server (GoCD) tests and releases.
