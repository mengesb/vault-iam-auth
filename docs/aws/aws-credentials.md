# aws-credentials

Query AWS EC2 metadata service for information

## Overview

<!-- markdownlint-disable-file MD012 MD024 -->
When sourced as a library, this provides functions to get various bits of
information from the AWS EC2 instance metadata service. When operating as
a script, it will output common environment variables used for AWS tools

This code handles environments where `jq` may not be available.

## Index

* [aws_instance_profile_arn()](#aws_instance_profile_arn)
* [aws_instance_profile_name()](#aws_instance_profile_name)
* [aws_credentials()](#aws_credentials)
* [aws_access_key_id()](#aws_access_key_id)
* [aws_secret_access_key()](#aws_secret_access_key)
* [aws_session_token()](#aws_session_token)
* [aws_environment()](#aws_environment)

### aws_instance_profile_arn()

Acquires your instance profile ARN from the metadata API

#### Example

```bash
$ source aws/aws-credentials.sh
$ aws_instance_profile_arn
arn:aws:iam::896453262835:instance-profile/baskinc-role
```

### aws_instance_profile_name()

Acquires your profile name from aws_instance_profile_arn() function

#### Example

```bash
$ source aws/aws-credentials.sh
$ aws_instance_profile_name
baskinc-role
```

### aws_credentials()

Acquires your security credentials for your AWS instance profile

#### Example

```bash
$ source aws/aws-credentials.sh
$ aws_credentials
{
        "Code": "Success",
        "LastUpdated": "2020-04-02T18:50:40Z",
        "Type": "AWS-HMAC",
        "AccessKeyId": "12345678901",
        "SecretAccessKey": "v/12345678901",
        "Token": "TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T==",
        "Expiration": "2020-04-02T00:49:51Z"
}
```

### aws_access_key_id()

Acquires your AWS Access Key ID from aws_credentials() function

#### Example

```bash
$ source aws/aws-credentials.sh
$ aws_access_key_id
12345678901
```

### aws_secret_access_key()

Acquires your AWS Secret Access Key from aws_credentials() function

#### Example

```bash
$ source aws/aws-credentials.sh
$ aws_secret_access_key
v/12345678901
```

### aws_session_token()

Acquires your AWS Session Token from aws_credentials() function

#### Example

```bash
$ source aws/aws-credentials.sh
$ aws_session_token
TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T==
```

### aws_environment()

Outputs environment variable exports for your AWS credentials

#### Example

```bash
$ aws/aws-credentials.sh
export AWS_ACCESS_KEY_ID=12345678901
export AWS_SECRET_ACCESS_KEY=v/12345678901
export AWS_SESSION_TOKEN=TEST92test48TEST+y6RpoTEST92test48TEST/8oWVAiBqTEsT5Ky7ty2tEStxC1T==
```

