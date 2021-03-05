#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup_file() {
  ec2-metadata-mock -n 127.0.0.1 > /dev/null 3>&- &
  export EC2_METADATA_MOCK=http://127.0.0.1:1338/latest/meta-data
  sleep 1
}

function teardown_file() {
  #pkill ec2-metadata-mock
  unset EC2_METADATA_MOCK
}

@test "vault-iam-auth.sh" {
  run aws/vault-iam-auth.sh
  [ "$status" -eq 0 ]
  [ "${lines[0]}" == "{" ]
  [[ "${lines[1]}" =~ \"role\":\ \"[a-zA-Z0-9_\+=,\.@\-]+\",$ ]]
  [[ "${lines[2]}" =~ \"iam_http_request_method\":\ \"POST\",$ ]]
  [[ "${lines[3]}" =~ \"iam_request_url\":\ \"[a-zA-Z0-9=]+\",$ ]]
  [[ "${lines[4]}" =~ \"iam_request_body\":\ \"[a-zA-Z0-9=]+\",$ ]]
  [[ "${lines[5]}" =~ \"iam_request_headers\":\ \"[a-zA-Z0-9=]+\"$ ]]
  [ "${lines[6]}" == "}" ]
}

@test "vault-iam-auth.sh -r my-custom-role" {
  run aws/vault-iam-auth.sh -r my-custom-role
  [ "$status" -eq 0 ]
  [[ "${lines[1]}" =~ \"role\":\ \"my-custom-role\",$ ]]
}

@test "vault-iam-auth.sh with VAULT_ROLE=env-var-vault-role" {
  export VAULT_ROLE=env-var-vault-role
  run aws/vault-iam-auth.sh
  [ "$status" -eq 0 ]
  [[ "${lines[1]}" =~ \"role\":\ \"env-var-vault-role\",$ ]]
}

@test "vault-iam-auth.sh -h" {
  run aws/vault-iam-auth.sh -h
  [ "$status" -eq 0 ]
  [ "${lines[0]}" == "  usage: aws/vault-iam-auth.sh [OPTIONS...]" ]
}
