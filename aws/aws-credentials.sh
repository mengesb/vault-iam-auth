#!/usr/bin/env bash
# =====
# Credits: @inkblot
# =====

# @name aws-credentials
# @brief Query AWS EC2 metadata service for information
# @description
#   <!-- markdownlint-disable-file MD012 MD024 -->
#   When sourced as a library, this provides functions to get various bits of
#   information from the AWS EC2 instance metadata service. When operating as
#   a script, it will output common environment variables used for AWS tools
#
#   This code handles environments where `jq` may not be available.

_SELF="${0##*/}"
DEBUG="${DEBUG:-false}"
METADATA="${EC2_METADATA_MOCK:-http://169.254.169.254/2020-10-27/meta-data}"

# @description
#   Acquires your instance profile ARN from the metadata API
#
# @example
#   $ source aws/aws-credentials.sh
#   $ aws_instance_profile_arn
#   arn:aws:iam::896453262835:instance-profile/baskinc-role
function aws_instance_profile_arn() {
  if command -v jq >/dev/null; then
    curl -s "${METADATA}/iam/info" | jq -r .InstanceProfileArn
  else
    curl -s "${METADATA}/iam/info" | sed -n -Ee 's/^[[:space:]]*"InstanceProfileArn": "(arn:aws:iam::[0-9]+:.*)",/\1/p'
  fi
}

# @description
#   Acquires your profile name from aws_instance_profile_arn() function
#
# @example
#   $ source aws/aws-credentials.sh
#   $ aws_instance_profile_name
#   baskinc-role
function aws_instance_profile_name() {
  aws_instance_profile_arn | sed -e 's/.*\///'
}

# @description
#   Acquires your security credentials for your AWS instance profile
#
# @example
#   $ source aws/aws-credentials.sh
#   $ aws_credentials
#   {
#           "Code": "Success",
#           "LastUpdated": "2020-04-02T18:50:40Z",
#           "Type": "AWS-HMAC",
#           "AccessKeyId": "12345678901",
#           "SecretAccessKey": "v/12345678901",
#           "Token": "TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T==",
#           "Expiration": "2020-04-02T00:49:51Z"
#   }
function aws_credentials() {
  curl -s "${METADATA}/iam/security-credentials/$(aws_instance_profile_name)"
}

# @description
#   Acquires your AWS Access Key ID from aws_credentials() function
#
# @example
#   $ source aws/aws-credentials.sh
#   $ aws_access_key_id
#   12345678901
function aws_access_key_id() {
  if command -v jq > /dev/null; then
    aws_credentials | jq -r .AccessKeyId
  else
    aws_credentials | sed -n -Ee 's/^[[:space:]]*"AccessKeyId": "(.*)",/\1/p'
  fi
}

# @description
#   Acquires your AWS Secret Access Key from aws_credentials() function
#
# @example
#   $ source aws/aws-credentials.sh
#   $ aws_secret_access_key
#   v/12345678901
function aws_secret_access_key() {
  if command -v jq >/dev/null; then
    aws_credentials | jq -r .SecretAccessKey
  else
    aws_credentials | sed -n -Ee 's/^[[:space:]]*"SecretAccessKey": "(.*)",/\1/p'
  fi
}

# @description
#   Acquires your AWS Session Token from aws_credentials() function
#
# @example
#   $ source aws/aws-credentials.sh
#   $ aws_session_token
#   TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T==
function aws_session_token() {
  if command -v jq >/dev/null; then
    aws_credentials | jq -r .Token
  else
    aws_credentials | sed -n -Ee 's/^[[:space:]]*"Token": "(.*)",/\1/p'
  fi
}

# @description
#   Outputs environment variable exports for your AWS credentials
#
# @example
#   $ aws/aws-credentials.sh
#   export AWS_ACCESS_KEY_ID=12345678901
#   export AWS_SECRET_ACCESS_KEY=v/12345678901
#   export AWS_SESSION_TOKEN=TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T==
function aws_environment() {
  cat <<EOS
export AWS_ACCESS_KEY_ID=$(aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws_secret_access_key)
export AWS_SESSION_TOKEN=$(aws_session_token)
EOS
}

if [ "${_SELF}" = "aws-credentials.sh" ]; then
  set -eu
  aws_environment
fi
