#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup_file() {
  ec2-metadata-mock -n 127.0.0.1 > /dev/null 2>&1 &
  export EC2_METADATA_MOCK=http://127.0.0.1:1338/latest/meta-data
}

function teardown_file() {
  pkill ec2-metadata-mock
  unset EC2_METADATA_MOCK
}

@test "Requirements: ec2-metadata-mock running" {
  run curl -s http://127.0.0.1:1338/latest/meta-data
  [ "$status" -eq 0 ]
}

@test "aws_instance_profile_arn()" {
  source aws/aws-credentials.sh
  run aws_instance_profile_arn
  [ "$status" -eq 0 ]
  [ "$output" == "arn:aws:iam::896453262835:instance-profile/baskinc-role" ]
  [[ "$output" =~ ^arn:aws:iam::[0-9]+:instance-profile/[a-zA-Z0-9_\+=,\.@\-]+$ ]]
}

@test "aws_instance_profile_name()" {
  source aws/aws-credentials.sh
  run aws_instance_profile_name
  [ "$status" -eq 0 ]
  [ "$output" == "baskinc-role" ]
}

@test "aws_credentials()" {
  source aws/aws-credentials.sh
  run aws_credentials

  [ "$status" -eq 0 ]
  [ "${lines[0]}" == "{" ]
  [[ "${lines[1]}" =~ \"Code\":\ \"Success\",$ ]]
  [[ "${lines[2]}" =~ \"LastUpdated\":\ \"[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z\",$ ]]
  [[ "${lines[3]}" =~ \"Type\":\ \"AWS-HMAC\",$ ]]
  [[ "${lines[4]}" =~ \"AccessKeyId\":\ \"[A-Z0-9]+\",$ ]]
  [[ "${lines[5]}" =~ \"SecretAccessKey\":\ \"[a-zA-Z0-9_\+=,\.@/\-]+\",$ ]]
  [[ "${lines[6]}" =~ \"Token\":\ \"[a-zA-Z0-9_\+=,\.@/\-]+\",$ ]]
  [[ "${lines[7]}" =~ \"Expiration\":\ \"[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z\"$ ]]
  [ "${lines[8]}" == "}" ]
}

@test "aws_access_key_id()" {
  source aws/aws-credentials.sh
  run aws_access_key_id
  [ "$status" -eq 0 ]
  [ "$output" == "12345678901" ]
}

@test "aws_secret_access_key()" {
  source aws/aws-credentials.sh
  run aws_secret_access_key
  [ "$status" -eq 0 ]
  [ "$output" == "v/12345678901" ]
}

@test "aws_session_token()" {
  source aws/aws-credentials.sh
  run aws_session_token
  [ "$status" -eq 0 ]
  [ "$output" == "TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T==" ]
}

@test "aws-credentials.sh - aws_environment()" {
  run aws/aws-credentials.sh
  [ "$status" -eq 0 ]
  [ "${lines[0]}" == "export AWS_ACCESS_KEY_ID=12345678901" ]
  [ "${lines[1]}" == "export AWS_SECRET_ACCESS_KEY=v/12345678901" ]
  [ "${lines[2]}" == "export AWS_SESSION_TOKEN=TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T==" ]
}
