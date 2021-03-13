# Testing

This document describes the process for testing scripts contained in this repository.

## Testing Prerequisites

- BASH v4+
- [Amazon EC2 Metadata Mock](https://github.com/aws/amazon-ec2-metadata-mock)
- [bats-core](https://github.com/bats-core/bats-core)
- [shellcheck](https://github.com/koalaman/shellcheck)
- [shdoc](https://github.com/reconquest/shdoc) **\[OPTIONAL\]**

### Bash v4+

The scripts contained in this repo assume a minimum version of Bash v4. Should you need to install it here are some resources

#### Universal

- [GitHub Desktop](https://desktop.github.com/)

#### Linux

If you're operating on Linux, you should have a Bash compliant shell installed automatically. Use your OS package manager to install or upgrade to a compliant version of Bash should that be required.

#### MacOS

Recommended that you install Bash via [Homebrew](https://brew.sh/)

```shell
brew install bash
```

#### Windows

- WSL2 + a Linux subsystem install (Ubuntu) **Recommended**
- [Git for Windows](https://git-scm.com/download/win)

### Amazon EC2 Metadata Mock

There are a few ways to [install](https://github.com/aws/amazon-ec2-metadata-mock#installation) the ec2-metadata-mock tool, please select the best option for your platform. The Bats-core tests are designed to automatically start/stop ec2-metadata-mock tool so there is no need to manually start it yourself.

Should you want to test manually, you will need to run the tool and also export the environment variable `EC2_METADATA_MOCK`.

```bash
export EC2_METADATA_MOCK=http://127.0.0.1:1338/latest/meta-data
ec2-metadata-mock -n 127.0.0.1 > /dev/null 2>&1 &
```

### Bats-core

Not to be confused with Bats, Bats-core is a fork of Bats as a result of a [call for maintainers](https://github.com/sstephenson/bats/issues/150) and no write access. It is important that you install Bats-core since this repository makes use of newer features. [Installation](https://bats-core.readthedocs.io/en/latest/installation.html) documentation can be found at the link provided.

Bats tests are located in the [tests](tests) path of the repo. All Bats tests must have a file extension `.bats`.

You can run tests several ways

#### Specific test

```bash
~ $ bats test/requirements.bats
 ✓ Requirements: bats version
 ✓ Requirements: ec2-metadata-mock
 ✓ Requirements: shdoc
 ✓ Requirements: gawk
 ✓ Requirements: shellcheck

5 tests, 0 failures
```

#### All tests

```bash
~ $ bats test/                 
 ✓ Requirements: ec2-metadata-mock running
 ✓ aws_instance_profile_arn()
 ✓ aws_instance_profile_name()
 ✓ aws_credentials()
 ✓ aws_access_key_id()
 ✓ aws_secret_access_key()
 ✓ aws_session_token()
 ✓ aws-credentials.sh - aws_environment()
 ✓ AWS4_HMAC_SHA256()
 ✓ AWS4_SHA256()
 ✓ AWS4_BASE64()
 ✓ AWS4_SIGN()
 ✓ aws-sign.sh
 ✓ Requirements: bats version
 ✓ Requirements: ec2-metadata-mock
 ✓ Requirements: shdoc
 ✓ Requirements: gawk
 ✓ Requirements: shellcheck
 ✓ vault-iam-auth.sh
 ✓ vault-iam-auth.sh -r my-custom-role
 ✓ vault-iam-auth.sh with VAULT_ROLE=env-var-vault-role
 ✓ vault-iam-auth.sh -h

22 tests, 0 failures
```

### Shellcheck

[Shellcheck](https://github.com/koalaman/shellcheck#installing) is a linting tool for shell scripted languages. There are several options for [installing shellcheck](https://github.com/koalaman/shellcheck#installing), please consult the documentation for the best method that fits your scenario.

Each shell script must conform to [shellcheck](https://github.com/koalaman/shellcheck) linting standards. Exceptions can only be accepted by maintainers.

#### Lint specific file

```bash
~ $ shellcheck aws/vault-iam-auth.sh
```

#### Lint all files

```bash
~ $ for FILE in $(find . -iname '*.sh' | grep -v test); do echo -n "Shellcheck: ${FILE:2}" && shellcheck ${FILE:2} && echo -n "  -  OK\n"; done
Shellcheck: functions/parse-url.sh  -  OK
Shellcheck: aws/aws4-sign.sh  -  OK
Shellcheck: aws/aws-credentials.sh  -  OK
Shellcheck: aws/vault-iam-auth.sh  -  OK
```

### shdoc

[shdoc]((https://github.com/reconquest/shdoc) is used to auto generate documentation of shell scripted languages. GitHub Actions require that this binary be available, however if you are contributing new fuctions or code, you'll be required to document your additions using these annotations. For this reason, it is recommended that you install this tool to see what the generated documentation looks like.

Generated documentation for shell scripts is done by the [shell-docs.yml](.github/workflows/shell-docs.yml) action. It will search for all `*.sh` files and putput a markdown document in the `docs/` path.

#### Gawk requirement

[shdoc]((https://github.com/reconquest/shdoc) uses `gawk` to parse documentation from shell script files. On MacOS, this is generally not installed, and recommend to be installed via [Homebrew](https://brew.sh/)

```bash
brew install gawk
```

When installing shdoc from source (non-Linux preferred method), you will likely have to modify the shebang to point to the correct `gawk` location in your `$PATH` environment variable. In the case of MacOS, you can simply edit the file (`sudo vi $(which gawk)`), or use `sed` to modify the script

```bash
~ $ sudo sed -i.bak 's/\/usr\/bin\/gawk/\/usr\/local\/bin\/gawk/' $(which shdoc)
```

For other operating systems, such as WSL2 Ubuntu on Windows, or Linux systems, this may not be necessary. Check your `$PATH` variable and modify as needed.
