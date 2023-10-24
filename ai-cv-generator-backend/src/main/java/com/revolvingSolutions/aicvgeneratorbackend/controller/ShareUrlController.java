package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.file.RetrieveFileWithURLRequest;
import com.revolvingSolutions.aicvgeneratorbackend.service.ShareService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@CrossOrigin(value="*")
@RequestMapping(path = "/share")
@RequiredArgsConstructor
public class ShareUrlController {

    private final ShareService service;
    @PostMapping(value="")
    public ResponseEntity<Resource> getSharedFile(
            @RequestBody RetrieveFileWithURLRequest request
            ) {
        return service.RetrieveUrl(request);
    }

    @GetMapping(value="{uuid}")
    public ResponseEntity<Resource> getSharedFileWithURL(
            @PathVariable("uuid")UUID uuid
            ) {
        return service.RetrieveUrl(
                RetrieveFileWithURLRequest.builder()
                        .uuid(uuid)
                        .build()
        );
    }
}
