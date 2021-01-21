help: ## display available targets
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

export XDG_RUNTIME_DIR?=/run/user/1000
export DOCKER_SOCK?=$(XDG_RUNTIME_DIR)/docker.sock

verify-with-mvnw: ## launch mvnw on the current host
	./mvnw clean verify

verify-with-maven-image: ## launch mvn verify inside a docker container
	docker run --rm -it --privileged --network=host \
		-e JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
		-e MAVEN_OPTS=-Dmaven.repo.local=/tmp/.m2/repository \
		-e DOCKER_CONFIG=$(HOME)/.docker \
		-v $(HOME)/.m2/repository:/tmp/.m2/repository \
		-e XDG_RUNTIME_DIR \
		-v $(DOCKER_SOCK):$(DOCKER_SOCK) \
		-v $(HOME)/.docker:$(HOME)/.docker \
		-v $(PWD):/project \
		-w /project \
		maven:3.6.3-openjdk-11 \
		mvn clean verify
