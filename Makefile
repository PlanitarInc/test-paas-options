.PHONY: build docker clean

build:
	make -C app build

docker: build
	make -C docker run

clean:
	make -C app clean
	make -C docker clean
