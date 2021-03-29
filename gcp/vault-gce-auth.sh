#!/usr/bin/env bash

# =====
# Credits: none
# =====

# @name vault-gce-auth
# @brief Generate JSON material to log into a Vault Google authentication backend using the instances default identity
# @description
#   <!-- markdownlint-disable-file MD012 -->
#   This script uses the GCE method for logging into a Vault GCP
#   authentication backend.
#
#   ## Usage
#
#   ```bash
#   $ gcp/vault-gce-auth.sh -h
#   usage: gcp/vault-gce-auth.sh [OPTIONS...]
# 
#   Log into Vault from GCE instance
# 
#   OPTIONS:
#     -m  Vault mount               (Default: gcp)
#     -r  Vault role                (REQUIRED)
#     -s  Vault address             (Default: http://vault.example.internal:8200)
# 
#     -h  This help message
#     -v  Verbose mode
#   ```
#
#   ### Vault role
#
#   In google there is no instance profile, therefore the role is a required
#   field. You must provide the '-r' option or use the environment variable
#   $VAULT_ROLE
#
#   ```bash
#   $ gcp/vault-gce-auth.sh -r my-vault-role
#   {
#     "role": "my-vault-role",
#     "http_request_method": "POST",
#     "jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
#   }
#   ```
#
#   ```bash
#   $ export VAULT_ROLE=my-vault-role
#   $ gcp/vault-gce-auth.sh
#   {
#     "role": "my-vault-role",
#     "http_request_method": "POST",
#     "jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
#   }
#   ```
#
#   ### Vault address
#
#   This updates the audience field when generating the JWT portion. You may
#   use either the option (-s) or the environment variable $VAULT_ADDR to set
#   the Vault address
#
#   ```bash
#   $ gcp/vault-gce-auth.sh -r my-vault-role -s https://my-internal-vault.domain.tld
#   {
#     "role": "my-vault-role",
#     "http_request_method": "POST",
#     "jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
#   }
#   ```
#
#   ```bash
#   $ export VAULT_ADDR=https://my-internal-vault.domain.tld
#   $ gcp/vault-gce-auth.sh -r my-vault-role
#   {
#     "role": "my-vault-role",
#     "http_request_method": "POST",
#     "jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
#   }
#   ```
#
#   ### Vault mount
#
#   This updates the audience field when generating the JWT portion. You may
#   use either the option (-m) or the environment variable $VAULT_MOUNT to set
#   the Vault mount
#
#   ```bash
#   $ gcp/vault-gce-auth.sh -r my-vault-role -m gcp
#   {
#     "role": "my-vault-role",
#     "http_request_method": "POST",
#     "jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
#   }
#   ```
#
#   ```bash
#   $ export VAULT_MOUNT=gcp
#   $ gcp/vault-gce-auth.sh -r my-vault-role
#   {
#     "role": "my-vault-role",
#     "http_request_method": "POST",
#     "jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
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

  Log into Vault from GCE instance

  OPTIONS:
    -m  Vault mount        (Default: \$VAULT_MOUNT)
    -r  Vault role         (Default: \$VAULT_ROLE)
    -s  Vault address      (Default: \$VAULT_ADDR)

    -h  This help message
    -v  Verbose mode
  
  NOTES:
    - Options passed to this script will override environment variables
    - If \$VAULT_MOUNT is unset, and '-m' is not used, will default to gcp
    - If \$VAULT_ROLE is unset, and '-r' is not used, script will error
    - If \$VAULT_ADDR is unset, and '-s' is not used, will default to http://vault.example.internal:8200

EOF
}

while getopts "h-v-:m:r:s:" OPTION; do
  case "$OPTION" in
    -)
      case "${OPTARG}" in
        help)
          usage && exit 0 ;;
        *)
          usage && exit 1 ;;
      esac;;
    m)
      VAULT_MOUNT=${OPTARG}
      ;;
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

if [[ -z "${VAULT_ROLE}" ]]; then
  echo "Required option: '-r [VAULT_ROLE]'" >&2
  usage >&2
  exit 1
fi

# shellcheck source=../functions/parse-url.sh disable=1091
source "${_HERE}/../functions/parse-url.sh"

# shellcheck source=gcp-credentials.sh disable=1091
source "${_HERE}/gcp-credentials.sh"

# @description
#   Generates JSON material for login
#
# @noargs
#
# @example
#   $ gcp/vault-gce-auth.sh -r my-vault-role
#   {
#     "role": "my-vault-role",
#     "http_request_method": "POST",
#     "jwt": "[[base64 encoded material]]"
#   }
function vault_gce_auth() {
  local proto host port url
  local jwt vault_addr vault_mount vault_role

  vault_mount="${VAULT_MOUNT:-gcp}"
  vault_role="${VAULT_ROLE:-}"
  vault_addr="${VAULT_ADDR:-http://vault.example.internal:8200}"
  url=$(parse_url "${vault_addr}")

  proto=$(echo "${url}" | sed -n -Ee 's/.*"proto"[[:space:]]*:[[:space:]]*"([a-z0-9]*)".*/\1/p')
  host=$(echo "${url}" | sed -n -Ee 's/.*"host"[[:space:]]*:[[:space:]]*"([a-z0-9\.-]+)".*/\1/p')
  port=$(echo "${url}" | sed -n -Ee 's/.*"port"[[:space:]]*:[[:space:]]*([0-9]*)".*/\1/p')

  [[ "${port}" -eq 80 || "${port}" -eq 443 || -z "${port}" ]] && port="" || port=":${port}"
  vault_role="${vault_role##*/}"

  jwt=$(gcp_identity "${proto}://${host}${port}/auth/${vault_mount}/role/${vault_role}")

  data="$(cat <<-EOJ
{
  "role": "${vault_role}",
  "http_request_method": "POST",
  "jwt": "$(printf '%s' "${jwt}")"
}
EOJ
)"

  #printf '$%s^\n\n' "${data}"
  echo "$data"
}

if [ "${_SELF}" = "vault-gce-auth.sh" ]; then
  set -eu
  vault_gce_auth
fi
