.PHONY: build push clean

build: .build_once

push:
	docker push korya/test-web-app

clean:
	rm -f .build_once
	docker rmi -f korya/test-web-app || true

.build_once: Dockerfile app.js package.json
	docker build -t korya/test-web-app .
	touch $@
