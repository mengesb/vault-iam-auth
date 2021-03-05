#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "Requirements: bats" {
  run which -s bats
  [ "$status" -eq 0 ]
}

@test "Requirements: bats version" {
  run bats --version
  [ "$status" -eq 0 ]
  [[ "$output" =~ Bats\ [1-9]\. ]]
}

@test "Requirements: ec2-metadata-mock" {
  run which -s ec2-metadata-mock
  [ "$status" -eq 0 ]
}

@test "Requirements: shdoc" {
  run which -s shdoc
  [ "$status" -eq 0 ]
}

@test "Requirements: gawk" {
  run which -s gawk
  [ "$status" -eq 0 ]
}

@test "Requirements: shellcheck" {
  run which -s shellcheck
  [ "$status" -eq 0 ]
}
