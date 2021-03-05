#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function x-amz-date() {
  printf '%s' '20210305T101511Z'
}

function iam-request-body() {
  printf '%s' "Action=GetCallerIdentity&Version=2011-06-15"
}

function header-host() {
  printf '%s' "https://sts.amazon.com/"
}

@test "AWS4_HMAC_SHA256()" {
  source aws/aws4-sign.sh
  result=$(x-amz-date | AWS4_HMAC_SHA256 key:AWS4v/12345678901)
  status=$?
  [ "$status" -eq 0 ]
  [ "$result" == "85a5ccedca708816e0367679b9b7d239b2ff0c0a974d970b76d75949c1132a93" ]
}

@test "AWS4_SHA256()" {
  source aws/aws4-sign.sh
  result=$(iam-request-body | AWS4_SHA256)
  status=$?
  [ "$status" -eq 0 ]
  [ "$result" == "ab821ae955788b0e33ebd34c208442ccfc2d406e2edc5e7a39bd6458fbb4f843" ]
}

@test "AWS4_BASE64()" {
  source aws/aws4-sign.sh
  result=$(header-host | AWS4_BASE64)
  status=$?
  [ "$status" -eq 0 ]
  [ "$result" == "aHR0cHM6Ly9zdHMuYW1hem9uLmNvbS8=" ]
}

@test "AWS4_SIGN()" {
  source aws/aws4-sign.sh
  run AWS4_SIGN v/12345678901 20210305 us-east-1 sts 'AWS4-HMAC-SHA256
20210305T053255Z
20210305/us-east-1/sts/aws4_request
a4705172e527bf6592c29d3efbf506be7b9bf05a6bcbe67e1cfeeee4c7ea5a48'
  [ "$status" -eq 0 ]
  [ "$output" == "358c2062761b64cdc791ce801b7aaf994fb83ac79e28025111fc5853f67176c8" ]
}

@test "aws-sign.sh" {
  run aws/aws4-sign.sh
  assert_failure
  [ "$status" -eq 1 ]
  [ "$output" == "ERROR: This is a library of functions only" ]
}
