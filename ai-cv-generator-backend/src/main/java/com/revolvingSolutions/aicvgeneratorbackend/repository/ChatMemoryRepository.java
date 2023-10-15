package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ChatMemory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface ChatMemoryRepository extends JpaRepository<ChatMemory,Long> {
    Optional<ChatMemory> findByUserUserid(Integer userid);
}
