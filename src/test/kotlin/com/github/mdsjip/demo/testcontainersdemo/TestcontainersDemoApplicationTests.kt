package com.github.mdsjip.demo.testcontainersdemo

import org.junit.jupiter.api.Test
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.DynamicPropertyRegistry
import org.springframework.test.context.DynamicPropertySource
import org.testcontainers.containers.PostgreSQLContainer
import org.testcontainers.junit.jupiter.Container
import org.testcontainers.junit.jupiter.Testcontainers
import org.testcontainers.utility.DockerImageName

@SpringBootTest
@Testcontainers
class TestcontainersDemoApplicationTests {

    @Test
    fun contextLoads() {
    }

    class KPostgreSQLContainer :
        PostgreSQLContainer<KPostgreSQLContainer>(DockerImageName.parse("postgres"))

    companion object {
        @DynamicPropertySource
        @JvmStatic
        fun postgresqlProperties(registry: DynamicPropertyRegistry) = with(registry) {
            add("spring.datasource.url") { postgreSQLContainer.jdbcUrl }
            add("spring.datasource.password") { postgreSQLContainer.password }
            add("spring.datasource.username") { postgreSQLContainer.username }
        }

        @Container
        @JvmStatic
        val postgreSQLContainer: PostgreSQLContainer<*> = KPostgreSQLContainer()
            .withPassword("inmemory")
            .withUsername("inmemory")
    }
}
