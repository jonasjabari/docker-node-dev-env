# Docker-based Node.js Development Environment

## Purpose

Encapsulate the node.js runtime in a container during development and mount source-code
into it. Great for Teamwork as all members share the exact same runtime even
across platforms. 

## Usage

Usage with docker-compose is recommended. It's easy to setup multiple node.js containers
serving different purposes. The example shows how to setup three containers for:

* running code
* testing code
* linting code

```yml
version: "2"
services:
  module:
    build: .
    command: /scripts/run.sh
    volumes:
      - ./src:/module/src
      - ./test:/module/test

  module-test:
    build: .
    command: /scripts/test.sh
    volumes:
      - ./src:/module/src
      - ./test:/module/test

  module-lint:
    build: .
    command: /scripts/lint.sh
    volumes:
      - ./src:/module/src
      - ./test:/module/test
```
