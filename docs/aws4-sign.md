# aws4-sign

Library for producing AWS v4 Signatures

## Overview

<!-- markdownlint-disable-file MD012 MD024 -->
This library builds an AWS signature version 4 compatible request

## Index

* [AWS4_HMAC_SHA256()](#aws4_hmac_sha256)
* [AWS4_SHA256()](#aws4_sha256)
* [AWS4_BASE64()](#aws4_base64)
* [AWS4_SIGN()](#aws4_sign)

### AWS4_HMAC_SHA256()

Generates a HMAC SHA256 digest with date and AWS_SECRET_ACCESS_KEY

#### Example

```bash
$ source aws/aws4-sign.sh
$ printf '%s' $(TZ=Z date +%Y%m%dT%H%M%SZ) | AWS4_HMAC_SHA256 "v/12345678901" # AWS_SECRET_ACCESS_KEY
79ee5040070df9e44dcf8311c8c39f1e80ad2129427203922bd843d0e5a4a246
```

### AWS4_SHA256()

Generates a SHA256 digest of the iam_request_body

#### Example

```bash
$ source aws/aws4-sign.sh
$ printf '%s' "Action=GetCallerIdentity&Version=2011-06-15" | AWS4_SHA256
ab821ae955788b0e33ebd34c208442ccfc2d406e2edc5e7a39bd6458fbb4f843
```

### AWS4_BASE64()

Encodes a string to base64

#### Example

```bash
$ source aws/aws4-sign.sh
$ printf '%s' "https://sts.amazon.com/" | AWS4_BASE64
aHR0cHM6Ly9zdHMuYW1hem9uLmNvbS8=
```

### AWS4_SIGN()

Generate a full AWS Signature v4 string

#### Example

```bash
$ source aws/aws4-sign.sh
$ AWS4_SIGN v/12345678901 20210305 us-east-1 sts 'AWS4-HMAC-SHA256
20210305T053255Z
20210305/us-east-1/sts/aws4_request
a4705172e527bf6592c29d3efbf506be7b9bf05a6bcbe67e1cfeeee4c7ea5a48'
358c2062761b64cdc791ce801b7aaf994fb83ac79e28025111fc5853f67176c8
```

#### Arguments

* **$1** (string): AWS Secret Access Key
* **$2** (string): Date as output by `+%Y%m%d`
* **$3** (string): AWS Region (`us-east-1`)
* **$4** (string): sts
* **$5** (string): Signed string material - Auth type, X-Amz-Date (`+%Y%m%dT%H%M%SZ`), credential scope and canonical request maintaining newlines

