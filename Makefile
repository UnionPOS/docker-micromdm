-include $(shell curl -sSL -o .build-harness "https://raw.githubusercontent.com/unionpos/build-harness/master/templates/Makefile.build-harness"; echo .build-harness)

export DOCKER_ORG ?= unionpos
export DOCKER_IMAGE ?= $(DOCKER_ORG)/micromdm
export DOCKER_TAG ?= 1.4.1
export DOCKER_IMAGE_NAME ?= $(DOCKER_IMAGE):$(DOCKER_TAG)
export DOCKER_BUILD_FLAGS =

build: docker/build

run:
	docker container run \
		--publish "80:80" \
		--publish "443:443" \
		--attach STDOUT ${DOCKER_IMAGE_NAME}

it:
	docker run -it \
		--publish "8080:8080" \
		${DOCKER_IMAGE_NAME} /bin/bash
