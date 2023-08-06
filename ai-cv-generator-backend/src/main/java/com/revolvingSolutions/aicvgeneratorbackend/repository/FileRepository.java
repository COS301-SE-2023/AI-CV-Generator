package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.FileEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModelForList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface FileRepository extends JpaRepository<FileEntity,Integer> {

    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModelForList(f.filename,f.cover) FROM FileEntity f WHERE f.user.username = ?1")
    public List<FileModelForList> getFilesFromUser(String username);

    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModel(f.filename,f.filetype,f.data) FROM FileEntity f WHERE f.user.username = ?1")
    public List<FileModel> getAllFilesFromUser(String username);

    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModel(f.filename,f.filetype,f.data,f.cover) FROM FileEntity f WHERE f.user.username = ?1 and f.filename = ?2")
    public List<FileModel> getFileFromUser(String username,String filename);
}
