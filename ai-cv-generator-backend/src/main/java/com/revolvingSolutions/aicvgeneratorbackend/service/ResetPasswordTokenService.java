package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.PasswordResetTokenEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.PasswordResetTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.keygen.BytesKeyGenerator;
import org.springframework.security.crypto.keygen.KeyGenerators;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Base64;

@Service
public class ResetPasswordTokenService {
    private static final BytesKeyGenerator TOKEN_GENERATOR = KeyGenerators.secureRandom();
    private static final int validationPeriod = 2000;
    @Autowired
    private PasswordResetTokenRepository passwordResetTokenRepository;

    public PasswordResetTokenEntity generateToken(UserEntity user) {
        String value = Base64.getUrlEncoder().encodeToString(TOKEN_GENERATOR.generateKey());
        PasswordResetTokenEntity token = PasswordResetTokenEntity.builder()
                .token(value)
                .expireAt(LocalDateTime.now().plusSeconds(validationPeriod))
                .user(user)
                .build();
        passwordResetTokenRepository.save(token);
        return  token;
    }

    public void removeToken(PasswordResetTokenEntity token) {
        passwordResetTokenRepository.delete(token);
    }

    public PasswordResetTokenEntity findToken(String value) {
        return  passwordResetTokenRepository.findByToken(value);
    }

}
