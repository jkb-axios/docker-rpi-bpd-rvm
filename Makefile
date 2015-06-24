DOCKER_IMAGE_VERSION=v2
DOCKER_IMAGE_NAME=kipp/rpi-bpd-rvm
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	#docker tag -f $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/echo "Success."

version:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/bash -l -c "rvm --version"
	docker run --rm $(DOCKER_IMAGE_TAGNAME) ruby --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) gem --version
	docker run --rm $(DOCKER_IMAGE_TAGNAME) gem list
	docker run --rm $(DOCKER_IMAGE_TAGNAME) soca --version
