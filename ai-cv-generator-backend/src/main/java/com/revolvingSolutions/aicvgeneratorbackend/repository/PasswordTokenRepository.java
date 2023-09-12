package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.PasswordTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PasswordTokenRepository extends JpaRepository<PasswordTokenEntity,Long> {
    public PasswordTokenEntity findByPasswordToken(String token);

    Long removeByPasswordToken(String token);
}
