FROM node:13.7.0-buster

WORKDIR /code

RUN npm install -g http-server

RUN ln -s /usr/bin/nodejs /usr/bin/node

ADD . /code/
VOLUME .:/code

CMD ["run.sh", "run_server"]