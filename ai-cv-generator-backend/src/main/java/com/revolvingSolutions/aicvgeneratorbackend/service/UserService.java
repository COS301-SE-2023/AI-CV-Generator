package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.EmploymentEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.FileEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.FileNotFoundException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UnknownErrorException;
import com.revolvingSolutions.aicvgeneratorbackend.model.Employment;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.model.User;
import com.revolvingSolutions.aicvgeneratorbackend.repository.EmploymentRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.FileRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.UpdateEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.RemoveEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.AddEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.RemoveEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.details.UpdateEmploymentResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.file.GetFilesResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.GetUserResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.UpdateUserResponse;
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

import java.util.List;

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
                .company(request.getEmployment().getCompany())
                .startdate(request.getEmployment().getStartdate())
                .enddate(request.getEmployment().getEnddate())
                .build();
        employmentRepository.saveAndFlush(emp);
        return AddEmploymentResponse.builder()
                .employees(getEmployment())
                .build();
    }

    public RemoveEmploymentResponse removeEmployment(
            RemoveEmploymentRequest request
    ) {
        employmentRepository.deleteById(request.getEmployment().getEmpid());
        employmentRepository.flush();
        return RemoveEmploymentResponse.builder()
                .employees(getEmployment())
                .build();
    }

    private void updateEmployment(
            Employment entity
    ) {
        EmploymentEntity prev = employmentRepository.getReferenceById(entity.getEmpid());
        prev.setCompany(entity.getCompany());
        prev.setTitle(entity.getTitle());
        prev.setEnddate(entity.getEnddate());
        prev.setStartdate(entity.getStartdate());
        employmentRepository.saveAndFlush(prev);
    }

    public UpdateEmploymentResponse updateEmployment_(
            UpdateEmploymentRequest request
    ) {
        EmploymentEntity prev = employmentRepository.getReferenceById(request.getEmployment().getEmpid());
        prev.setCompany(request.getEmployment().getCompany());
        prev.setTitle(request.getEmployment().getTitle());
        prev.setEnddate(request.getEmployment().getEnddate());
        prev.setStartdate(request.getEmployment().getStartdate());
        employmentRepository.saveAndFlush(prev);
        return UpdateEmploymentResponse.builder()
                .employees(getEmployment())
                .build();
    }

    public List<Employment> getEmployment() {
        return employmentRepository.getEmploymentHistoryFromUser(getAuthenticatedUser().getUsername());
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
