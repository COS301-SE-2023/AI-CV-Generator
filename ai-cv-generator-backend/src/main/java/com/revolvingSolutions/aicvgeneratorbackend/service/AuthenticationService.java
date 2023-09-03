package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RefreshToken;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.RefreshException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UserAlreadyExistsException;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.AuthRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RefreshRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RegRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.AuthResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.RegisterResponse;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
     private  final UserRepository repository;
     private final PasswordEncoder passwordEncoder;
     private final  AuthService authService;
     private final RefreshTokenService refreshTokenService;
     private final AuthenticationManager authenticationManager;
    public RegisterResponse register(RegRequest request, HttpServletRequest actualRequest) {
        if (repository.findByUsername(request.getUsername()).isPresent()) {
            return RegisterResponse.builder()
                    .success(false)
                    .build();
        }

        byte[] array = new byte[7]; // length is bounded by 7
        new Random().nextBytes(array);
        String generatedString = new String(array, StandardCharsets.UTF_8);
        var _user = UserEntity.builder()
                .fname(request.getFname())
                .lname(request.getLname())
                .username(request.getUsername())
                .password(passwordEncoder.encode(request.getPassword()))
                .email(request.getEmail())
                .verificationCode(generatedString)
                .role(Role.USER)
                .enabled(false)
                .build();
        repository.save(_user);
        return RegisterResponse.builder()
                .success(true)
                .build();
    }

    public AuthResponse authenticate(AuthRequest request, HttpServletRequest actualRequest) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );
        var _user = repository.findByUsername(request.getUsername()).orElseThrow();
        var token = authService.genToken(_user,getClientIp(actualRequest));
        refreshTokenService.deleteByUserId(_user.userid);
        String refreshToken = refreshTokenService.createRefreshToken(_user.userid).getToken();
        return AuthResponse.builder()
                .token(token)
                .refreshToken(refreshToken)
                .build();
    }

    public AuthResponse refresh(RefreshRequest request, HttpServletRequest actualRequest) {
        String token = request.getRefreshToken();
        return refreshTokenService.findByToken(token)
                .map(refreshTokenService::verifyExpiration)
                .map(RefreshToken::getUser)
                .map(user -> {
                    String newtoken = authService.genToken(user,getClientIp(actualRequest));
                    return new AuthResponse(newtoken, token);
                        }
                )
                .orElseThrow(() -> new RefreshException(token, "Refresh token is not in database!"));

    }

    public String getClientIp(HttpServletRequest request) {
        String remoteAddr = "";
        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }
        return remoteAddr;
    }
}
