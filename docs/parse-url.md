# parse-url

Parse a URL into components

## Overview

<!-- markdownlint-disable-file MD004 MD012 -->
Will take an URL as an input, and break it into the following components:

- protocol
- host
- port
- username
- password
- path
- query_string

## Index

* [parse_url()](#parse_url)

### parse_url()

Parse URL string

#### Example

```bash
$ functions/parse-url.sh https://my.vault.internal
{ "proto": "https", "host": "my.vault.internal", "port": 443, "username": "", "password": "", "path": "", "query_string": "" }
```

#### Arguments

* **$1** (string): URL

#### Output on stdout

* JSON structure keyed on URL components

