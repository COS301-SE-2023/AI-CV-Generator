package com.revolvingSolutions.aicvgeneratorbackend.application;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class AiCvGeneratorBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(AiCvGeneratorBackendApplication.class, args);
	}

	@GetMapping(value="/")
	public String hello() {
		return "Hello world";
	}
}
