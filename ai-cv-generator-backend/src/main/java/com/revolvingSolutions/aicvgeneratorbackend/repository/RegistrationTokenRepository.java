package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.RegistrationTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RegistrationTokenRepository extends JpaRepository<RegistrationTokenEntity,Long> {
    public RegistrationTokenEntity findByRegistrationToken(String token);
    Long removeByRegistrationToken(String token);
}
