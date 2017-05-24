#!/bin/bash

nodemon --watch /module/src --watch /module/test --exec 'eslint /module/src /module/test'
