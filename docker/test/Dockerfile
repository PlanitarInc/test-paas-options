FROM ubuntu:14.04

RUN apt-get update -yqq
RUN apt-get install -yqq curl

ADD . /src

CMD ["sh", "/src/test.sh"]
