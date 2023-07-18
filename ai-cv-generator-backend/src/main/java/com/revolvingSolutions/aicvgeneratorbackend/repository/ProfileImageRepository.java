package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ProfileImageEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModelForList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProfileImageRepository extends JpaRepository<Integer, ProfileImageEntity> {
    @Query("SELECT new  FROM FileEntity f WHERE f.user.username = ?1")
    public ProfileImageEntity getProfileImageFromUser(String username);
}
