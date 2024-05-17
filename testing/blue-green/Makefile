## Docker Build Versions
DOCKER_BUILD_IMAGE = golang:1.22.2
DOCKER_BASE_IMAGE = alpine:3.14
#######################################
# Docker
TAG ?= test
REGISTRY ?= dmaxim
APP_IMAGE ?= ${REGISTRY}/argo-cd-app:${TAG}
################################################################################

.PHONY: build-linux
build-linux: # Building linux binaries
	@echo Building ${TAG} binary for linux
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-X 'main.BuildVersion=${TAG}'" -o bin/server ./cmd

.PHONY: build-mac
build-mac: # Building mac binaries
	@echo Building ${TAG} binary for linux
	GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-X 'main.BuildVersion=${TAG}'" -o bin/server ./cmd

.PHONY: build-image
build-image:  ## Build the docker image for mattermost-cloud
	@echo Building App Docker
	docker build \
	--build-arg DOCKER_BUILD_IMAGE=$(DOCKER_BUILD_IMAGE) \
	--build-arg DOCKER_BASE_IMAGE=$(DOCKER_BASE_IMAGE) \
	--build-arg TAG=$(TAG) \
	. -f Dockerfile -t $(APP_IMAGE)

.PHONY: push-docker
push-image: build-image # Docker push
	@echo Pushing docker image
	docker push ${APP_IMAGE}