export DOCKER_ORG ?= unionpos
export DOCKER_IMAGE ?= $(DOCKER_ORG)/micromdm
export DOCKER_TAG ?= 1.6
export DOCKER_IMAGE_NAME ?= $(DOCKER_IMAGE):$(DOCKER_TAG)
export DOCKER_BUILD_FLAGS =

-include $(shell curl -sSL -o .build-harness "https://raw.githubusercontent.com/unionpos/build-harness/master/templates/Makefile.build-harness"; echo .build-harness)

build: docker/build
.PHONY: build

## update readme documents
docs: readme/deps readme
.PHONY: docs

push:
	$(DOCKER) push $(DOCKER_IMAGE_NAME)
.PHONY: push

run:
	$(DOCKER) container run \
		--publish "80:80" \
		--publish "443:443" \
		--attach STDOUT ${DOCKER_IMAGE_NAME}

it:
	$(DOCKER) run -it \
		--publish "8080:8080" \
		${DOCKER_IMAGE_NAME} /bin/bash
