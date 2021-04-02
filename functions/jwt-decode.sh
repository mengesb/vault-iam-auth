#!/usr/bin/env bash

# =====
# Credits:      @stokito
# =====

# @name jwt-decde
# @brief Library for decoding JWT material
# @description
#   <!-- markdownlint-disable-file MD012 MD024 -->
#   This library decodes JWT material

_SELF="${0##*/}"
DEBUG="${DEBUG:-false}"

# @description
#   Parses a base64 padded JWT string
#
# @arg $1 string base64 encoded string
#
# @stdout base64 encoded string with propper padding/terminators
#
# @example
#   $ source functions/jwt-decode.sh
#   $ b64_padding 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
#   eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO=
b64_padding() {
  local base64_string
  local length

  length=$(( ${#1} % 4 ))

  if [ "${length}" -eq 3 ]; then
    base64_string="${1}="
  elif [ "${length}" -eq 2 ]; then
    base64_string="${1}=="
  else
    base64_string="${1}"
  fi

  printf '%s' "${base64_string}"
}

# @description
#   Base64 translate of a JWT encoded string
#
# @arg $1 string base64 encoded string
#
# @stdout base64 encoded string replacing '-_' with '+/'
#
# @example
#   $ source functions/jwt-decode.sh
#   $ b64_tr 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
#   eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz/iiY9eWIs/YNn3Ix1Uil4u2/3Ix1Uil4/2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of/mHMekDQcE3qut3fsxzd/o58VuiiY9/WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9/ho6n7raVq+NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC+NJW33xZFbmiKpJDX/1huD1zrBcRKwzjfS73gmJc/y5ehiJQHWNthO
b64_tr() {
  local base64_string
  local b64

  base64_string="${1}"

  b64=$(b64_padding "${base64_string}" | tr -- '-_' '+/')

  printf '%s' "${b64}"
}

# @description
#   Parses JSON string and returns value of key requested
#
# @arg $1 string JSON string
# @arg $2 string key
#
# @stdout value of key searched for, or 'null' if not found
#
# @example
#   $ source functions/jwt-decode.sh
#   $ json_kv '{"alg":"RS256","kid":"1234567890abcdef01234567890abcdef1234567","typ":"JWT"}' alg
#   RS256
json_kv() {
  local json_string key
  local response

  json_string="${1}"
  key="${2}"

  # Search for string first

  if command -v jq >/dev/null; then
    response=$(printf '%s' "${json_string}" | jq -r .[\""${key}"\"])
  else
    # Search for a string first
    response=$(printf '%s' "${json_string}" | sed -n -Ee "s/.*\"${key}\"[[:space:]]*:[[:space:]]*\"([^\"]+)\".*/\1/p")
    
    # Search for a boolean if length of response == 0
    [[ "${#response}" -eq 0 ]] && response=$(printf '%s' "${json_string}" | sed -n -Ee "s/.*\"${key}\"[[:space:]]*:[[:space:]]*(true|false).*/\1/p")

    # Search for an integer if length of response == 0
    [[ "${#response}" -eq 0 ]] && response=$(printf '%s' "${json_string}" | sed -n -Ee "s/.*\"${key}\"[[:space:]]*:[[:space:]]*(\-?[0-9]+).*/\1/p")
  fi

  # Return value, or null if length of response == 0 
  [[ "${#response}" -eq 0 ]] && echo "null" || echo "${response}"
}

# @description
#   Google OAuth2 public key signature fetch
#
# @arg $1 string key id (kid)
#
# @stdout File containing public key material
#
# @example
#   $ source functions/jwt-decode.sh
#   $ google_pubkey '13e8d45a43cb2242154c7f4dafac2933fea20374'
#   /path/to/tmp.signature.file
google_pubkey() {
  local kid
  local crt json url

  kid="${1}"
  json="$(mktemp)"
  crt="$(mktemp)"
  sig="$(mktemp)"

  url='https://www.googleapis.com/oauth2/v1/certs'

  curl -s "${url}" -o "${json}"
  json_kv "$(cat "${json}")" "${kid}" > "${crt}"
  rm -f "${json}"

  openssl x509 -pubkey -in "${crt}" -noout > "${sig}"
  rm -f "${crt}"

  echo "${sig}"
}

# @description
#   Google OAuth2 veriification of JWT header + payload (i.e. body) with
#   signature
#
# @arg $1 string JWT material
#
# @stdout Message indicating success or failure of JWT verification
#
# @example
#   $ source functions/jwt-decode.sh
#   $ google_verify 'eyJhbGciOiJSUzI1NiIsI....gmJc_y5ehiJQHWNthO'
#   Verified OK
google_verify() {
  local jwt_header_url jwt_payload_url jwt_signature_url
  local jwt_body jwt_header jwt_payload jwt_signature
  local pubkey kid sig response

  IFS='.' read -r jwt_header_url jwt_payload_url jwt_signature_url <<< "$@"

  jwt_body=$(printf '%s.%s' "${jwt_header_url}" "${jwt_payload_url}")
  jwt_header=$(b64_tr "${jwt_header_url}" | base64 -d)
  jwt_payload=$(b64_tr "${jwt_payload_url}" | base64 -d)
  jwt_signature=$(b64_tr "${jwt_signature_url}")

  kid=$(json_kv "${jwt_header}" kid)
  pubkey=$(google_pubkey "${kid}")
  sig=$(mktemp)

  printf '%s' "${jwt_signature}" | base64 -d > "${sig}"
  response=$(printf '%s' "${jwt_body}" | openssl dgst -sha256 -verify "${pubkey}" -signature "${sig}")
  rm -f "${pubkey}"
  rm -f "${sig}"

  echo "${response}"
}

# @description
#   Parses JWT material and returns decoded JWT header
#
# @arg $1 string JWT material
#
# @stdout base64 decoded JWT header
#
# @example
#   $ source functions/jwt-decode.sh
#   $ jwt_header_json 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
#   {"alg":"RS256","kid":"1234567890abcdef01234567890abcdef1234567","typ":"JWT"}
jwt_header_json() {
  local jwt_material header_url
  local response

  jwt_material="$*"

  IFS='.' read -r header_url _ _ <<< "${jwt_material}"

  response=$(b64_tr "${header_url}" | base64 -d)

  echo "${response}"
}

# @description
#   Parses JWT material and returns decoded JWT payload
#
# @arg $1 string JWT material
#
# @stdout base64 decoded JWT payload
#
# @example
#   $ source functions/jwt-decode.sh
#   $ jwt_payload_json 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
#   {"iss":"accounts.google.com","azp":"123456789012-1234567890abcdefghijklmnopqrstuvw.apps.googleusercontent.com","aud":"123456789012-1234567890abcdefghijklmnopqrstuvw.apps.googleusercontent.com","sub":"123456789012345678901","email":"mock@google.com","email_verified":true,"at_hash":"1234567890abc-DEFGHIJKL","iat":1617342363,"exp":1617345963,"jti":"1234567890abcdef1234567890abcdef12345678"}
jwt_payload_json() {
  local jwt_material payload_url
  local response

  jwt_material="$*"

  IFS='.' read -r _ payload_url _ <<< "${jwt_material}"

  response=$(b64_tr "${payload_url}" | base64 -d)

  echo "${response}"
}

# @description
#   Parses JWT material and returns environment variables
#
# @arg $1 string JWT material
#
# @stdout Environment variable export commands for JWT materal components
#
# @example
#   $ functions/jwt-decode.sh 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
#   export JWT_HEADER='{"alg":"RS256","kid":"1234567890abcdef01234567890abcdef1234567","typ":"JWT"}'
#   export JWT_ALGORITHM=RS256
#   ...
jwt_display() {
  local jwt_material
  local jwt_header jwt_header_url jwt_payload jwt_payload_url jwt_signature jwt_signature_url

  jwt_material="$*"

  IFS='.' read -r jwt_header_url jwt_payload_url jwt_signature_url <<< "${jwt_material}"

  jwt_header=$(b64_tr "${jwt_header_url}" | base64 -d)
  jwt_payload=$(b64_tr "${jwt_payload_url}" | base64 -d)
  jwt_signature=$(b64_tr "${jwt_signature_url}")

  cat <<EOJWT
export JWT_HEADER='${jwt_header}'
export JWT_ALGORITHM="$(json_kv "${jwt_header}" alg)"
export JWT_KID="$(json_kv "${jwt_header}" kid)"
export JWT_TYP="$(json_kv "${jwt_header}" typ)"
export JWT_PAYLOAD='${jwt_payload}'
export JWT_ISS=$(json_kv "${jwt_payload}" iss)
export JWT_AZP=$(json_kv "${jwt_payload}" azp)
export JWT_AUD=$(json_kv "${jwt_payload}" aud)
export JWT_SUB=$(json_kv "${jwt_payload}" sub)
export JWT_EMAIL=$(json_kv "${jwt_payload}" email)
export JWT_EMAIL_VERIFIED=$(json_kv "${jwt_payload}" email_verified)
export JWT_AT_HASH=$(json_kv "${jwt_payload}" at_hash)
export JWT_IAT=$(json_kv "${jwt_payload}" iat)
export JWT_EXP=$(json_kv "${jwt_payload}" exp)
export JWT_JTI=$(json_kv "${jwt_payload}" jti)
export JWT_SIGNATURE='${jwt_signature}'
export JWT_VERIFY=$(google_verify "${jwt_material}")
EOJWT
}

if [ "${_SELF}" = "jwt-decode.sh" ]; then
  set -eu
  [[ "$#" -eq 0 ]] && echo "ERROR: Must provide a JWT string to parse" >&2 && exit 1
  [[ "$#" -ne 1 ]] && echo "ERROR: Only one JWT string may be given" >&2 && exit 1
  jwt_display "$@"
fi
