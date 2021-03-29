#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup_file() {
  ec2-metadata-mock -n 127.0.0.1 > /dev/null 3>&- &
  export EC2_METADATA_MOCK=http://127.0.0.1:1338/latest/meta-data
  sleep 1
}

function teardown_file() {
  unset EC2_METADATA_MOCK
}

@test "vault-iam-auth.sh" {
  run aws/vault-iam-auth.sh
  assert_success
  assert_output --regexp '^\{'
  assert_output --regexp '"role": "[a-zA-Z0-9_\+=,\.@\-]+",'
  assert_output --regexp '"iam_http_request_method": "POST",'
  assert_output --regexp '"iam_request_url": "[a-zA-Z0-9=]+",'
  assert_output --regexp '"iam_request_body": "[a-zA-Z0-9=]+",'
  assert_output --regexp '"iam_request_headers": "[a-zA-Z0-9=]+"'
  assert_output --regexp '}$'
}

@test "vault-iam-auth.sh -r my-custom-role" {
  run aws/vault-iam-auth.sh -r my-custom-role
  assert_success
  assert_output --regexp '"role": "my-custom-role",'
}

@test "vault-iam-auth.sh with VAULT_ROLE=env-var-vault-role" {
  export VAULT_ROLE=env-var-vault-role
  run aws/vault-iam-auth.sh
  assert_success
  assert_output --regexp '"role": "env-var-vault-role",'
}

@test "vault-iam-auth.sh -h" {
  run aws/vault-iam-auth.sh -h
  assert_success
  assert_output --regexp '^  usage: aws/vault\-iam\-auth\.sh \[OPTIONS\.\.\.\]'
}
