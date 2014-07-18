.PHONY: all build docker coreos clean push

all: docker

build:
	make -C app build

docker:
	make -C docker run

coreos:
	make -C coreos run

clean:
	make -C app clean
	make -C docker clean
	make -C coreos clean

push:
	make -C app push
