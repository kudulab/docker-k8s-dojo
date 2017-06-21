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
  assert_line --partial "1.6.6"
  assert_equal "$status" 0
}
@test "Remote Kubernetes cluster is accessible" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"kubectl cluster-info\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "Kubernetes master"
  assert_line --partial "http://k8s.ai-traders.com:8080"
  assert_equal "$status" 0
}
@test "correct Helm version is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested \"helm version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "2.4.2"
  assert_equal "$status" 0
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
