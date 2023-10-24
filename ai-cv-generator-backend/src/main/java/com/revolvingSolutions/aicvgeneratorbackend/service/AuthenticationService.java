package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.*;
import com.revolvingSolutions.aicvgeneratorbackend.exception.RefreshException;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.auth.*;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.*;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
     private  final UserRepository repository;
     private final PasswordEncoder passwordEncoder;
     private final AuthService authService;
     private final RefreshTokenService refreshTokenService;
     private final AuthenticationManager authenticationManager;
     private final EmailService emailService;
     private final RegistrationTokenService registrationTokenService;
     private final PasswordTokenService resetPasswordTokenService;

     @Value("${app.api.blockEmailVerification}")
     private Boolean requireEmailVerification;
    public RegisterResponse register(RegRequest request, HttpServletRequest actualRequest) {
        if (repository.findByUsername(request.getUsername()).isPresent() && repository.findByUsername(request.getUsername()).get().isEnabled()) {
            return RegisterResponse.builder()
                    .code(Code.failed)
                    .build();
        } else if (repository.findByUsername(request.getUsername()).isPresent()) {
            UserEntity user = repository.findByUsername(request.getUsername()).orElseThrow();
            if (!passwordEncoder.matches(request.getPassword(),user.getPassword()) && request.getEmail().matches(user.getUsername())) {
                return RegisterResponse.builder()
                        .code(Code.failed)
                        .build();
            }
            RegistrationTokenEntity token = registrationTokenService.generateToken(user);
            repository.save(user);

            emailService.sendVerificationEmail(
                    request.getEmail(),
                    token.getRegistrationToken()
            );

            return RegisterResponse.builder()
                    .code(Code.success)
                    .build();
        }
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
                token.getRegistrationToken()
        );
        return RegisterResponse.builder()
                .code(Code.success)
                .build();
    }

    public ResendEmailResponse resendEmail(ResendEmailRequest request, HttpServletRequest actualRequest) {
        if (repository.findByUsername(request.getUsername()).isPresent() && repository.findByUsername(request.getUsername()).get().isEnabled()) {
            return ResendEmailResponse.builder()
                    .code(Code.failed)
                    .build();
        } else if (repository.findByUsername(request.getUsername()).isPresent()) {
            UserEntity user = repository.findByUsername(request.getUsername()).orElseThrow();
            if (!passwordEncoder.matches(request.getPassword(),user.getPassword())) {
                return ResendEmailResponse.builder()
                        .code(Code.failed)
                        .build();
            }
            RegistrationTokenEntity token = registrationTokenService.generateToken(user);
            repository.save(user);
            emailService.sendVerificationEmail(
                    user.getEmail(),
                    token.getRegistrationToken()
            );
            return ResendEmailResponse.builder()
                    .code(Code.success)
                    .build();
        }
        return ResendEmailResponse.builder()
                .code(Code.failed)
                .build();
    }

    public VerificationResponse verify(VerificationRequest request) {
        final RegistrationTokenEntity registrationToken = registrationTokenService.findToken(request.getRegistrationToken());
        if (registrationToken == null ) {
            return VerificationResponse.builder()
                    .code(Code.failed)
                    .build();
        } else if (registrationToken.getExpireAt().isBefore(LocalDateTime.now())) {
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
        var _user = repository.findByUsername(request.getUsername()).orElseThrow();
        if (!_user.isEnabled() && passwordEncoder.matches(request.getPassword(), _user.getPassword())) {
            return AuthResponse.builder()
                    .code(Code.notEnabled)
                    .build();
        }
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );
        var token = authService.genToken(_user,getClientIp(actualRequest));
        refreshTokenService.deleteByUserId(_user.userid);
        String refreshToken = refreshTokenService.createRefreshToken(_user.userid).getToken();


        return AuthResponse.builder()
                .code(Code.success)
                .token(token)
                .refreshToken(refreshToken)
                .build();
    }

    public ResetPasswordResponse reset(ResetPasswordRequest request, HttpServletRequest actualRequest) {
        UserEntity user = repository.findByUsername(request.getUsername()).orElseThrow();
        if (!user.getEmail().matches(request.getEmail())) {
            return ResetPasswordResponse.builder()
                    .code(Code.failed)
                    .build();
        }
        PasswordTokenEntity token = resetPasswordTokenService.generateToken(user);
        emailService.sendPasswordResetEmail(
                user.getEmail(),
                token.getPasswordToken()
        );
        return ResetPasswordResponse.builder()
                .code(Code.success)
                .build();

    }

    public ValidatePasswordResetResponse validateReset(ValidatePasswordResetRequest request, HttpServletRequest actualRequest) {
        final PasswordTokenEntity token = resetPasswordTokenService.findToken(request.getToken());
        if (token == null) {
            return ValidatePasswordResetResponse.builder()
                    .code(Code.failed)
                    .build();
        } else if (token.getExpireAt().isBefore(LocalDateTime.now())) {
            resetPasswordTokenService.removeToken(token);
            return ValidatePasswordResetResponse.builder()
                    .code(Code.expired)
                    .build();
        } else {
            return ValidatePasswordResetResponse.builder()
                    .code(Code.success)
                    .build();
        }
    }

    public ChangePasswordResponse changePassword(ChangePasswordRequest request, HttpServletRequest actualRequest) {
        final PasswordTokenEntity token = resetPasswordTokenService.findToken(request.getToken());
        if (token == null) {
            return ChangePasswordResponse.builder()
                    .code(Code.failed)
                    .build();
        } else if (token.getExpireAt().isBefore(LocalDateTime.now())) {
            resetPasswordTokenService.removeToken(token);
            return ChangePasswordResponse.builder()
                    .code(Code.expired)
                    .build();
        } else {
            UserEntity user = repository.getReferenceById(token.getUser().getUserid());
            user.setPassword(passwordEncoder.encode(request.getNewPassword()));
            repository.save(user);
            resetPasswordTokenService.removeToken(token);
            return ChangePasswordResponse.builder()
                    .code(Code.success)
                    .build();
        }
    }

    private void changePassword(UserEntity user, String password) {
        user.setPassword(passwordEncoder.encode(password));
        repository.save(user);
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
                    String newToken = authService.genToken(user,getClientIp(actualRequest));
                    return new AuthResponse(Code.success,newToken, token);
                        }
                )
                .orElseThrow(() -> new RefreshException(token, "Refresh token is not in database!"));

    }

    public String getClientIp(HttpServletRequest request) {
        if (request != null) {
            String remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || remoteAddr.isEmpty()) {
                remoteAddr = request.getRemoteAddr();
            }
        }
        return "";
    }
}
