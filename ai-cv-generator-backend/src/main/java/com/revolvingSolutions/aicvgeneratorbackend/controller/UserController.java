package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.request.UploadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(value="*")
@RequestMapping(path = "/api/User")
public class UserController {
    @Autowired
    UserService service;

    @GetMapping(value="/user")
    public ResponseEntity<String> getUser() {
        return ResponseEntity.ok("");
    }

    @PostMapping(value="/user")
    public ResponseEntity<String> updateUser() {
        return ResponseEntity.ok("");
    }
    @PutMapping(value="/file")
    public ResponseEntity<String> uploadFile(@RequestBody UploadFileRequest request) {
        return ResponseEntity.ok(service.uploadFile(request));
    }

    @GetMapping(value="/file")
    public ResponseEntity<List<FileModel>> getFile() {
        return ResponseEntity.ok(service.getFile());
    }

    @GetMapping(value = "test")
    public ResponseEntity<String> test() {
        return ResponseEntity.ok("Hello auth is working");
    }

}
