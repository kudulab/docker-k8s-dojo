load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "ide init finished"
  assert_line --partial "/ide/work"
  assert_line --partial "k8s-ide"
  refute_output "root"
  assert_equal "$status" 0
}
@test "correct kubectl version is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"kubectl version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "1.10.2"
  # 1, because we use fake tls certificates
  assert_equal "$status" 1
}
@test "correct Helm version is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"timeout -t 1 helm version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "2.9.0"
  # do not assert exit status, this command hangs and will be time-outed, because
  # we use fake tls certificates
}
@test "Helm was correctly initialized" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"ls -la /home/ide\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "helm"
  assert_equal "$status" 0
}
@test "ssh client is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"ssh\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "usage: ssh"
  assert_equal "$status" 255
}
@test "custom k8s master endpoint can be used" {
  run /bin/bash -c "export K8S_ENDPOINT=123 && ide --idefile Idefile.to_be_tested \"cat /home/ide/.kube/config\""
  # this is printed on test failure
  echo "output: $output"
  refute_output "http://k8s.ai-traders.com:8080"
  assert_output --partial "server: 123"
  assert_equal "$status" 0
}
