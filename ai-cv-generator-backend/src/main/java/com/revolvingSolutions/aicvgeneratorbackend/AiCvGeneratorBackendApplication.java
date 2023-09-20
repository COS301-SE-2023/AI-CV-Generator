package com.revolvingSolutions.aicvgeneratorbackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.client.RestTemplate;

import java.util.concurrent.Executor;

@SpringBootApplication
@EnableAsync
public class AiCvGeneratorBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(AiCvGeneratorBackendApplication.class, args);
	}

	@Bean
	public RestTemplate getRestTemplate() {
		return new RestTemplate();
	}

	@Bean
	public Executor asyncExecutor() {
        return new ThreadPoolTaskExecutor();
	}

}
