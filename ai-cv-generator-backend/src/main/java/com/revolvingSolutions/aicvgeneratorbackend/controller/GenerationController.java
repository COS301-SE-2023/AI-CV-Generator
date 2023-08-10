package com.revolvingSolutions.aicvgeneratorbackend.controller;


import com.revolvingSolutions.aicvgeneratorbackend.request.AI.ExtractionRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.ExtractionResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.GenerationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.LangChainService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(value="*")
@RequestMapping(path = "/generate")
@RequiredArgsConstructor
public class GenerationController {
    private final LangChainService generationService;
    @PostMapping(value="/gen")
    public ResponseEntity<GenerationResponse> generate(
            @RequestBody GenerationRequest request
    ) {
        try {
            return ResponseEntity.ok(generationService.GenerateCV(request));
        } catch (Exception e) {
            System.out.println(e.getClass());
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value = "/extract")
    public  ResponseEntity<ExtractionResponse> extractData(
            @RequestBody ExtractionRequest request
    ) {
        try {
            return ResponseEntity.ok(
                    generationService.extractData(request)
            );
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
}
