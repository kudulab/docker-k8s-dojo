load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/etc/ide.d/scripts/21-generate-kubeconfig.sh file exists and is executable" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested_configs -- -c \"test -x /etc/ide.d/scripts/21-generate-kubeconfig.sh\""
  # this is printed on test failure
  echo "output: $output"
  assert_equal "$status" 0
}
@test "/etc/ide.d/scripts/21-generate-kubeconfig.sh returns 0" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested_configs -- -c \"ide_home=/home/ide /etc/ide.d/scripts/21-generate-kubeconfig.sh && cat /home/ide/.kube/config\""
  assert_equal "$status" 0
  assert_output --partial "server: http://k8s.ai-traders.com:8080"
}
@test "/etc/ide.d/scripts/21-generate-kubeconfig.sh with custom k8s endpoint returns 0" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested_configs -- -c \"ide_home=/home/ide K8S_ENDPOINT=123 /etc/ide.d/scripts/21-generate-kubeconfig.sh && cat /home/ide/.kube/config\""
  assert_equal "$status" 0
  refute_output "http://k8s.ai-traders.com:8080"
  assert_output --partial "server: 123"
}
