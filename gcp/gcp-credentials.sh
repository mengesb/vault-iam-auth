#!/usr/bin/env bash
# =====
# Credits:
# =====

# @name gcp-credentials
# @brief Query GCP metadata service for information
# @description
#   <!-- markdownlint-disable-file MD012 MD024 -->
#   When sourced as a library, this provides functions to get various bits of
#   information from the GCP metadata service. When operating as a script, it
#   will output common environment variables used for GCP tools
#
#   This code handles environments where `jq` may not be available.

_SELF="${0##*/}"
DEBUG="${DEBUG:-false}"
METADATA="${GCE_METADATA_MOCK:-http://metadata.google.internal}"
HEADERS=("Metadata-Flavor: Google")
DATA_URLENCODE=("format=full")

[[ -n "${GCE_METADATA_MOCK}" ]] && HEADERS+=("Host: metadata.google.internal")

# @description
#   Builds headers for curl requests from HEADERS environment variable
#
# @noarg
#
# @example
#   $ source gcp/gcp-credentials.sh
#   $ headers
#   -H 'Metadata-Flavor: Google'
function headers() {
  local heads

  heads=''

  for ITEM in "${HEADERS[@]}"; do
    [[ -z "${heads}" ]] && heads="-H \"${ITEM}\"" || heads="-H \"${ITEM}\" ${heads}"
  done

  heads=$(echo "${heads}" | awk '{$1=$1};1')
  echo "${heads}"
}

# @description
#   Builds url encoding commands for curl requests
#
# @arg $1 string Data to encode in URL safe format
#
# @example
#   $ source gcp/gcp-credentials.sh
#   $ url_encode
#   --data-urlencode 'format=full'
#   $ url_encode "audience=https://vault"
#   --data-urlencode 'format=full' --data-urlencode 'audience=https://vault'
function url_encode() {
  local urlencode

  urlencode=''

  for ITEM in "${DATA_URLENCODE[@]}"; do
    [[ -z "${urlencode}" ]] && urlencode="--data-urlencode \"${ITEM}\"" || urlencode="--data-urlencode \"${ITEM}\" ${urlencode}"
  done

  urlencode=$(echo "${urlencode}" | awk '{$1=$1};1')
  echo "${urlencode}"
}

# @description
#   Returns a GCE instance identity (JWT token) for the audience requested
#
# @arg $1 string Audience to request JWT token for
#
# @example
#   $ source gcp/gcp-credentials.sh
#   $ gcp_identity "https://vault"
#   eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3ODkwYWJjZGVmMTIzNDU2NzgiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvby5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImVtYWlsIjoibW9ja0Bmb28uaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZXhwIjoxNjE2OTI4NTgwLCJpYXQiOjE2MTY5MjQ5ODAsImlzcyI6Imh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbSIsInN1YiI6IjEyMzQ1Njc4OTAxMjM0NTY3ODkwMQI.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO
function gcp_identity() {
  local audience
  local encode heads

  audience="audience=${1}"
  DATA_URLENCODE+=("${audience}")

  encode=$(url_encode)
  heads=$(headers)

  eval curl -sG "${heads}" "${encode}" "${METADATA}/computeMetadata/v1/instance/service-accounts/default/identity"
}

# @description
#   TBD
#
# @arg $1 string Audience to request JWT token header
#
# @example
#   TBD
function gcp_jwt_header() {
  local audience
  local identity jwt_header

  audience="audience=${1}"
  identity=$(gcp_identity "${audience}")

  jwt_header=$(echo "${identity}" | cut -d. -f1)
  jwt_header="${jwt_header}=="

  echo -n  "${jwt_header}" | base64 -d
}

# @description
#   Returns information about a service accunt, or the default if none passed
#
# @arg $1 string Google Service Account (Default: default)
#
# @example
#   $ source gcp/gcp-credentials.sh
#   $ gcp_service_accounts
#   {"aliases":"default","email":"mock@foo.iam.gserviceaccount.com","scopes":"https://www.googleapis.com/auth/userinfo.email\nhttps://www.googleapis.com/auth/cloud-platform\n"}
#   $ gcp_service_accounts "default"
#   {"aliases":"default","email":"mock@foo.iam.gserviceaccount.com","scopes":"https://www.googleapis.com/auth/userinfo.email\nhttps://www.googleapis.com/auth/cloud-platform\n"}
function gcp_service_accounts() {
  local serviceAccount
  local heads

  serviceAccount="${1:-default}"

  heads=$(headers)

  eval curl -sG "${heads}" "${METADATA}/computeMetadata/v1/instance/service-accounts/${serviceAccount}/"
}

if [ "${_SELF}" = "gcp-credentials.sh" ]; then
  set -eu
  echo "ERROR: This is a library of functions only" >&2
  exit 1
fi
