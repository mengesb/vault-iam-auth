#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "Requirements: bats version" {
  run bats --version
  [ "$status" -eq 0 ]
  [[ "$output" =~ Bats\ [1-9]\. ]]
}

@test "Requirements: ec2-metadata-mock" {
  run ec2-metadata-mock --version
  [ "$status" -eq 0 ]
  [[ "$output" =~ v[1-9]\.[0-9]+\.[0-9]+ ]]
}

@test "Requirements: shdoc" {
  run which -a shdoc > /dev/null
  [ "$status" -eq 0 ]
}

@test "Requirements: gawk" {
  run gawk --version
  [ "$status" -eq 0 ]
  [[ "${lines[0]}" =~ GNU\ Awk ]]
}

@test "Requirements: shellcheck" {
  run shellcheck --version
  [ "$status" -eq 0 ]
  [[ "${lines[1]}" =~ version:\ [0-9]+\.[0-9]+\.[0-9]+ ]]
}
