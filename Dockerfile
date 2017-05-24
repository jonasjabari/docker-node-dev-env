FROM node:4.8.3

RUN npm install -g \
  nodemon \
  eslint \
  mocha \
  nyc

COPY ./scripts /scripts

RUN mkdir module /module/src /module/test

ONBUILD COPY ./package.json /module
ONBUILD COPY /.eslintrc /module

ONBUILD RUN npm install

WORKDIR /module

CMD ["/scripts/run.sh"]
