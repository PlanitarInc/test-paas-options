.PHONY: build push clean

build:
	make -C web build
	make -C web-coreos build

push:
	make -C web push
	make -C web-coreos push

clean:
	make -C web-coreos clean
	make -C web clean
