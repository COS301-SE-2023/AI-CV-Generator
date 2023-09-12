package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.PasswordResetTokenEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

public interface PasswordResetTokenEntityRepository extends JpaRepository<PasswordResetTokenEntity,Long> {
    public PasswordResetTokenEntity findByToken(String value);
    @Modifying
    int deleteByUser(UserEntity user);
}
