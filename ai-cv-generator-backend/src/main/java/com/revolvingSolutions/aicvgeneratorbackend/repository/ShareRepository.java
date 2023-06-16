package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ShareEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ShareRepository extends JpaRepository<ShareEntity, UUID> {

    @Query("SELECT f FROM ShareEntity f WHERE f.ExpireDate < ?1")
    public List<ShareEntity> getExpiredURLs(Date now);
    Optional<ShareEntity> findByFilename(String filename);
}
