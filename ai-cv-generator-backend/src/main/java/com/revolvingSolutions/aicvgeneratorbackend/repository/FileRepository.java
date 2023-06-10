package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.FileEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface FileRepository extends JpaRepository<FileEntity,Integer> {

    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.FileModel(f.filename) FROM FileEntity f WHERE f.user.username = ?1")
    public List<FileModel> getFilesFromUser(String username);
}
