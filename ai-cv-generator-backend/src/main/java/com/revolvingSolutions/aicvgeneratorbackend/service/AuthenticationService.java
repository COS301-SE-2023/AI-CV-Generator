package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RefreshToken;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RegistrationTokenEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.RefreshException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UserAlreadyExistsException;
import com.revolvingSolutions.aicvgeneratorbackend.model.email.Email;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.AuthRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RefreshRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RegRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.VerificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.AuthResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.Code;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.RegisterResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.VerificationResponse;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
     private  final UserRepository repository;
     private final PasswordEncoder passwordEncoder;
     private final  AuthService authService;
     private final RefreshTokenService refreshTokenService;
     private final AuthenticationManager authenticationManager;
     private final EmailService emailService;
     private final RegistrationTokenService registrationTokenService;

     @Value("${app.api.blockEmailVerification}")
     private Boolean requireEmailVerification;
    public RegisterResponse register(RegRequest request, HttpServletRequest actualRequest) {
        if (repository.findByUsername(request.getUsername()).isPresent() && repository.findByUsername(request.getUsername()).get().isEnabled()) {
            return RegisterResponse.builder()
                    .code(Code.failed)
                    .build();
        } else if (repository.findByUsername(request.getUsername()).isPresent()) {
            UserEntity user = repository.findByUsername(request.getUsername()).orElseThrow();
            if (!passwordEncoder.matches(request.getPassword(),user.getPassword())) {
                return RegisterResponse.builder()
                        .code(Code.failed)
                        .build();
            }
            RegistrationTokenEntity token = registrationTokenService.generateToken(user);
            repository.save(user);
            try {
                emailService.sendVerificationEmail(
                        request.getEmail(),
                        (request.getFname() + " " + request.getLname()),
                        getSiteURL(actualRequest),
                        token.getRegistrationToken()
                );
            } catch (MessagingException | UnsupportedEncodingException e) {
                return RegisterResponse.builder()
                        .code(Code.failed)
                        .build();
            }
            return RegisterResponse.builder()
                    .code(Code.success)
                    .build();
        }
        try {
            var _user = UserEntity.builder()
                    .fname(request.getFname())
                    .lname(request.getLname())
                    .username(request.getUsername())
                    .password(passwordEncoder.encode(request.getPassword()))
                    .email(request.getEmail())
                    .role(Role.USER)
                    .enabled(false)
                    .build();
            repository.save(_user);
            RegistrationTokenEntity token = registrationTokenService.generateToken(_user);
            emailService.sendVerificationEmail(
                    request.getEmail(),
                    (request.getFname() + " " + request.getLname()),
                    request.getSiteUrl(),
                    token.getRegistrationToken()
            );
        } catch (MessagingException | UnsupportedEncodingException e) {
            return RegisterResponse.builder()
                    .code(Code.failed)
                    .build();
        }
        return RegisterResponse.builder()
                .code(Code.success)
                .build();
    }

    public VerificationResponse verify(VerificationRequest request) {
        RegistrationTokenEntity registrationToken = registrationTokenService.findToken(request.getRegistrationToken());
        if (registrationToken == null ) {
            return VerificationResponse.builder()
                    .code(Code.failed)
                    .build();
        } else if (! LocalDateTime.now().isBefore(registrationToken.getExpireAt())) {
            registrationTokenService.removeToken(registrationToken);
            return  VerificationResponse.builder()
                    .code(Code.expired)
                    .build();
        } else {
            UserEntity user = repository.getReferenceById(registrationToken.getUser().getUserid());
            user.setEnabled(true);
            repository.save(user);
            registrationTokenService.removeToken(registrationToken);
            return  VerificationResponse.builder()
                    .code(Code.success)
                    .build();
        }
    }

    private String getSiteURL(HttpServletRequest request) {
        String siteURL = request.getRequestURL().toString();
        return siteURL.replace(request.getServletPath(), "");
    }
    public AuthResponse authenticate(AuthRequest request, HttpServletRequest actualRequest) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            request.getUsername(),
                            request.getPassword()
                    )
            );
        } catch (DisabledException e) {
            UserEntity user = repository.findByUsername(request.getUsername()).orElseThrow();
            if (passwordEncoder.matches(request.getPassword(), user.getPassword())) {
                return AuthResponse.builder()
                        .code(Code.notEnabled)
                        .build();
            }
        }
        var _user = repository.findByUsername(request.getUsername()).orElseThrow();
        if (!requireEmailVerification&&!_user.isEnabled()) {
            throw new RuntimeException();
        }
        var token = authService.genToken(_user,getClientIp(actualRequest));
        refreshTokenService.deleteByUserId(_user.userid);
        String refreshToken = refreshTokenService.createRefreshToken(_user.userid).getToken();


        return AuthResponse.builder()
                .code(Code.success)
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
                    if (!requireEmailVerification&&!user.isEnabled()) {
                        throw new RefreshException(token,"Not registered!");
                    }
                    String newtoken = authService.genToken(user,getClientIp(actualRequest));
                    return new AuthResponse(Code.success,newtoken, token);
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
