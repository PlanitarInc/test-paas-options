FROM ubuntu:12.04

RUN apt-get update -yqq
RUN apt-get install -yqq nodejs

ADD . /src
RUN cd /src; npm install

EXPOSE 8080
CMD ["node", "/src/app.js"]
