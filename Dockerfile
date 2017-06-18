FROM node:6.10.3

RUN npm install -g \
  nodemon \
  eslint \
  mocha \
  nyc

COPY ./scripts /scripts

RUN mkdir module /module/src /module/test

ONBUILD COPY ./package.json /module
ONBUILD COPY /.eslintrc /module

WORKDIR /module

CMD ["/scripts/run.sh"]
