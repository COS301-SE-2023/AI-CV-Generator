package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.PasswordTokenEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.PasswordTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.keygen.BytesKeyGenerator;
import org.springframework.security.crypto.keygen.KeyGenerators;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Base64;

@Service
public class PasswordTokenService {
    private static final BytesKeyGenerator TOKEN_GENERATOR = KeyGenerators.secureRandom();
    private static final int validationPeriod = 2000;
    @Autowired
    private PasswordTokenRepository passwordResetTokenRepository;

    public PasswordTokenEntity generateToken(UserEntity user) {
        String value = Base64.getUrlEncoder().encodeToString(TOKEN_GENERATOR.generateKey());
        PasswordTokenEntity token = PasswordTokenEntity.builder()
                .passwordToken(value)
                .expireAt(LocalDateTime.now().plusSeconds(validationPeriod))
                .user(user)
                .build();
        passwordResetTokenRepository.save(token);
        return  token;
    }

    public void removeToken(PasswordTokenEntity passwordToken) {
        passwordResetTokenRepository.delete(passwordToken);
    }

    public PasswordTokenEntity findToken(String value) {
        return  passwordResetTokenRepository.findByPasswordToken(value).orElseThrow();
    }

    public void save(PasswordTokenEntity token) {
        passwordResetTokenRepository.save(token);
    }

}
