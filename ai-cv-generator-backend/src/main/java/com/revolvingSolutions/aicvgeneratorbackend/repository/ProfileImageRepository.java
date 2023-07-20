package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ProfileImageEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProfileImageRepository extends JpaRepository<ProfileImageEntity,Integer> {
    Optional<ProfileImageEntity> findByUser(UserEntity user);
}
