# Testing

This document describes the process for testing scripts contained in this repository.

## Testing Prerequisites

- BASH v4+
- [shellcheck](https://github.com/koalaman/shellcheck)
- [bats-core](https://github.com/bats-core/bats-core)
- [Amazon EC2 Metadata Mock](https://github.com/aws/amazon-ec2-metadata-mock)

## Amazon EC2 Metadata Mock

In order to test AWS scripts, you will need to mock the EC2 Metadata service. This project starts a local service of the EC2 Metadata service. To use it for tests, AWS scripts will look for the environment variable `EC2_METADATA_MOCK`

```bash
export EC2_METADATA_MOCK=http://127.0.0.1:1338/latest/meta-data
ec2-metadata-mock -n 127.0.0.1 > /dev/null 2>&1 &
```

## Bats

Bats tests are located in the [tests](tests) path of the repo.

Tests are simple to run:

```bash
~ $ cd tests
tests $ bats [test].bats
  ...
```

or

```bash
~ $ bats tests/
  ...
```

### lint

Each file must conform to [shellcheck](https://github.com/koalaman/shellcheck) linting standards. Exceptions can only be accepted by maintainers.

```bash
~ $ shellcheck aws/vault-iam-auth.sh
```
