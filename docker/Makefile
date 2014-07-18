.PHONY: run test clean build_test_app

run: test

clean:
	docker rmi -f test-paas-test-app

build_test_app:
	cd test && docker build -t test-paas-test-app .

test: build_test_app
	docker run -d --name test-redis redis
	docker run -d --name test-web-app --link test-redis:redis korya/test-web-app
	sleep 1 # Sleep a sec to allow redis get up
	docker run -d --name test-app --link test-web-app:web-app test-paas-test-app
	if ! docker wait test-app | grep -q 0; then\
	  docker logs test-app >&2; \
	  docker kill test-app test-web-app test-redis >/dev/null; \
	  docker rm test-app test-web-app test-redis >/dev/null; \
	  false; \
	fi
	docker kill test-app test-web-app test-redis >/dev/null
	docker rm test-app test-web-app test-redis >/dev/null
