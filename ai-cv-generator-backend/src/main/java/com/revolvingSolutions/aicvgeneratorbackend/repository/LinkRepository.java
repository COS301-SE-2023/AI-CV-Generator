package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.LinkEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.Link;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LinkRepository extends JpaRepository<LinkEntity,Integer> {
    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.user.Link(f.linkid,f.url) FROM LinkEntity f WHERE f.user.username = ?1")
    public List<Link> getLinksFromUser(String username);
}
