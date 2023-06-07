package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.AuthRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.RegRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.AuthResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationService service;
    @PostMapping("/reg")
    public ResponseEntity<AuthResponse> register(
            @RequestBody RegRequest request
    ) {
        return ResponseEntity.ok(service.register(request));
    }

    @PostMapping(value = "/authenticate")
    public ResponseEntity<AuthResponse> authenticate(
            @RequestBody AuthRequest request
    ) {
        return ResponseEntity.ok(service.authenticate(request));
    }
}
