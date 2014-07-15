build_web_app:
	cd app/web
	docker build -t test-paas-web-app .

build_test_app:
	cd app/test
	docker build -t test-paas-test-app .

test: build_web_app build_test_app
	docker run -d --name test-redis redis
	docker run -d --name test-web-app --link test-redis:redis test-paas-web-app
	docker run -d --name test-app --link test-web-app:web-app test-paas-test-app
	if [ ! docker wait test-app | grep -q 0 ]; then
	  docker logs test-app
	  docker kill test-app test-web-app test-redis
	  docker rm test-app test-web-app test-redis
	  exit 1
	fi
	docker kill test-app test-web-app test-redis
	docker rm test-app test-web-app test-redis
