package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.model.User;
import com.revolvingSolutions.aicvgeneratorbackend.request.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.UploadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.DownloadFileResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.GetFilesResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.GetUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.UpdateUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@CrossOrigin(value="*")
@RequestMapping(path = "/api/User")
@RequiredArgsConstructor
public class UserController {
    private final UserService service;

    @GetMapping(value="/user")
    public ResponseEntity<GetUserResponse> getUser() {
        return ResponseEntity.ok(service.getUser());
    }

    @PostMapping(value="/user")
    public ResponseEntity<UpdateUserResponse> updateUser(
            @RequestBody UpdateUserRequest request
            ) {
        return ResponseEntity.ok(service.updateUser(request));
    }
    @PostMapping(value="/file")
    public ResponseEntity<String> uploadFile(
            @RequestParam("file")MultipartFile file
            ) {
        return ResponseEntity.ok(service.uploadFile(file));
    }

    @PostMapping(value="/retfile")
    public ResponseEntity<Resource> downloadFile(
            @RequestBody DownloadFileRequest request
            ) {
        return service.downloadFile(request);
    }

    @GetMapping(value="/files")
    public ResponseEntity<GetFilesResponse> getFiles() {
        return ResponseEntity.ok(service.getFile());
    }

    @GetMapping(value = "/test")
    public ResponseEntity<String> test() {
        return ResponseEntity.ok("Hello auth is working");
    }

}
