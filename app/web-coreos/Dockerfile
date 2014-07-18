FROM ubuntu:14.04

RUN apt-get update -yqq
RUN apt-get install -yqq nodejs npm
RUN apt-get install -yqq curl

ADD . /src
RUN cd /src; npm install

EXPOSE 8080
CMD ["nodejs", "/src/app.js"]
