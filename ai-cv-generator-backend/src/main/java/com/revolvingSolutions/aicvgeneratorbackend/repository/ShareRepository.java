package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ShareEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ShareRepository extends JpaRepository<ShareEntity, UUID> {

    @Query("SELECT f FROM ShareEntity f WHERE f.ExpireDate < ?1")
    public List<ShareEntity> getExpiredURLs(LocalDateTime now);
    Optional<ShareEntity> findByFilename(String filename);

    Optional<ShareEntity> getByUuid(UUID id);
}
