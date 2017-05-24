# Docker-based Node.js Development Environment

## Purpose

Encapsulate the node.js runtime in a container during development and mount source-code
into it. Great for teamwork as all members share the exact same runtime even
across platforms. 

## Usage

### Expected Folder Structure

The image is expecting the following folder structure and files to be present:
```
your_module
│   Dockerfile
|   package.json
│   .eslintrc
│
└───src
│   │   index.js
│   │   ...
│   
└───test
    │   index.test.js
    │   ...
```

### Dockerfile

The minimal Dockerfile you need looks like this:

```Dockerfile
FROM jonasjabari/docker-node-dev-env:latest

# your custom configurations...
```

### docker-compose

Usage with docker-compose is recommended. It's easy to setup multiple node.js containers
serving different purposes. The example shows how to setup three containers for running, 
testing and linting the source code mounted into the containers.

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
To start the containers, just run:

```bash
docker-compose up --build
```

### Changes to package.json and its limitations

If the package.json has changed, you need to rebuild the container. 
'npm install' is only executed while building the image. 
This might be a limitation, but I'm used to it and don't care too much about it.

The package.json is not mounted into the container. 
