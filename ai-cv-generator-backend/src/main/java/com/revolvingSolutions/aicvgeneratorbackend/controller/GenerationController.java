package com.revolvingSolutions.aicvgeneratorbackend.controller;


import com.revolvingSolutions.aicvgeneratorbackend.request.generation.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.GenerationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.generation.MockGenerationResponse;
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

    @PostMapping(value= "/jythongenerate")
    public ResponseEntity<GenerationResponse> jythongenerate(
            @RequestBody GenerationRequest request
    ) {
        return ResponseEntity.ok(generationService.generateCV(request));
    }

    @PostMapping(value="/mockgenerate")
    public ResponseEntity<MockGenerationResponse> mockgenerate(
            @RequestBody GenerationRequest request
    ) {
        try {
            return ResponseEntity.ok(generationService.mockGenerateCV(request));
        } catch (Exception e) {
            System.out.println(e.getClass());
            return ResponseEntity.notFound().build();
        }
    }
}
