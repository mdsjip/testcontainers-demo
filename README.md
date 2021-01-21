# testcontainers-demo

This repository is created to demonstrate Spring Boot project testing with Maven and [testcontainers](https://github.com/testcontainers/testcontainers-java/) on a host with [Rootless Docker](https://docs.docker.com/engine/security/rootless/) setup.

## Usage

Make sure you completed all installation steps [here](https://docs.docker.com/engine/security/rootless/#install)

Using host and Maven wrapper
```shell
make verify-with-mvnw
```

Using Maven image:
```shell
make verify-with-maven-image
```

---
## Getting Started with Spring Boot

### Reference Documentation
For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.4.2/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/2.4.2/maven-plugin/reference/html/#build-image)
* [Spring Web](https://docs.spring.io/spring-boot/docs/2.4.2/reference/htmlsingle/#boot-features-developing-web-applications)
* [Spring Data JPA](https://docs.spring.io/spring-boot/docs/2.4.2/reference/htmlsingle/#boot-features-jpa-and-spring-data)

### Guides
The following guides illustrate how to use some features concretely:

* [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
* [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
* [Building REST services with Spring](https://spring.io/guides/tutorials/bookmarks/)
* [Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)

