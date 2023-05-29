package com.revolvingSolutions.aicvgeneratorbackend;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

public class ServletInitializer extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(AiCvGeneratorBackendApplication.class); // Replace DemoApplication with your main class
    }

}
