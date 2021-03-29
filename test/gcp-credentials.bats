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

@test "Requirements: gce-metadata-mock running" {
  run curl -sS -H 'Host: metadata.google.internal' "${GCE_METADATA_MOCK}/"
  assert_success
  assert_output 'ok'
}

@test "gcp_service_accounts()" {
  source gcp/gcp-credentials.sh
  source test/ENV_GOOGLE_METADATA
  run gcp_service_accounts
  assert_success
  assert_output "{\"aliases\":\"default\",\"email\":\"${GOOGLE_ACCOUNT_EMAIL}\",\"scopes\":\"https://www.googleapis.com/auth/userinfo.email\nhttps://www.googleapis.com/auth/cloud-platform\n\"}"
}

@test "gcp_service_accounts(default)" {
  source gcp/gcp-credentials.sh
  source test/ENV_GOOGLE_METADATA
  run gcp_service_accounts "default"
  assert_success
  assert_output "{\"aliases\":\"default\",\"email\":\"${GOOGLE_ACCOUNT_EMAIL}\",\"scopes\":\"https://www.googleapis.com/auth/userinfo.email\nhttps://www.googleapis.com/auth/cloud-platform\n\"}"
}

@test "gcp_service_accounts(\${GOOGLE_ACCOUNT_EMAIL})" {
  source gcp/gcp-credentials.sh
  source test/ENV_GOOGLE_METADATA
  run gcp_service_accounts "${GOOGLE_ACCOUNT_EMAIL}"
  assert_success
  assert_output "{\"aliases\":\"${GOOGLE_ACCOUNT_EMAIL}\",\"email\":\"${GOOGLE_ACCOUNT_EMAIL}\",\"scopes\":\"https://www.googleapis.com/auth/userinfo.email\nhttps://www.googleapis.com/auth/cloud-platform\n\"}"
}

@test "gcp_identity(https://vault)" {
  source gcp/gcp-credentials.sh
  source test/ENV_GOOGLE_METADATA
  run gcp_identity "https://vault"
  assert_success
  assert_output "${GOOGLE_ID_TOKEN}"
}

@test "gcp-credentials.sh" {
  run gcp/gcp-credentials.sh
  assert_failure 1
  assert_output 'ERROR: This is a library of functions only'
}
