package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.auth.*;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.*;
import com.revolvingSolutions.aicvgeneratorbackend.service.AuthenticationService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatusCode;
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
    public ResponseEntity<RegisterResponse> register(
            @RequestBody RegRequest request,
            HttpServletRequest actualRequest
    ) {
        return ResponseEntity.ok(service.register(request,actualRequest));
    }

    @PostMapping("/verify")
    public ResponseEntity<VerificationResponse> verify(
            @RequestBody VerificationRequest request
            ) {
        return  ResponseEntity.ok(service.verify(request));
    }

    @PostMapping("/authenticate")
    public ResponseEntity<AuthResponse> authenticate(
            @RequestBody AuthRequest request,
            HttpServletRequest actualRequest
    ) {
        try {
            return ResponseEntity.ok(service.authenticate(request,actualRequest));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatusCode.valueOf(403)).build();
        }
    }

    @PostMapping("/resend")
    public ResponseEntity<ResendEmailResponse> resend(
            @RequestBody ResendEmailRequest request,
            HttpServletRequest actualRequest
    ) {
        try {
            return ResponseEntity.ok(service.resendEmail(request,actualRequest));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatusCode.valueOf(405)).build();
        }
    }

    @PostMapping("/reset")
    public ResponseEntity<ResetPasswordResponse> reset(
            @RequestBody ResetPasswordRequest request,
            HttpServletRequest actualRequest
    ) {
        try {
            return ResponseEntity.ok(service.reset(request,actualRequest));
        } catch (Exception e) {
            return  ResponseEntity.status(HttpStatusCode.valueOf(403)).build();
        }
    }

    @PostMapping("/validate")
    public ResponseEntity<ValidatePasswordResetResponse> validateReset(
            @RequestBody ValidatePasswordResetRequest request,
            HttpServletRequest actualRequest
    ) {
        try {
            return ResponseEntity.ok(service.validateReset(request,actualRequest));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatusCode.valueOf(403)).build();
        }
    }

    @PostMapping("/change")
    public ResponseEntity<ChangePasswordResponse> changePassword(
            @RequestBody ChangePasswordRequest request,
            HttpServletRequest actualRequest
    ) {
        try {
            return ResponseEntity.ok(service.changePassword(request,actualRequest));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatusCode.valueOf(403)).build();
        }
    }

    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(
            @RequestBody RefreshRequest request,
            HttpServletRequest actualRequest
    ) {
        return  ResponseEntity.ok(service.refresh(request,actualRequest));
    }
}
