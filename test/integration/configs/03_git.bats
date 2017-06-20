load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "git is installed" {
  run /bin/bash -c "ide --idefile Idefile.to_be_tested_configs -- -c \"git --version\""
  assert_output --partial "git version"
  assert_equal "$status" 0
  run git status
}
