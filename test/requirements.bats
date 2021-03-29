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

@test "Requirements: docker" {
  run docker --version
  assert_success
  assert_output --regexp '[1-9]+([0-9]+)?\.[0-9]+\.[0-9]+'
}

@test "Requirements: shdoc" {
  if ! command -v shdoc > /dev/null; then
    skip "SKIPPED: shdoc not part of \$PATH"
  fi

  run command -v shdoc > /dev/null
  assert_success
}

@test "Requirements: gawk" {
  if ! command -v gawk > /dev/null; then
    skip "SKIPPED: gawk not part of \$PATH"
  fi

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
