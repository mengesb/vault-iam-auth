# vault-iam-auth

Generate JSON material to log into a Vault AWS authentication backend using the instances AWS IAM instance profile

## Overview

<!-- markdownlint-disable-file MD012 -->
This script uses the AWS IAM method for logging into a Vault AWS
authentication backend.

## Usage

```bash
$ aws/vault-iam-auth.sh -h
usage: aws/vault-iam-auth.sh [OPTIONS...]

Log into Vault using AWS IAM profile

OPTIONS:
-r  Vault role                (Default: [INSTANCE_PROFILE_NAME])
-s  Vault address             (Default: http://vault.example.internal:8200)

-h  This help message
-v  Verbose mode
```

### role

If your instance doesn't use the same role name as the role you're using
in your vault instance, you'll have to pass the `-r` option to specify a
different role

```bash
$ aws/vault-iam-auth.sh -r my-vault-role
{
"role": "my-vault-role",
"iam_http_request_method": "POST",
"iam_request_url": "aHR0cHM6Ly9zdHMuYW1hem9uYXdzLmNvbS8=",
"iam_request_body": "QWN0aW9uPUdldENhbGxlcklkZW50aXR5JlZlcnNpb249MjAxMS0wNi0xNQ==",
"iam_request_headers": "ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MTQ1MloiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbInZhdWx0LXVzLWVhc3QtMS5hbmFwbGFuLmlvIl0sCiAgIkF1dGhvcml6YXRpb24iOiBbIkFXUzQtSE1BQy1TSEEyNTYgQ3JlZGVudGlhbD0xMjM0NTY3ODkwMS8yMDIxMDMwNS91cy1lYXN0LTEvc3RzL2F3czRfcmVxdWVzdCwgU2lnbmVkSGVhZGVycz1jb250ZW50LXR5cGU7aG9zdDt4LWFtei1kYXRlO3gtYW16LXNlY3VyaXR5LXRva2VuO3gtdmF1bHQtYXdzLWlhbS1zZXJ2ZXItaWQsIFNpZ25hdHVyZT1mM2IwZjVkMmE4MWMwNjllYmRkN2UzNThmNDQ3ZjJlYWVhNDJhYjE5ZWRiYmRmY2M2ZTUxNGFjMWJlMDg5ZTRmIl0KfQ=="
}
```

### server

If your instance doesn't use the same role name as the role you're using
in your vault instance, you'll have to pass the `-r` option to specify a
different role

```bash
$ aws/vault-iam-auth.sh -s https://my-internal-vault.domain.tld
{
"role": "[INSTANCE_PROFILE_NAME]",
"iam_http_request_method": "POST",
"iam_request_url": "aHR0cHM6Ly9zdHMuYW1hem9uYXdzLmNvbS8=",
"iam_request_body": "QWN0aW9uPUdldENhbGxlcklkZW50aXR5JlZlcnNpb249MjAxMS0wNi0xNQ==",
"iam_request_headers": "ewogICJDb250ZW50LVR5cGUiOiBbImFwcGxpY2F0aW9uL3gtd3d3LWZvcm0tdXJsZW5jb2RlZCBjaGFyc2V0PXV0Zi04Il0sCiAgIkhvc3QiOiBbInN0cy5hbWF6b25hd3MuY29tIl0sCiAgIlgtQW16LURhdGUiOiBbIjIwMjEwMzA1VDA1MjMxOVoiXSwKICAiWC1BbXotU2VjdXJpdHktVG9rZW4iOiBbIlRFU1Q5MnRlc3Q0OFRFU1QreTZScG9URVNUOTJ0ZXN0NDhURVNULzhvV1ZBaUJxVEVzVDVLeTd0eTJ0RVN0eEMxVD09Il0sCiAgIlgtVmF1bHQtQVdTLUlBTS1TZXJ2ZXItSWQiOiBbIm15LWludGVybmFsLXZhdWx0LmRvbWFpbi50bGQiXSwKICAiQXV0aG9yaXphdGlvbiI6IFsiQVdTNC1ITUFDLVNIQTI1NiBDcmVkZW50aWFsPTEyMzQ1Njc4OTAxLzIwMjEwMzA1L3VzLWVhc3QtMS9zdHMvYXdzNF9yZXF1ZXN0LCBTaWduZWRIZWFkZXJzPWNvbnRlbnQtdHlwZTtob3N0O3gtYW16LWRhdGU7eC1hbXotc2VjdXJpdHktdG9rZW47eC12YXVsdC1hd3MtaWFtLXNlcnZlci1pZCwgU2lnbmF0dXJlPWVmYmNlN2M0NGNhNzJhNDRmZWEzMTA5OTZhNWI2MmJjNTE5YTkxMzY5ZjUyNTcwMGRkMDlhZGI1NWNjYjhmYWIiXQp9"
}
```



