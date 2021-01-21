package com.github.mdsjip.demo.testcontainersdemo

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

@SpringBootApplication
class TestcontainersDemoApplication

fun main(args: Array<String>) {
    runApplication<TestcontainersDemoApplication>(*args)
}

@RestController
@RequestMapping("/api/persons")
class PersonsController(private val repository: PersonRepository) {
    @GetMapping
    fun getAll(): List<Person> = repository.findAll()

    @GetMapping("/{id}")
    fun getById(@PathVariable("id") id: Long) =
        repository.findById(id).orElseThrow { PersonNotFound }!!

    @PostMapping
    fun create(@RequestBody person: Person) =
        Person(name = person.name).also { repository.save(it) }

    @DeleteMapping("/{id}")
    fun deleteById(@PathVariable("id") id: Long) = repository.deleteById(id)
}

interface PersonRepository : JpaRepository<Person, Long>

@Entity
class Person(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    val name: String
)

@ResponseStatus(HttpStatus.NOT_FOUND)
object PersonNotFound : RuntimeException("person not found")
