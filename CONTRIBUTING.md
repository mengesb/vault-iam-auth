# Contributing

All contributors are welcome to submit patches but please keep the following in
mind:

- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Prerequisites](#prerequisites)

Please also keep in mind:

- Be patient as not all items will be tested or reviewed immediately by the Cloud Platform team.
- Be receptive and responsive to feedback about your additions or changes. Myself and/or other community members may make suggestions or ask questions about your change. This is part of the review process, and helps everyone to understand what is happening, why it is happening, and potentially optimizes your code.
- Be understanding

If you're looking to contribute but aren't sure where to start, check out the
open issues.

## Will Not Merge

This details Pull Requests that we will **not** be merged.

- New features without accompanying tests or proof of operation
- New features without accompanying usage documentation

## Coding Standards

The submitted code should be compatible with the following standards

- 2-space indentation style
- First curl brace on the same line as the method
- Closing curl brace on its own aligned newline
- Variable and value assignment does not need to be aligned with assignment operator

## Testing

Please indicate the results of your tests in a comment along with the pull request. Supplying tests and the method used to run/validate the changes are highly encouraged. This repository follows [Bats: Bash Automated Testing System](https://github.com/sstephenson/bats) standards.

## Linting

This repository follows [shellcheck](https://github.com/koalaman/shellcheck) standards for linting.

## Documentation

This repository uses `shdoc` to generate shell documentation. Please see [reconquest/shdoc](https://github.com/reconquest/shdoc#features) for annotations to document shell scripts

## Prerequisites

Familiarize yourself with BASH v4+ and be well versed in special variables.

- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/index.html)

## Process

1. Fork the git repository from GitHub:
2. Create a branch for your changes:
    git checkout -b my_bug_fix
3. Make any changes
4. Write tests to support those changes.
5. Run the tests:
6. Assuming the tests pass, open a Pull Request on GitHub and add results

## Do's and Don't's

- **Do** include tests for your contribution
- **Do** request feedback via GitHub issues or other contact
- **Do NOT** break existing behavior (unless intentional)
- **Do NOT** modify the markdown documentation files
