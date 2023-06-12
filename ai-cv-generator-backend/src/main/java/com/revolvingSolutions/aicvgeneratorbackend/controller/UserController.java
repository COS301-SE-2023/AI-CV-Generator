package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.exception.NotIndatabaseException;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.RemoveEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.UpdateEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.AddLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.RemoveLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.UpdateLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.AddQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.RemoveQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.UpdateQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.employment.AddEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.employment.RemoveEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.employment.UpdateEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.link.AddLinkResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.link.RemoveLinkResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.link.UpdateLinkResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.qualification.AddQualificationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.qualification.RemoveQualificationResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.qualification.UpdateQualificationResponse;
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
    public ResponseEntity<Object> updateEmployment(
            @RequestBody UpdateEmploymentRequest request
    ) {
        try {
            return ResponseEntity.ok(service.updateEmployment_(request));
        } catch (NotIndatabaseException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value="/addQua")
    public ResponseEntity<AddQualificationResponse> addQualification(
            @RequestBody AddQualificationRequest request
    ) {
        return ResponseEntity.ok(service.addQualification(request));
    }

    @PostMapping(value="/remQua")
    public ResponseEntity<RemoveQualificationResponse> removeQualification(
            @RequestBody RemoveQualificationRequest request
    ) {
        return ResponseEntity.ok(service.removeQualification(request));
    }

    @PostMapping(value="/updateQua")
    public ResponseEntity<Object> updateQualification(
            @RequestBody UpdateQualificationRequest request
    ) {
        try {
            return ResponseEntity.ok(service.updateQualification_(request));
        } catch (NotIndatabaseException e) {
            return ResponseEntity.notFound().build();
        }

    }

    @PostMapping(value="/addLink")
    public ResponseEntity<AddLinkResponse> addLink(
            @RequestBody AddLinkRequest request
    ) {
        return ResponseEntity.ok(service.addLink(request));
    }

    @PostMapping(value="/remLink")
    public ResponseEntity<RemoveLinkResponse> removeLink(
            @RequestBody RemoveLinkRequest request
    ) {
        return ResponseEntity.ok(service.removeLink(request));
    }

    @PostMapping(value="/updateLink")
    public ResponseEntity<Object> updateLink(
            @RequestBody UpdateLinkRequest request
    ) {
        try {
            return ResponseEntity.ok(service.updateLink_(request));
        } catch (NotIndatabaseException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping(value = "/test")
    public ResponseEntity<String> test() {
        return ResponseEntity.ok("Hello auth is working");
    }

}
