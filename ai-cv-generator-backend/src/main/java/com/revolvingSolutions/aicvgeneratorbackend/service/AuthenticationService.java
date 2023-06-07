package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.AuthRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.RegRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.AuthResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
     private  final UserRepository repository;
     private final PasswordEncoder passwordEncoder;
     private final  AuthService authService;
     private final AuthenticationManager authenticationManager;
    public AuthResponse register(RegRequest request) {
        var _user = UserEntity.builder()
                .fname(request.getFname())
                .lname(request.getLname())
                .username(request.getUsername())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(Role.USER)
                .build();
        repository.save(_user);
        var token = authService.genToken(_user);
        return AuthResponse.builder()
                .token(token)
                .build();
    }

    public AuthResponse authenticate(AuthRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );
        var _user = repository.findByUsername(request.getUsername()).orElseThrow();
        var token = authService.genToken(_user);
        return AuthResponse.builder()
                .token(token)
                .build();
    }
}
