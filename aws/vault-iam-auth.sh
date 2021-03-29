#!/usr/bin/env bash

# =====
# Credits: @inkblot
# =====

# @name vault-iam-auth
# @brief Generate JSON material to log into a Vault AWS authentication backend using the instances AWS IAM instance profile
#
# @noarg
#
# @description
#   <!-- markdownlint-disable-file MD012 -->
#   This script uses the AWS IAM method for logging into a Vault AWS
#   authentication backend.
#
#   ## Usage
#
#   ```bash
#   $ aws/vault-iam-auth.sh -h
#   usage: aws/vault-iam-auth.sh [OPTIONS...]
# 
#   Log into Vault using AWS IAM profile
# 
#   OPTIONS:
#     -r  Vault role                (Default: [INSTANCE_PROFILE_NAME])
#     -s  Vault address             (Default: http://vault.example.internal:8200)
# 
#     -h  This help message
#     -v  Verbose mode
#   ```
#
#   ### role
#
#   If your instance doesn't use the same role name as the role you're using
#   in your vault instance, you'll have to pass the `-r` option to specify a
#   different role
#
#   ```bash
#   $ aws/vault-iam-auth.sh -r my-vault-role
#   {
#     "role": "my-vault-role",
#     "iam_http_request_method": "POST",
#     "iam_request_url": "aHR0cHM6Ly9zdHMuYW1hem9uYXdzLmNvbS8=",
#     "iam_request_body": "QWN0aW9uPUdldENhbGxlcklkZW50aXR5JlZlcnNpb249MjAxMS0wNi0xNQ==",
#     "iam_request_headers": "ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MTQ1MloiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbInZhdWx0LXVzLWVhc3QtMS5hbmFwbGFuLmlvIl0sCiAgIkF1dGhvcml6YXRpb24iOiBbIkFXUzQtSE1BQy1TSEEyNTYgQ3JlZGVudGlhbD0xMjM0NTY3ODkwMS8yMDIxMDMwNS91cy1lYXN0LTEvc3RzL2F3czRfcmVxdWVzdCwgU2lnbmVkSGVhZGVycz1jb250ZW50LXR5cGU7aG9zdDt4LWFtei1kYXRlO3gtYW16LXNlY3VyaXR5LXRva2VuO3gtdmF1bHQtYXdzLWlhbS1zZXJ2ZXItaWQsIFNpZ25hdHVyZT1mM2IwZjVkMmE4MWMwNjllYmRkN2UzNThmNDQ3ZjJlYWVhNDJhYjE5ZWRiYmRmY2M2ZTUxNGFjMWJlMDg5ZTRmIl0KfQ=="
#   }
#   ```
#
#   ### server
#
#   If your instance doesn't use the same role name as the role you're using
#   in your vault instance, you'll have to pass the `-r` option to specify a
#   different role
#
#   ```bash
#   $ aws/vault-iam-auth.sh -s https://my-internal-vault.domain.tld
#   {
#     "role": "[INSTANCE_PROFILE_NAME]",
#     "iam_http_request_method": "POST",
#     "iam_request_url": "aHR0cHM6Ly9zdHMuYW1hem9uYXdzLmNvbS8=",
#     "iam_request_body": "QWN0aW9uPUdldENhbGxlcklkZW50aXR5JlZlcnNpb249MjAxMS0wNi0xNQ==",
#     "iam_request_headers": "ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjhmYWIiXQp9"
#   }
#   ```

_SELF="${0##*/}"
_HERE="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
DEBUG="${DEBUG:-false}"

# @internal
function usage() {
  # Help message
  cat <<EOF
  usage: $0 [OPTIONS...]

  Log into Vault using AWS IAM profile

  OPTIONS:
    -r  Vault role         (Default: \$VAULT_ROLE)
    -s  Vault address      (Default: \$VAULT_ADDR)

    -h  This help message
    -v  Verbose mode
  
  NOTES:
    - Options passed to this script will override environment variables
    - If \$VAULT_ROLE is unset, and '-r' is not used, will attempt to detect and AWS Instance profile
    - If \$VAULT_ADDR is unset, and '-s' is not used, will default to http://vault.example.internal:8200

EOF
}

while getopts "h-v-:r:s:" OPTION; do
  case "$OPTION" in
    -)
      case "${OPTARG}" in
        help)
          usage && exit 0 ;;
        *)
          usage && exit 1 ;;
      esac;;
    r)
      VAULT_ROLE=${OPTARG}
      ;;
    s)
      VAULT_ADDR=${OPTARG}
      ;;
    h)
      usage >&2
      exit 0
      ;;
    v)
      DEBUG=true
      set -x
      ;;
    \?)
      echo "Unknown option: -$OPTARG" >&2
      usage >&2
      exit 1
      ;;
    :)
      echo "Missing option argument for -$OPTARG" >&2
      usage >&2
      exit 1
      ;;
    *)
      echo "Unimplemented option: -$OPTARG" >&2
      usage >&2
      exit 1
      ;;
  esac
done

# shellcheck source=../functions/parse-url.sh disable=1091
source "${_HERE}/../functions/parse-url.sh"

# shellcheck source=aws-credentials.sh disable=1091
source "${_HERE}/aws-credentials.sh"

# shellcheck source=aws4-sign.sh disable=1091
source "${_HERE}/aws4-sign.sh"

# @description
#   Generates JSON material for login
#
# @noarg
#
# @example
#   $ aws/vault-iam-auth.sh -r my-vault-role
#   {
#     "role": "my-vault-role",
#     "iam_http_request_method": "POST",
#     "iam_request_url": "[[base64 encoded material]]",
#     "iam_request_body": "[[base64 encoded material]]",
#     "iam_request_headers": "[[base64 encoded material]]"
#   }
#
# @noargs
function vault_iam_auth() {
  local amz_date auth_type authorization aws_access_key_id
  local aws_instance_profile_name aws_secret_access_key aws_session_token
  local canonical_request content_type credential_scope data iam_request_body
  local iam_request_headers iam_request_host iam_request_url signature
  local signed_headers signed_string vault_addr vault_host vault_role

  aws_instance_profile_name="$(aws_instance_profile_name)"

  #vault_role="$1"
  vault_role="${VAULT_ROLE:-${aws_instance_profile_name}}"
  vault_addr="${VAULT_ADDR:-http://vault.example.internal:8200}"

  aws_access_key_id="$(aws_access_key_id)"
  aws_secret_access_key="$(aws_secret_access_key)"
  aws_session_token="$(aws_session_token)"
  vault_host=$(parse_url "${vault_addr}" | grep -Eo '"host": "([a-zA-Z0-9\.:-]+)",' | sed 's/"host": "//g;s/",//g')

  auth_type="AWS4-HMAC-SHA256"
  amz_date=$(TZ=Z date +%Y%m%dT%H%M%SZ)
  content_type="application/x-www-form-urlencoded charset=utf-8"
  iam_request_body="Action=GetCallerIdentity&Version=2011-06-15"
  iam_request_host="sts.amazonaws.com"
  iam_request_url="https://${iam_request_host}/"
  signed_headers="content-type;host;x-amz-date;x-amz-security-token;x-vault-aws-iam-server-id"
  canonical_request="$(cat <<EOR
POST
/

content-type:${content_type}
host:${iam_request_host}
x-amz-date:${amz_date}
x-amz-security-token:${aws_session_token}
x-vault-aws-iam-server-id:${vault_host}

${signed_headers}
$(printf '%s' "${iam_request_body}" | AWS4_SHA256)
EOR
)"

  credential_scope="${amz_date:0:8}/us-east-1/sts/aws4_request"
  signed_string="$(cat <<EOS
${auth_type}
${amz_date}
${credential_scope}
$(printf '%s' "${canonical_request}" | AWS4_SHA256)
EOS
)"

  [[ "${DEBUG}" == true ]] && printf 'signed_string: $%s^\n\n' "${signed_string}" 1>&2

  signature=$(AWS4_SIGN "${aws_secret_access_key}" "${amz_date:0:8}" "us-east-1" "sts" "${signed_string}")
  authorization="${auth_type} Credential=${aws_access_key_id}/${credential_scope}, SignedHeaders=${signed_headers}, Signature=${signature}"

  iam_request_headers="$(cat <<EOH
{
  "Content-Type": ["${content_type}"],
  "Host": ["${iam_request_host}"],
  "X-Amz-Date": ["${amz_date}"],
  "X-Amz-Security-Token": ["${aws_session_token}"],
  "X-Vault-AWS-IAM-Server-Id": ["${vault_host}"],
  "Authorization": ["${authorization}"]
}
EOH
)"

  data="$(cat <<-EOJ
{
  "role": "${vault_role}",
  "iam_http_request_method": "POST",
  "iam_request_url": "$(printf '%s' "${iam_request_url}" | AWS4_BASE64)",
  "iam_request_body": "$(printf '%s' "${iam_request_body}" | AWS4_BASE64)",
  "iam_request_headers": "$(printf '%s' "${iam_request_headers}" | AWS4_BASE64)"
}
EOJ
)"

  #printf '$%s^\n\n' "${data}"
  echo "$data"
}

if [ "${_SELF}" = "vault-iam-auth.sh" ]; then
  set -eu
  vault_iam_auth
fi
