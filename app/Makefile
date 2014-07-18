.PHONY: build clean

build:
	docker build -t korya/test-web-app web
	docker push korya/test-web-app

clean:
	docker rmi -f korya/test-web-app
