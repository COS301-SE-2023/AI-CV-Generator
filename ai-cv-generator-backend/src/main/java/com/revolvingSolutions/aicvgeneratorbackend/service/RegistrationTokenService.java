package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RegistrationTokenEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.repository.RegistrationTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.keygen.BytesKeyGenerator;
import org.springframework.security.crypto.keygen.KeyGenerators;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Base64;

@Service
public class RegistrationTokenService {
    private static final BytesKeyGenerator TOKEN_GENERATOR = KeyGenerators.secureRandom();
    private static final int validationPeriod = 2000;
    @Autowired
    private RegistrationTokenRepository registrationTokenRepository;

    public RegistrationTokenEntity generateToken(UserEntity user) {
        String value = Base64.getUrlEncoder().encodeToString(TOKEN_GENERATOR.generateKey());
        RegistrationTokenEntity token = RegistrationTokenEntity.builder()
                .registrationToken(value)
                .expireAt(LocalDateTime.now().plusSeconds(validationPeriod))
                .user(user)
                .build();
        registrationTokenRepository.save(token);
        return token;
    }

    public void removeToken(RegistrationTokenEntity registrationToken) {
        registrationTokenRepository.delete(registrationToken);
    }

    public RegistrationTokenEntity findToken(String value) {
        return registrationTokenRepository.findByRegistrationToken(value);
    }
}
