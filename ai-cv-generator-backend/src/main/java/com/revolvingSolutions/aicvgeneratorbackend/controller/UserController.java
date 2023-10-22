package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.exception.FileNotFoundException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.NotIndatabaseException;
import com.revolvingSolutions.aicvgeneratorbackend.model.email.Email;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.RemoveEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.UpdateEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.AddLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.RemoveLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.UpdateLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.AddQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.RemoveQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.UpdateQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.reference.AddReferenceRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.reference.RemoveReferenceRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.reference.UpdateReferenceRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.skill.AddSkillRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.skill.RemoveSkillRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.skill.UpdateSkillRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.GenerateUrlRequest;
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
import com.revolvingSolutions.aicvgeneratorbackend.response.details.reference.AddReferenceResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.reference.RemoveReferenceResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.reference.UpdateReferenceResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.skill.AddSkillResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.skill.RemoveSkillResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.skill.UpdateSkillResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.file.GetFilesResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.file.UploadFileResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.GenerateUrlResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.GetUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.UpdateUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.service.EmailService;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.Date;

@RestController
@CrossOrigin("*")
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

    @GetMapping(value = "/profimg")
    public ResponseEntity<Resource> getProfileImage() {
        return service.getProfileImage();
    }

    @PostMapping(value = "/updateprofimg")
    public ResponseEntity<Resource> updateProfileImage(
            @RequestParam("img")MultipartFile img
            ) {
        return  service.updateProfileImage(img);
    }

    @PostMapping(value="/file")
    public ResponseEntity<UploadFileResponse> uploadFile(
            @RequestParam("file")MultipartFile file,
            @RequestParam("cover")MultipartFile cover
            ) {
        return ResponseEntity.ok(service.uploadFile(file,cover));
    }

    @PostMapping(value="/shareFile")
    public ResponseEntity<GenerateUrlResponse> uploadFileAndShare(
            @RequestParam("file")MultipartFile file,
            @RequestParam("hours")Integer hours
            ) {
        try {
            GenerateUrlResponse response = service.generateUrlFromFile(file,hours);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatusCode.valueOf(404)).build();
        }

    }

    @PostMapping(value="/retfile")
    public ResponseEntity<Resource> downloadFile(
            @RequestBody DownloadFileRequest request
            ) {
        return service.downloadFile(request);
    }

    @GetMapping(value="/files")
    public ResponseEntity<GetFilesResponse> getFiles() {
        return ResponseEntity.ok(service.getFiles());
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
    public ResponseEntity<UpdateEmploymentResponse> updateEmployment(
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
    public ResponseEntity<UpdateQualificationResponse> updateQualification(
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
    public ResponseEntity<UpdateLinkResponse> updateLink(
            @RequestBody UpdateLinkRequest request
    ) {
        try {
            return ResponseEntity.ok(service.updateLink_(request));
        } catch (NotIndatabaseException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value="/addRef")
    public ResponseEntity<AddReferenceResponse> addReference(
            @RequestBody AddReferenceRequest request
            ) {
        return ResponseEntity.ok(service.addReference(request));
    }

    @PostMapping(value="/remRef")
    public ResponseEntity<RemoveReferenceResponse> removeReference(
            @RequestBody RemoveReferenceRequest request
            ) {
        try {
            return ResponseEntity.ok(service.removeReference(request));
        } catch ( NotIndatabaseException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value="/updateRef")
    public ResponseEntity<UpdateReferenceResponse> updateReference(
            @RequestBody UpdateReferenceRequest request
            ) {
        try {
            return ResponseEntity.ok(service.updateReference_(request));
        } catch (NotIndatabaseException e) {
            return ResponseEntity.notFound().build();
        }

    }

    @PostMapping(value="/addSkill")
    public  ResponseEntity<AddSkillResponse> addSkill(
            @RequestBody AddSkillRequest request
            ) {
        return ResponseEntity.ok(service.addSkill(request));
    }

    @PostMapping(value = "/remSkill")
    public ResponseEntity<RemoveSkillResponse> removeSkill(
            @RequestBody RemoveSkillRequest request
            ) {
        try {
            return ResponseEntity.ok(service.removeSkill(request));
        } catch (NotIndatabaseException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value = "/updateSkill")
    public  ResponseEntity<UpdateSkillResponse> updateSkill(
            @RequestBody UpdateSkillRequest request
            ) {
        try {
            return ResponseEntity.ok(service.updateSkill_(request));
        } catch (NotIndatabaseException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value="/share")
    public ResponseEntity<GenerateUrlResponse> generateURL(
            @RequestBody GenerateUrlRequest request
            ) {
        try {
            return ResponseEntity.ok(service.generateUrl(request));
        } catch (FileNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }

}
