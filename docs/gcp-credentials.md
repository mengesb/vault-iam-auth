# gcp-credentials

Query GCP metadata service for information

## Overview

<!-- markdownlint-disable-file MD012 MD024 -->
When sourced as a library, this provides functions to get various bits of
information from the GCP metadata service. When operating as a script, it
will output common environment variables used for GCP tools

This code handles environments where `jq` may not be available.

## Index

* [headers()](#headers)
* [url_encode()](#url_encode)
* [gcp_identity()](#gcp_identity)
* [gcp_service_accounts()](#gcp_service_accounts)

### headers()

Builds headers for curl requests from HEADERS environment variable

#### Example

```bash
$ source gcp/gcp-credentials.sh
$ headers
-H 'Metadata-Flavor: Google'
```

### url_encode()

Builds url encoding commands for curl requests

#### Example

```bash
$ source gcp/gcp-credentials.sh
$ url_encode
--data-urlencode 'format=full'
$ url_encode "audience=https://vault"
--data-urlencode 'format=full' --data-urlencode 'audience=https://vault'
```

#### Arguments

* **$1** (string): Data to encode in URL safe format

### gcp_identity()

Returns a GCE instance identity (JWT token) for the audience requested

#### Example

```bash
$ source gcp/gcp-credentials.sh
$ gcp_identity "https://vault"
eyJhbGciOiJSUzI1NiIsImtpZCI6IjEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3ODkwYWJjZGVmMTIzNDU2NzgiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvby5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImVtYWlsIjoibW9ja0Bmb28uaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZXhwIjoxNjE2OTI4NTgwLCJpYXQiOjE2MTY5MjQ5ODAsImlzcyI6Imh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbSIsInN1YiI6IjEyMzQ1Njc4OTAxMjM0NTY3ODkwMQI.WQiOiJodHRwczovL3ZhdWx0L215LXJvbGUiLCJhenAiOiJtb2NrQGZvMKPhz_iiY9eWIs_YNn3Ix1Uil4u2_3Ix1Uil4_2OHFjThJeFfGGU8xRz8qw5kCYfd5J7Kuy4Of_mHMekDQcE3qut3fsxzd_o58VuiiY9_WIs1YNn3Ix1Uil4u2OHFjThJeFfGGU8xRz8emCRJzI9Bhqgxrd1A3ZoFRi9_ho6n7raVq-NJW33xZFbmiKpJDX1huD1zrBemCRJzI9Bhqgxrd1A3ZoFRi9pho6n7raVqC-NJW33xZFbmiKpJDX_1huD1zrBcRKwzjfS73gmJc_y5ehiJQHWNthO
```

#### Arguments

* **$1** (string): Audience to request JWT token for

### gcp_service_accounts()

Returns information about a service accunt, or the default if none passed

#### Example

```bash
$ source gcp/gcp-credentials.sh
$ gcp_service_accounts
{"aliases":"default","email":"mock@foo.iam.gserviceaccount.com","scopes":"https://www.googleapis.com/auth/userinfo.email\nhttps://www.googleapis.com/auth/cloud-platform\n"}
$ gcp_service_accounts "default"
{"aliases":"default","email":"mock@foo.iam.gserviceaccount.com","scopes":"https://www.googleapis.com/auth/userinfo.email\nhttps://www.googleapis.com/auth/cloud-platform\n"}
```

#### Arguments

* **$1** (string): Google Service Account (Default: default)

