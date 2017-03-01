load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/etc/ide.d/scripts/21-generate-kubeconfig.sh exists and is a file" {
  run test -f /etc/ide.d/scripts/21-generate-kubeconfig.sh
  assert_equal "$status" 0
}
@test "/etc/ide.d/scripts/21-generate-kubeconfig.sh is executable" {
  run test -x /etc/ide.d/scripts/21-generate-kubeconfig.sh
  assert_equal "$status" 0
}
@test "/etc/ide.d/scripts/21-generate-kubeconfig.sh returns 0" {
  run /bin/bash -c "ide_home=\"/home/ide\" /etc/ide.d/scripts/21-generate-kubeconfig.sh"
  assert_equal "$status" 0
  run cat /home/ide/.kube/config
  assert_output --partial "server: http://k8s.ai-traders.com:8080"
}
@test "/etc/ide.d/scripts/21-generate-kubeconfig.sh with custom k8s endpoint returns 0" {
  run /bin/bash -c "ide_home=\"/home/ide\" K8S_ENDPOINT=123 /etc/ide.d/scripts/21-generate-kubeconfig.sh"
  assert_equal "$status" 0
  run cat /home/ide/.kube/config
  refute_output "http://k8s.ai-traders.com:8080"
  assert_output --partial "server: 123"
}
