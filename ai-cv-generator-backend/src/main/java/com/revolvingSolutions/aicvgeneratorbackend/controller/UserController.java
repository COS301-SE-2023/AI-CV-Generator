package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.details.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.RemoveEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.UpdateEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.AddEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.RemoveEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.UpdateEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.file.GetFilesResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.GetUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.UpdateUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

    @PostMapping(value="/addEmp")
    public ResponseEntity<AddEmploymentResponse> addEmp(
            @RequestBody AddEmploymentRequest request
            ) {
        return ResponseEntity.ok(service.addEmployment(request));
    }

    @PostMapping(value="/remEmp")
    public ResponseEntity<RemoveEmploymentResponse> removeEmp(
            @RequestBody RemoveEmploymentRequest request
    ) {
        return ResponseEntity.ok(service.removeEmployment(request));
    }

    @PostMapping(value="/updateEmp")
    public ResponseEntity<UpdateEmploymentResponse> updateEmp(
            @RequestBody UpdateEmploymentRequest request
    ) {
        return ResponseEntity.ok(service.updateEmployment_(request));
    }

    @GetMapping(value = "/test")
    public ResponseEntity<String> test() {
        return ResponseEntity.ok("Hello auth is working");
    }

}
