.PHONY: all build docker coreos clean

all: docker

build:
	make -C app build

docker: build
	make -C docker run

coreos: build
	make -C coreos run

clean:
	make -C app clean
	make -C docker clean
	make -C coreos clean
