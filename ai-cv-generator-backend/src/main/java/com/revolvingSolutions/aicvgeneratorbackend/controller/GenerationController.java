package com.revolvingSolutions.aicvgeneratorbackend.controller;


import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.GenerationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.GenerationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

//Will have to do with actual generation of the CV
@RestController
@CrossOrigin(value="*")
@RequestMapping(path = "/generate")
@RequiredArgsConstructor
public class GenerationController {
    private final GenerationService generationService;

    @PostMapping(value = "/gen")
    public ResponseEntity<GenerationResponse> generate(
            @RequestBody GenerationRequest request
            ) {
        return ResponseEntity.ok(
                generationService.generateCV(
                        request
                )
        );
    }
}
