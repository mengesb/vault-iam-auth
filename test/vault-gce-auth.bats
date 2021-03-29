#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup_file() {
  docker run --name bats_vault_gce_auth --rm -d -p 8080:8080 --env-file test/ENV_GOOGLE_METADATA -t salrashid123/gcemetadataserver:1.0.0 -tokenScopes https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/cloud-platform -port :8080
  export GCE_METADATA_MOCK=http://127.0.0.1:8080
  sleep 1
}

function teardown_file() {
  unset GCE_METADATA_MOCK
  docker stop bats_vault_gce_auth
}

@test "vault-gce-auth.sh REQUIRES -r" {
  run gcp/vault-gce-auth.sh
  assert_failure 1
  assert_output --regexp "^Required option: '-r \[VAULT_ROLE\]'"
  assert_output --regexp '  usage: gcp/vault\-gce\-auth\.sh \[OPTIONS\.\.\.\]'
}

@test "vault-gce-auth.sh -r my-custom-role" {
  run gcp/vault-gce-auth.sh -r my-custom-role
  assert_success
  assert_output --regexp '^\{'
  assert_output --regexp '"role": "[a-zA-Z0-9_\+=,\.@\-]+",'
  assert_output --regexp '"http_request_method": "POST",'
  assert_output --regexp '"jwt": "[a-zA-Z0-9_=\.\-]+"'
  assert_output --regexp '}$'
}

@test "vault-gce-auth.sh with VAULT_ROLE=env-var-vault-role" {
  export VAULT_ROLE=env-var-vault-role
  run gcp/vault-gce-auth.sh
  assert_success
  assert_output --regexp '"role": "env-var-vault-role",'
}

@test "vault-gce-auth.sh -h" {
  run gcp/vault-gce-auth.sh -h
  assert_success
  assert_output --regexp '^  usage: gcp/vault\-gce\-auth\.sh \[OPTIONS\.\.\.\]'
}
