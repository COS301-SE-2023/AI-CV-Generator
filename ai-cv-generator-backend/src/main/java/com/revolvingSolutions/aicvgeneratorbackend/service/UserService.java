package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.EmploymentEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.FileEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.FileNotFoundException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UnknownErrorException;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.model.User;
import com.revolvingSolutions.aicvgeneratorbackend.repository.EmploymentRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.FileRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.RemoveEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final FileRepository fileRepository;
    private final EmploymentRepository employmentRepository;
    private final PasswordEncoder encoder;
    public GetUserResponse getUser() {
        UserEntity dbuser = getAuthenticatedUser();
        return GetUserResponse.builder()
                .user(
                        User.builder()
                                .fname(dbuser.getFname())
                                .lname(dbuser.getLname())
                                .username(dbuser.getUsername())
                                .email(dbuser.getEmail())
                                .description(dbuser.getLocation())
                                .build()
                )
                .build();
    }

    public AddEmploymentResponse addEmployment(
            AddEmploymentRequest request
    ) {
        EmploymentEntity emp = EmploymentEntity.builder()
                .user(getAuthenticatedUser())
                .title(request.getEmployment().getTitle())
                .company(request.getEmployment().getTitle())
                .startdate(request.getEmployment().getStartdate())
                .enddate(request.getEmployment().getEnddate())
                .build();
        employmentRepository.save(emp);
        return AddEmploymentResponse.builder()
                .employment(emp)
                .build();
    }

    public RemoveEmploymentResponse removeEmployment(
            RemoveEmploymentRequest request
    ) {
        employmentRepository.delete(request.getEmployment());
        return RemoveEmploymentResponse.builder()
                .message(request.getEmployment().getEmpid()+" removed")
                .build();
    }

    public void updateEmployment(
            EmploymentEntity entity
    ) {
        EmploymentEntity prev = employmentRepository.getReferenceById(entity.getEmpid());
        prev.setCompany(entity.getCompany());
        prev.setTitle(entity.getTitle());
        prev.setEnddate(entity.getEnddate());
        prev.setStartdate(entity.getStartdate());
        employmentRepository.save(prev);
    }

    public UpdateUserResponse updateUser(UpdateUserRequest request) {
        UserEntity user = getAuthenticatedUser();
        user.setFname(request.getUser().getFname());
        user.setLname(request.getUser().getLname());
        user.setUsername(request.getUser().getUsername());
        user.setEmail(request.getUser().getEmail());
        user.setLocation(request.getUser().getLocation());
        user.setPhoneNumber(request.getUser().getPhoneNumber());
        user.setDescription(request.getUser().getDescription());
        for (EmploymentEntity ent:
             request.getUser().getEmploymenthistory()) {
            updateEmployment(ent);
        }
        userRepository.save(user);
        return  UpdateUserResponse.builder()
                .user(
                        request.getUser()
                )
                .build();
    }

    public GetFilesResponse getFile() {
        return GetFilesResponse.builder()
                .files(fileRepository.getFilesFromUser(getAuthenticatedUser().getUsername()))
                .build();
    }

    @Transactional
    public ResponseEntity<Resource> downloadFile(DownloadFileRequest request) {
        try {


            FileModel file = fileRepository.getFileFromUser(getAuthenticatedUser().getUsername(), request.getFilename()).get(0);
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(file.getFiletype()))
                    .header(
                            HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + file.getFilename() + "\""
                    )
                    .body(
                            new ByteArrayResource(file.getData())
                    );
        } catch (Exception e) {
            throw new FileNotFoundException(request.getFilename()+" was not found in users folder ,Error: "+e.getMessage());
        }
    }
    public String uploadFile(MultipartFile request) {
        try {
            FileEntity file = FileEntity.builder()
                    .user(getAuthenticatedUser())
                    .filename(request.getOriginalFilename())
                    .filetype(request.getContentType())
                    .data(request.getBytes())
                    .build();
            fileRepository.save(file);
            return "Success";
        } catch (Exception e) {
            throw new UnknownErrorException("File exception!: "+e.getMessage());
        }
    }

    private UserEntity getAuthenticatedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            String currentUserName = authentication.getName();
            var user_ = userRepository.findByUsername(currentUserName).orElseThrow();
            return user_;
        }
        throw new UnknownErrorException("This should not be possible");
    }
}
