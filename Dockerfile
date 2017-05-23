FROM node:7.10.0

RUN mkdir module
WORKDIR module

RUN npm install -g nodemon
RUN npm install -g eslint
RUN npm install -g mocha
RUN npm install -g nyc

CMD ["nodemon", "index.js"]
