package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.PasswordTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PasswordTokenRepository extends JpaRepository<PasswordTokenEntity,Long> {

    Optional<PasswordTokenEntity> findByPasswordToken(String token);

    Long removeByPasswordToken(String token);
}
