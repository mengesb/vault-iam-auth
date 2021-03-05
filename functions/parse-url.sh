#!/usr/bin/env bash

# =====
# Credits:      @inkblot
# =====

# @name parse-url
# @brief Parse a URL into components
# @description
#   <!-- markdownlint-disable-file MD004 MD012 -->
#   Will take an URL as an input, and break it into the following components:
#
#   - protocol
#   - host
#   - port
#   - username
#   - password
#   - path
#   - query_string

_SELF="${0##*/}"
DEBUG="${DEBUG:-false}"

# @description
#   Parse URL string
#
# @arg $1 string URL
#
# @stdout JSON structure keyed on URL components
#
# @example
#   $ functions/parse-url.sh https://my.vault.internal
#   { "proto": "https", "host": "my.vault.internal", "port": 443, "username": "", "password": "", "path": "", "query_string": "" }
function parse_url() {
  local url _url __url proto uphp user_pass host_port user pass host port path query_string

  url="${1}"

  proto="${url%://*}" # proto: everything up to the first '://'
  # There should definitely be a proto, neither empty nor equal to url
  if [ "${proto}" == "" ] || [ "${proto}" == "$url" ]; then
    echo "Invalid url: ${url}" >&2
    return 1
  fi
  _url="${url:$((3 + ${#proto}))}" # _url: url minus "${proto}://"

  uphp="${_url%%/*}" # uphp (User-Password-Host-Port): everything up to the first '/' in _url
  __url="${_url:$((${#uphp} + 1))}" # __url: _url minus uphp
  user_pass="${uphp%%@*}"
  if [ "${user_pass}" == "${uphp}" ]; then
    user_pass=""
    host_port="${uphp}"
  else
    host_port="${uphp#*@}"
  fi

  user="${user_pass%%:*}" # user: everything up to the first ':' in user_pass
  if [ "${user}" == "${user_pass}" ]; then
    pass=""
  else
    pass="${user_pass#*:}" # pass: everything after the first ':' in user_pass, but only if there was a ':'
  fi

  host="${host_port%%:*}" # host: everything up to the first ':' in host_port
  if [ "${host}" == "${host_port}" ]; then
    case "${proto}" in
      bgp)     port="179" ;;
      dns)     port="53" ;;
      ftp)     port="22" ;;
      ftps)    port="989";;
      gs)      port="443" ;;
      http)    port="80" ;;
      https)   port="443" ;;
      imap)    port="143" ;;
      imaps)   port="993" ;;
      ldap)    port="389" ;;
      ldaps)   port="636" ;;
      netbios) port="139" ;;
      pop)     port="110" ;;
      s3)      port="443" ;;
      smtp)    port="25" ;;
      smtps)   port="465" ;;
      snmp)    port="161" ;;
      ssh)     port="22" ;;
      *)       port="80" ;; # the default
    esac
  else
    port="${host_port#*:}" # port: everything after the first ':' in host_port, but only if there was a ':'
  fi

  path="${__url%%\?*}" # path: everything up to the first '?' in __url
  if [ "${path}" == "${__url}" ]; then
    query_string=""
  else
    query_string="${__url%*\?}" # query_string: everything after the first '?' in __url, but only if there was a '?'
  fi

  echo "{"\
       "\"proto\": \"${proto}\","\
       "\"host\": \"${host}\","\
       "\"port\": ${port},"\
       "\"username\": \"${user}\","\
       "\"password\": \"${pass}\","\
       "\"path\": \"${path}\","\
       "\"query_string\": \"${query_string}\""\
       "}"
}

if [ "${_SELF}" = "parse-url.sh" ]; then
  set -eu
  [[ "$#" -eq 0 ]] && echo "ERROR: Must provide an URL to parse" >&2 && exit 1
  [[ "$#" -ne 1 ]] && echo "ERROR: Only one URL may be given" >&2 && exit 1
  parse_url "$@"
fi
