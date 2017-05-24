#!/bin/bash

nodemon --watch /module/src --watch /module/test --exec 'NODE_ENV=test nyc mocha --recursive /module/test'
