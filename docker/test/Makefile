.PHONY: build clean

build: .build_once

clean:
	rm -f .build_once
	docker rmi -f test-paas-test-app

.build_once: Dockerfile test.sh
	docker build -t test-paas-test-app .
	touch $@
