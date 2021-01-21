help: ## display available targets
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

DOCKER_SOCK?=/run/user/1000/docker.sock

# BUILD SUCCESS
success-mvn: ## successful build using host maven installation
	mvn clean verify

# BUILD SUCCESS
success-mvnw: ## successful build using maven wrapper
	./mvnw clean verify

# Caused by: java.lang.IllegalStateException: Could not connect to Ryuk at 172.17.0.1:49157
#	at org.testcontainers.utility.ResourceReaper.start(ResourceReaper.java:198)
fail-maven-image-enabled-ryuk: ## failed build inside mvn docker image with Ryuk enabled
	docker run --rm -it \
		-e JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
		-e MAVEN_OPTS=-Dmaven.repo.local=/tmp/.m2/repository \
		-e DOCKER_CONFIG=$(HOME)/.docker \
		-v $(HOME)/.m2/repository:/tmp/.m2/repository \
		-v $(DOCKER_SOCK):/var/run/docker.sock \
		-v $(HOME)/.docker:$(HOME)/.docker \
		-v $(PWD):/project \
		-w /project \
		maven:3.6.3-openjdk-11 \
		mvn clean verify

# Caused by: org.postgresql.util.PSQLException: Connection to 172.17.0.1:49158 refused.
# Check that the hostname and port are correct and that the postmaster is accepting TCP/IP connections.
fail-maven-image-disabled-ryuk: ## failed build inside mvn docker image with Ryuk disabled
	docker run --rm -it \
		-e TESTCONTAINERS_RYUK_DISABLED=true \
		-e JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
		-e MAVEN_OPTS=-Dmaven.repo.local=/tmp/.m2/repository \
		-e DOCKER_CONFIG=$(HOME)/.docker \
		-v $(HOME)/.m2/repository:/tmp/.m2/repository \
		-v $(DOCKER_SOCK):/var/run/docker.sock \
		-v $(HOME)/.docker:$(HOME)/.docker \
		-v $(PWD):/project \
		-w /project \
		maven:3.6.3-openjdk-11 \
		mvn clean verify
