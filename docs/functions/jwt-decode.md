# jwt-decde

Library for decoding JWT material

## Overview

<!-- markdownlint-disable-file MD012 MD024 -->
This library decodes JWT material

## Index

* [b64_padding()](#b64_padding)
* [b64_tr()](#b64_tr)
* [json_kv()](#json_kv)
* [google_pubkey()](#google_pubkey)
* [google_verify()](#google_verify)
* [jwt_header_json()](#jwt_header_json)
* [jwt_payload_json()](#jwt_payload_json)
* [jwt_display()](#jwt_display)

### b64_padding()

Parses a base64 padded JWT string

#### Example

```bash
$ source functions/jwt-decode.sh
$ b64_padding 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO=
```

#### Arguments

* **$1** (string): base64 encoded string

#### Output on stdout

* base64 encoded string with propper padding/terminators

### b64_tr()

Base64 translate of a JWT encoded string

#### Example

```bash
$ source functions/jwt-decode.sh
$ b64_tr 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz/iiY9eWIs/YNn3Ix1Uil4u2/3Ix1Uil4/2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of/mHMekDQcE3qut3fsxzd/o58VuiiY9/WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9/ho6n7raVq+NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC+NJW33xZFbmiKpJDX/1huD1zrBcRKwzjfS73gmJc/y5ehiJQHWNthO
```

#### Arguments

* **$1** (string): base64 encoded string

#### Output on stdout

* base64 encoded string replacing '-_' with '+/'

### json_kv()

Parses JSON string and returns value of key requested

#### Example

```bash
$ source functions/jwt-decode.sh
$ json_kv '{"alg":"RS256","kid":"1234567890abcdef01234567890abcdef1234567","typ":"JWT"}' alg
RS256
```

#### Arguments

* **$1** (string): JSON string
* **$2** (string): key

#### Output on stdout

* value of key searched for, or 'null' if not found

### google_pubkey()

Google OAuth2 public key signature fetch

#### Example

```bash
$ source functions/jwt-decode.sh
$ google_pubkey '13e8d45a43cb2242154c7f4dafac2933fea20374'
/path/to/tmp.signature.file
```

#### Arguments

* **$1** (string): key id (kid)

#### Output on stdout

* File containing public key material

### google_verify()

Google OAuth2 veriification of JWT header + payload (i.e. body) with
signature

#### Example

```bash
$ source functions/jwt-decode.sh
$ google_verify 'eyJhbGciOiJSUzI1NiIsI....gmJc_y5ehiJQHWNthO'
Verified OK
```

#### Arguments

* **$1** (string): JWT material

#### Output on stdout

* Message indicating success or failure of JWT verification

### jwt_header_json()

Parses JWT material and returns decoded JWT header

#### Example

```bash
$ source functions/jwt-decode.sh
$ jwt_header_json 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
{"alg":"RS256","kid":"1234567890abcdef01234567890abcdef1234567","typ":"JWT"}
```

#### Arguments

* **$1** (string): JWT material

#### Output on stdout

* base64 decoded JWT header

### jwt_payload_json()

Parses JWT material and returns decoded JWT payload

#### Example

```bash
$ source functions/jwt-decode.sh
$ jwt_payload_json 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
{"iss":"accounts.google.com","azp":"123456789012-1234567890abcdefghijklmnopqrstuvw.apps.googleusercontent.com","aud":"123456789012-1234567890abcdefghijklmnopqrstuvw.apps.googleusercontent.com","sub":"123456789012345678901","email":"mock@google.com","email_verified":true,"at_hash":"1234567890abc-DEFGHIJKL","iat":1617342363,"exp":1617345963,"jti":"1234567890abcdef1234567890abcdef12345678"}
```

#### Arguments

* **$1** (string): JWT material

#### Output on stdout

* base64 decoded JWT payload

### jwt_display()

Parses JWT material and returns environment variables

#### Example

```bash
$ functions/jwt-decode.sh 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYwMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1NjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMTIzNDU2Nzg5MDEyLTEyMzQ1Njc4OTBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2dy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTAxMi0xMjM0NTY3ODkwYWJjZGVmZ2hpamtsbW5vcHFyc3R1dncuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMjM0NTY3ODkwMTIzNDU2Nzg5MDEiLCJlbWFpbCI6Im1vY2tAZ29vZ2xlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiMTIzNDU2Nzg5MGFiYy1ERUZHSElKS0wiLCJpYXQiOjE2MTczNDIzNjMsImV4cCI6MTYxNzM0NTk2MywianRpIjoiMTIzNDU2Nzg5MGFiY2RlZjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3OCJ9.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO'
export JWT_HEADER='{"alg":"RS256","kid":"1234567890abcdef01234567890abcdef1234567","typ":"JWT"}'
export JWT_ALGORITHM=RS256
...
```

#### Arguments

* **$1** (string): JWT material

#### Output on stdout

* Environment variable export commands for JWT materal components

