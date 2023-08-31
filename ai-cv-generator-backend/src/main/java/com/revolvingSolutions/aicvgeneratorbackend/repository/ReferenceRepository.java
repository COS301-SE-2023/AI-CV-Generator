package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ReferenceEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Reference;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ReferenceRepository extends JpaRepository<ReferenceEntity,Integer> {
    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.user.Reference(f.refid,f.description,f.contact) FROM ReferenceEntity f WHERE f.user.username = ?1")
    public List<Reference> getReferencesFromUser(String username);
}
