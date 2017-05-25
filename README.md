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
│   .eslintrc
│   Dockerfile
│   docker-compose.yml
│   package.json
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

# available tags: "latest", "6.10.3", "4.8.3" (corresponding to the node.js version)
# optional: your custom configurations:
# ...
```

### docker-compose.yml

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

### .eslintrc

The .eslintrc is project-specific and therefore needs to be specified in your project.
It might look like this:

```json
{
  "env": {
    "node": true
  },
  "parserOptions": {
    "ecmaVersion": 6,
    "sourceType": "script"
  },
  "rules": {
    "array-bracket-spacing": [2, "never"],
    "block-scoped-var": 2,
    "brace-style": [2, "1tbs"],
    "camelcase": 1,
    "computed-property-spacing": [2, "never"],
    "curly": 2,
    "eol-last": 2,
    "eqeqeq": [2, "smart"],
    "max-depth": [1, 3],
    "max-len": [1, 80],
    "max-statements": [1, 30],
    "new-cap": 1,
    "no-extend-native": 2,
    "no-mixed-spaces-and-tabs": 2,
    "no-trailing-spaces": 2,
    "no-unused-vars": 1,
    "no-use-before-define": [2, "nofunc"],
    "object-curly-spacing": [2, "always"],
    "quotes": [2, "single", "avoid-escape"],
    "semi": [2, "always"],
    "keyword-spacing": [2, {"before": true, "after": true}],
    "space-unary-ops": 2
  }
}
```

### Testing with Mocha

The image is desigend to run tests found in your project. By default it uses the assert-syntax.
A test might look like this:

```javascript
const assert = require('assert');

describe('your module', () => {

  it('work', () => {
    assert.equal(true, true);
  });

});

```
