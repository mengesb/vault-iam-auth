# vault-gce-auth

Generate JSON material to log into a Vault Google authentication backend using the instances default identity

## Overview

<!-- markdownlint-disable-file MD012 -->
This script uses the GCE method for logging into a Vault GCP
authentication backend.

## Usage

```bash
$ gcp/vault-gce-auth.sh -h
usage: gcp/vault-gce-auth.sh [OPTIONS...]

Log into Vault from GCE instance

OPTIONS:
-m  Vault mount               (Default: gcp)
-r  Vault role                (REQUIRED)
-s  Vault address             (Default: http://vault.example.internal:8200)

-h  This help message
-v  Verbose mode
```

### Vault role

In google there is no instance profile, therefore the role is a required
field. You must provide the '-r' option or use the environment variable
$VAULT_ROLE

```bash
$ gcp/vault-gce-auth.sh -r my-vault-role
{
"role": "my-vault-role",
"http_request_method": "POST",
"jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
}
```

```bash
$ export VAULT_ROLE=my-vault-role
$ gcp/vault-gce-auth.sh
{
"role": "my-vault-role",
"http_request_method": "POST",
"jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
}
```

### Vault address

This updates the audience field when generating the JWT portion. You may
use either the option (-s) or the environment variable $VAULT_ADDR to set
the Vault address

```bash
$ gcp/vault-gce-auth.sh -r my-vault-role -s https://my-internal-vault.domain.tld
{
"role": "my-vault-role",
"http_request_method": "POST",
"jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
}
```

```bash
$ export VAULT_ADDR=https://my-internal-vault.domain.tld
$ gcp/vault-gce-auth.sh -r my-vault-role
{
"role": "my-vault-role",
"http_request_method": "POST",
"jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
}
```

### Vault mount

This updates the audience field when generating the JWT portion. You may
use either the option (-m) or the environment variable $VAULT_MOUNT to set
the Vault mount

```bash
$ gcp/vault-gce-auth.sh -r my-vault-role -m gcp
{
"role": "my-vault-role",
"http_request_method": "POST",
"jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
}
```

```bash
$ export VAULT_MOUNT=gcp
$ gcp/vault-gce-auth.sh -r my-vault-role
{
"role": "my-vault-role",
"http_request_method": "POST",
"jwt": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjAxMjM0NTY3ODlhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjMiLCJ0eXAiOiJKV1QifQo=.ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjh-U_KpT5JdhRhKQswcsBb59SYV1EM5kMOPxkHcGPzF3lKuxFC8Uqg"
}
```


