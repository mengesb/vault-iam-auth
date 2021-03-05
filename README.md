# vault-iam-auth

Using IAM to auth for Vault

## Requirements

- Bash 4+
- IAM

## Usage

This repo contains a number of scripts segmented by cloud. There are some common functions to the clouds in the [functions](functions) directory.

### AWS

The following scripts are available for the AWS platform

| Name | File | Documentation | Purpose |
| ---- | ---- | ------------- | ------- |
| python-vault-iam | [python-vault-iam.py](aws/python-vault-iam.py) | | script |
| vault-iam-auth | [vault-iam-auth.sh](aws/vault-iam-auth.sh) | [vault-iam-auth.md](docs/vault-iam-auth.md) | script |
| vault-ec2-auth | TBD<!-- [vault-ec2-auth.sh](aws/vault-ec2-auth.sh) --> | TBD<!-- [vault-ec2-auth.md](docs/vault-ec2-auth.md)  --> | TBD<!-- script --> |
| aws4-sign | [aws4-sign.sh](aws/aws4-sign.sh) | [aws4-sign.md](docs/aws4-sign.md) | library |
| aws-credentials | [aws-credentials.sh](aws/aws-credentials.sh) | [aws-credentials.md](docs/aws-credentials.md) | script/library |

### GCP

Currently there are no scripts for the GCP platform. Check back later for future updates.

### Functions

Scripts in the [functions](functions) directory support scripts beyond a single platform

| Name | File | Documentation | Purpose |
| ---- | ---- | ------------- | ------- |
| parse-url | [parse-url.sh](functions/parse-url.sh) | [parse-url.md](docs/parse-url.md) | script/library |

## Contributing

Contributions are always welcome. Please consult our [CONTRIBUTING.md](CONTRIBUTING.md) file for more information on how to submit quality contributions.

## License & Authors

Author: Brian Menges (@mengesb)

```text
Copyright 2021 Brian Menges

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
