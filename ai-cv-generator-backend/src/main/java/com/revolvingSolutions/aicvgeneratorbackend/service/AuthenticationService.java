package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RefreshToken;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.Role;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.RefreshException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UserAlreadyExistsException;
import com.revolvingSolutions.aicvgeneratorbackend.model.email.Email;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.AuthRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RefreshRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.RegRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.AuthResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.Code;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.RegisterResponse;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
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
     private final EmailService emailService;
    public RegisterResponse register(RegRequest request, HttpServletRequest actualRequest) {
        if (repository.findByUsername(request.getUsername()).isPresent()) {
            return RegisterResponse.builder()
                    .code(Code.failed)
                    .build();
        }
        try {
            String verificationCode = generateVerificationCode();
            var _user = UserEntity.builder()
                    .fname(request.getFname())
                    .lname(request.getLname())
                    .username(request.getUsername())
                    .password(passwordEncoder.encode(request.getPassword()))
                    .email(request.getEmail())
                    .verificationCode(verificationCode)
                    .role(Role.USER)
                    .enabled(false)
                    .build();
            repository.save(_user);
            emailService.sendVerificationEmail(
                    request.getEmail(),
                    (request.getFname() + " " + request.getLname()),
                    getSiteURL(actualRequest),
                    verificationCode
            );
        } catch (MessagingException | UnsupportedEncodingException e) {
            return RegisterResponse.builder()
                    .code(Code.emailFailed)
                    .build();
        }
        return RegisterResponse.builder()
                .code(Code.success)
                .build();
    }

    private String getSiteURL(HttpServletRequest request) {
        String siteURL = request.getRequestURL().toString();
        return siteURL.replace(request.getServletPath(), "");
    }

    private String generateVerificationCode() {
        int leftLimit = 48;
        int rightLimit = 122;
        int targetStringLength = 7;
        Random random = new Random();

        return random.ints(leftLimit, rightLimit + 1)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
    }

    public AuthResponse authenticate(AuthRequest request, HttpServletRequest actualRequest) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );
        var _user = repository.findByUsername(request.getUsername()).orElseThrow();
        if (!_user.isEnabled()) {
            throw new RuntimeException();
        }
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
