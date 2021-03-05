#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "Requirements: bats version" {
  run bats --version
  assert_success
  assert_output --regexp '^Bats [1-9]+\.[0-9]+\.[0-9]+$'
}

@test "Requirements: ec2-metadata-mock" {
  run ec2-metadata-mock --version
  assert_success
  assert_output --regexp '^v[1-9]+\.[0-9]+\.[0-9]+$'
}

@test "Requirements: shdoc" {
  run which -a shdoc > /dev/null
  assert_success
}

@test "Requirements: gawk" {
  run gawk --version
  assert_success
  assert_output --partial 'GNU Awk'
}

@test "Requirements: shellcheck" {
  run shellcheck --version
  assert_success
  assert_output --partial 'license: GNU'
  assert_output --regexp 'version: [0-9]+\.[0-9]+\.[0-9]+'
}
