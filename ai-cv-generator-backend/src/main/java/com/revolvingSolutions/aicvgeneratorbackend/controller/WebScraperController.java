package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.model.aimodels.JobClassification;
import com.revolvingSolutions.aicvgeneratorbackend.model.webscrapper.JobResponseDTO;
import com.revolvingSolutions.aicvgeneratorbackend.request.webscraper.JobScrapeRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.webscraper.JobScrapeResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.CareerBuildersService;
import com.revolvingSolutions.aicvgeneratorbackend.service.CareerJunctionService;
import com.revolvingSolutions.aicvgeneratorbackend.service.LinkedinService;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import dev.langchain4j.classification.TextClassifier;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.atomic.AtomicInteger;

@RestController
@CrossOrigin("*")
@RequestMapping(path = "/api/scrape")
@RequiredArgsConstructor
public class WebScraperController {

    private final LinkedinService linkedinService;
    private final CareerBuildersService careerBuildersService;
    private final CareerJunctionService careerJunctionService;
    private final TextClassifier<JobClassification> classifier;
    private final UserService userService;
    @PostMapping(value = "/jobs")
    public ResponseEntity<JobScrapeResponse> jobScrape(
            @RequestBody JobScrapeRequest request
            ) {
        try {
            CompletableFuture<Set<JobResponseDTO>> linkedIn = linkedinService.linkedIn(request);
            CompletableFuture<Set<JobResponseDTO>> careerBuild = careerBuildersService.CBRE(request);
            CompletableFuture<Set<JobResponseDTO>> careerJunc = careerJunctionService.careerJunction(request);
            CompletableFuture.allOf(linkedIn).join();
            Set<JobResponseDTO> responseDTOS = new HashSet<>();
            responseDTOS.addAll(linkedIn.get());
            responseDTOS.addAll(careerBuild.get());
            responseDTOS.addAll(careerJunc.get());
            return ResponseEntity.ok(
                    JobScrapeResponse.builder()
                            .jobs(responseDTOS)
                            .build()
            );
        } catch (RuntimeException | IOException | ExecutionException | InterruptedException e) {
            return ResponseEntity.ok(
                    JobScrapeResponse.builder()
                            .jobs(new HashSet<>())
                            .build()
            );
        }
    }

    @GetMapping(value = "/recommended")
    public  ResponseEntity<JobScrapeResponse> recommend() throws ExecutionException, InterruptedException {
        try {
            List<JobClassification> suggestions = classifier.classify(userService.getUser().toString());
            String field = "";
            if (!suggestions.isEmpty()) {
                field = suggestions.get(0).toString();
                System.out.println("Field: "+field);
            }
            JobScrapeRequest request = JobScrapeRequest.builder()
                    .field(field)
                    .location("")
                    .build();
            CompletableFuture<Set<JobResponseDTO>> linkedIn = linkedinService.linkedIn(request);
            CompletableFuture<Set<JobResponseDTO>> careerBuild = careerBuildersService.CBRE(request);
            CompletableFuture<Set<JobResponseDTO>> careerJunc = careerJunctionService.careerJunction(request);
            CompletableFuture.allOf(linkedIn).join();
            Set<JobResponseDTO> responseDTOS = new HashSet<>();
            responseDTOS.addAll(linkedIn.get());
            responseDTOS.addAll(careerBuild.get());
            responseDTOS.addAll(careerJunc.get());
            return ResponseEntity.ok(
                    JobScrapeResponse.builder()
                            .jobs(responseDTOS)
                            .build()
            );
        } catch (RuntimeException | IOException | ExecutionException | InterruptedException e) {
            return ResponseEntity.ok(
                    JobScrapeResponse.builder()
                            .jobs(new HashSet<>())
                            .build()
            );
        }
    }
}
