package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RefreshToken;
import com.revolvingSolutions.aicvgeneratorbackend.exception.RefreshException;
import com.revolvingSolutions.aicvgeneratorbackend.repository.RefreshTokenRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
public class RefreshTokenService {

    @Value("${app.tokenExpire-factor}")
    private Long refreshTokenExpirefactor;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    @Autowired
    private UserRepository userRepository;

    public Optional<RefreshToken> findByToken(String token) {
        return refreshTokenRepository.findByToken(token);
    }

    public RefreshToken createRefreshToken(int userId) {
        RefreshToken refreshToken = new RefreshToken();

        refreshToken.setUser(userRepository.findById(userId).get());
        refreshToken.setExpiryDate(Instant.now().plusMillis(1000*60*refreshTokenExpirefactor*2));
        refreshToken.setToken(UUID.randomUUID().toString());

        refreshToken = refreshTokenRepository.save(refreshToken);
        return refreshToken;
    }

    public RefreshToken verifyExpiration(RefreshToken token) {
        if (token.getExpiryDate().compareTo(Instant.now()) < 0) {
            refreshTokenRepository.delete(token);
            throw new RefreshException(token.getToken(), "Refresh token was expired. Please make a new signin request");
        }

        return token;
    }

    @Transactional
    public int deleteByUserId(int userId) {
        return refreshTokenRepository.deleteByUser(userRepository.findById(userId).get());
    }
}
