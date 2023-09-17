package com.revolvingSolutions.aicvgeneratorbackend.service;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class JobScrapeRunner implements CommandLineRunner {

    private final LinkedinService linkedinService;
    private final CareerJunctionService careerJunctionService;
    private final CareerBuildersService careerBuildersService;

    public JobScrapeRunner(LinkedinService linkedinService, CareerJunctionService careerJunctionService, CareerBuildersService careerBuildersService) {
        this.linkedinService = linkedinService;
        this.careerJunctionService = careerJunctionService;
        this.careerBuildersService = careerBuildersService;
    }

    @Override
    public void run(String... args) throws Exception {

    }
}
