FROM node:7.10.0

RUN npm install -g \
  nodemon \
  eslint \
  mocha \
  nyc

COPY ./entrypoints /entrypoints

RUN mkdir module /module/src /module/test

ONBUILD COPY ./package.json /module
ONBUILD COPY /.eslintrc /module

ONBUILD RUN npm install

WORKDIR /module

ENTRYPOINT ["/entrypoints/run.sh"]
