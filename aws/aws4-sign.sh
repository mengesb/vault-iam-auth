#!/usr/bin/env bash
# =====
# Credits: @inkblot
# =====

# @name aws4-sign
# @brief Library for producing AWS v4 Signatures
# @description
#   <!-- markdownlint-disable-file MD012 MD024 -->
#   This library builds an AWS signature version 4 compatible request

_SELF="${0##*/}"
DEBUG="${DEBUG:-false}"

# @description
#   Generates a HMAC SHA256 digest with date and AWS_SECRET_ACCESS_KEY
#
# @noarg
#
# @example
#   $ source aws/aws4-sign.sh
#   $ printf '%s' $(TZ=Z date +%Y%m%dT%H%M%SZ) | AWS4_HMAC_SHA256 "key:AWS4v/12345678901" # AWS_SECRET_ACCESS_KEY
#   79ee5040070df9e44dcf8311c8c39f1e80ad2129427203922bd843d0e5a4a246
function AWS4_HMAC_SHA256() {
  openssl dgst -sha256 -hex -mac HMAC -macopt "$1" 2>/dev/null | awk '{print $2}'
}

# @description
#   Generates a SHA256 digest of the iam_request_body
#
# @noarg
#
# @example
#   $ source aws/aws4-sign.sh
#   $ printf '%s' "Action=GetCallerIdentity&Version=2011-06-15" | AWS4_SHA256
#   ab821ae955788b0e33ebd34c208442ccfc2d406e2edc5e7a39bd6458fbb4f843
function AWS4_SHA256() {
  openssl dgst -sha256 -hex 2>/dev/null | awk '{print $2}'
}

# @description
#   Encodes a string to base64
#
# @noarg
#
# @example
#   $ source aws/aws4-sign.sh
#   $ printf '%s' "https://sts.amazon.com/" | AWS4_BASE64
#   aHR0cHM6Ly9zdHMuYW1hem9uLmNvbS8=
function AWS4_BASE64() {
  openssl base64 -A
}

# @description
#   Generate a full AWS Signature v4 string
#
# @arg $1 string AWS Secret Access Key
# @arg $2 string Date as output by `+%Y%m%d`
# @arg $3 string AWS Region (`us-east-1`)
# @arg $4 string sts
# @arg $5 string Signed string material - Auth type, X-Amz-Date (`+%Y%m%dT%H%M%SZ`), credential scope and canonical request maintaining newlines
#
# @example
#   $ source aws/aws4-sign.sh
#   $ AWS4_SIGN v/12345678901 20210305 us-east-1 sts 'AWS4-HMAC-SHA256
#   20210305T053255Z
#   20210305/us-east-1/sts/aws4_request
#   a4705172e527bf6592c29d3efbf506be7b9bf05a6bcbe67e1cfeeee4c7ea5a48'
#   358c2062761b64cdc791ce801b7aaf994fb83ac79e28025111fc5853f67176c8
function AWS4_SIGN() {
  local kSecret kDate kRegion kService kSigning signedString
  
  kSecret="AWS4$1"
  kDate=$(printf '%s' "$2" | AWS4_HMAC_SHA256 "key:${kSecret}")
  kRegion=$(printf '%s' "$3" | AWS4_HMAC_SHA256 "hexkey:${kDate}")
  kService=$(printf '%s' "$4" | AWS4_HMAC_SHA256 "hexkey:${kRegion}")
  kSigning=$(printf '%s' "aws4_request" | AWS4_HMAC_SHA256 "hexkey:${kService}")
  signedString=$(printf '%s' "$5" | AWS4_HMAC_SHA256 "hexkey:${kSigning}")
  printf '%s' "${signedString}"
}

if [ "${_SELF}" = "aws4-sign.sh" ]; then
  set -eu
  echo "ERROR: This is a library of functions only" >&2
  exit 1
fi
