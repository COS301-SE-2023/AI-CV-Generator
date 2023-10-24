package com.revolvingSolutions.aicvgeneratorbackend.controller;


import com.revolvingSolutions.aicvgeneratorbackend.request.AI.ChatRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.ExtractionRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.GenerationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.AI.UrlExtractionRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.ChatResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.ExtractionResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.AI.GenerationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.LangChainService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatusCode;
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

    @PostMapping(value = "/urlExtract")
    public ResponseEntity<ExtractionResponse> extractUrlData(
            @RequestBody UrlExtractionRequest request
    ) {
        try {
            return ResponseEntity.ok(
                    generationService.extractUrlData(request)
            );
        } catch (Exception e) {
            return  ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value = "/chat")
    public ResponseEntity<ChatResponse> chat(
            @RequestBody ChatRequest request
    ) {
        try {
            return ResponseEntity.ok(
                    generationService.chatBotInteract(request)
            );
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatusCode.valueOf(405)).build();
        }
    }
}
