#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup_file() {
  ec2-metadata-mock -n 127.0.0.1 > /dev/null 3>&- &
  export EC2_METADATA_MOCK=http://127.0.0.1:1338/latest/meta-data
}

function teardown_file() {
  #pkill ec2-metadata-mock
  unset EC2_METADATA_MOCK
}

@test "Requirements: ec2-metadata-mock running" {
  run curl -sS http://127.0.0.1:1338/latest/meta-data
  assert_success
}

@test "aws_instance_profile_arn()" {
  source aws/aws-credentials.sh
  run aws_instance_profile_arn
  assert_success
  assert_output --regexp '^arn:aws:iam::[0-9]+:instance-profile/[a-zA-Z0-9_\+=,\.@\-]+$'
}

@test "aws_instance_profile_name()" {
  source aws/aws-credentials.sh
  run aws_instance_profile_name
  assert_success
  assert_output 'baskinc-role'
}

@test "aws_credentials()" {
  source aws/aws-credentials.sh
  run aws_credentials
  assert_success
  assert_output --regexp '^\{'
  assert_output --regexp '"Code": "Success",'
  assert_output --regexp '"LastUpdated": "[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z",'
  assert_output --regexp '"Type": "AWS-HMAC",'
  assert_output --regexp '"AccessKeyId": "[A-Z0-9]+",'
  assert_output --regexp '"SecretAccessKey": "[a-zA-Z0-9_\+=,\.@/\-]+",'
  assert_output --regexp '"Expiration": "[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z"'
  assert_output --regexp '}$'
}

@test "aws_access_key_id()" {
  source aws/aws-credentials.sh
  run aws_access_key_id
  assert_success
  assert_output --regexp '^[A-Z0-9]+$'
}

@test "aws_secret_access_key()" {
  source aws/aws-credentials.sh
  run aws_secret_access_key
  assert_success
  assert_output --regexp '^[a-zA-Z0-9_\+=,\.@/\-]+$'
}

@test "aws_session_token()" {
  source aws/aws-credentials.sh
  run aws_session_token
  assert_success
  assert_output --regexp '^[a-zA-Z0-9_\+=,\.@/\-]+$'
}

@test "aws-credentials.sh - aws_environment()" {
  run aws/aws-credentials.sh
  assert_success
  assert_equal "${lines[0]}" "export AWS_ACCESS_KEY_ID=12345678901"
  assert_equal "${lines[1]}" "export AWS_SECRET_ACCESS_KEY=v/12345678901"
  assert_equal "${lines[2]}" "export AWS_SESSION_TOKEN=TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T=="
}
