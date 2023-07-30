package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.auth.AuthRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RefreshRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RegRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.AuthResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.AuthenticationService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(value="*")
@RequestMapping(path = "/api/auth")
@RequiredArgsConstructor
public class AuthController {

    @Autowired
    private final AuthenticationService service;

    @PostMapping("/reg")
    public ResponseEntity<AuthResponse> register(
            @RequestBody RegRequest request,
            HttpServletRequest actualRequest
    ) {
        return ResponseEntity.ok(service.register(request,actualRequest));
    }

    @PostMapping("/authenticate")
    public ResponseEntity<AuthResponse> authenticate(
            @RequestBody AuthRequest request,
            HttpServletRequest actualRequest
    ) {
        return ResponseEntity.ok(service.authenticate(request,actualRequest));
    }

    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(
            @RequestBody RefreshRequest request,
            HttpServletRequest actualRequest
    ) {
        return  ResponseEntity.ok(service.refresh(request,actualRequest));
    }
}
