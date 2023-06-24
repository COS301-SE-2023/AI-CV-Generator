package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.*;
import com.revolvingSolutions.aicvgeneratorbackend.exception.FileNotFoundException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.NotIndatabaseException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UnknownErrorException;
import com.revolvingSolutions.aicvgeneratorbackend.model.*;
import com.revolvingSolutions.aicvgeneratorbackend.repository.*;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.AddEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.UpdateEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.AddLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.RemoveLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.link.UpdateLinkRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.AddQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.RemoveQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.qualification.UpdateQualificationRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.RemoveEmploymentRequest;
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
import com.revolvingSolutions.aicvgeneratorbackend.response.file.GetFilesResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.user.GenerateUrlResponse;
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

import java.sql.Date;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final FileRepository fileRepository;
    private final EmploymentRepository employmentRepository;
    private final QualificationRepository qualificationRepository;
    private final LinkRepository linkRepository;
    private final ShareRepository shareRepository;

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
                                .employmenthistory(getEmployments())
                                .qualifications(getQualifications())
                                .links(getLinks())
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
                .employees(getEmployments())
                .build();
    }

    public AddQualificationResponse addQualification(
            AddQualificationRequest request
    ) {
        QualificationEntity qua = QualificationEntity.builder()
                .user(getAuthenticatedUser())
                .qualification(request.getQualification().getQualification())
                .intstitution(request.getQualification().getIntstitution())
                .date(request.getQualification().getDate())
                .build();
        qualificationRepository.saveAndFlush(qua);
        return AddQualificationResponse.builder()
                .qualifications(getQualifications())
                .build();
    }

    public AddLinkResponse addLink(
            AddLinkRequest request
    ) {
        LinkEntity link = LinkEntity.builder()
                .user(getAuthenticatedUser())
                .url(request.getLink().getUrl())
                .build();
        linkRepository.saveAndFlush(link);
        return AddLinkResponse.builder()
                .links(getLinks())
                .build();
    }


    public RemoveEmploymentResponse removeEmployment(
            RemoveEmploymentRequest request
    ) {
        try {
            employmentRepository.deleteById(request.getEmployment().getEmpid());
            return RemoveEmploymentResponse.builder()
                    .employees(getEmployments())
                    .build();
        } catch (Exception e) {
            throw  new NotIndatabaseException("Employee missing "+e.getMessage());
        }
    }

    public RemoveQualificationResponse removeQualification(
            RemoveQualificationRequest request
    ) {
        try {
        qualificationRepository.deleteById(request.getQualification().getQuaid());
        qualificationRepository.flush();
        return RemoveQualificationResponse.builder()
                .qualifications(getQualifications())
                .build();
        } catch (Exception e) {
            throw  new NotIndatabaseException("Qualification missing "+e.getMessage());
        }
    }

    public RemoveLinkResponse removeLink(
            RemoveLinkRequest request
    ) {
        try {


            linkRepository.deleteById(request.getLink().getLinkid());
            linkRepository.flush();
            return RemoveLinkResponse.builder()
                    .links(getLinks())
                    .build();
        } catch (Exception e) {
            throw  new NotIndatabaseException("Link missing "+e.getMessage());
        }
    }

    private void updateEmployment(
            Employment entity
    ) {
        try {
            EmploymentEntity prev = employmentRepository.getReferenceById(entity.getEmpid());
            prev.setCompany(entity.getCompany());
            prev.setTitle(entity.getTitle());
            prev.setEnddate(entity.getEnddate());
            prev.setStartdate(entity.getStartdate());
            employmentRepository.save(prev);
        } catch (Exception e) {
            throw  new NotIndatabaseException("Employee missing "+e.getMessage());
        }
    }
    private void updateQualification(
            Qualification entity
    ) {
        try {
            QualificationEntity prev = qualificationRepository.getReferenceById(entity.getQuaid());
            prev.setQualification(entity.getQualification());
            prev.setIntstitution(entity.getIntstitution());
            prev.setDate(entity.getDate());
            qualificationRepository.save(prev);
        } catch (Exception e) {
            throw  new NotIndatabaseException("Qualification missing "+e.getMessage());
        }
    }

    private void updateLink(
            Link entity
    ) {
        try {
            LinkEntity prev = linkRepository.getReferenceById(entity.getLinkid());
            prev.setUrl(entity.getUrl());
            linkRepository.save(prev);
        } catch (Exception e) {
            throw  new NotIndatabaseException("Link missing "+e.getMessage());
        }
    }

    public UpdateEmploymentResponse updateEmployment_(
            UpdateEmploymentRequest request
    ) {
        try {
            EmploymentEntity prev = employmentRepository.getReferenceById(request.getEmployment().getEmpid());
            prev.setCompany(request.getEmployment().getCompany());
            prev.setTitle(request.getEmployment().getTitle());
            prev.setEnddate(request.getEmployment().getEnddate());
            prev.setStartdate(request.getEmployment().getStartdate());
            employmentRepository.saveAndFlush(prev);
            return UpdateEmploymentResponse.builder()
                    .employees(getEmployments())
                    .build();
        } catch (Exception e) {
            throw  new NotIndatabaseException("Employee missing "+e.getMessage());
        }
    }

    public UpdateQualificationResponse updateQualification_(
            UpdateQualificationRequest request
    ) {
        try {
            QualificationEntity prev = qualificationRepository.getReferenceById(request.getQualification().getQuaid());
            prev.setQualification(request.getQualification().getQualification());
            prev.setIntstitution(request.getQualification().getIntstitution());
            prev.setDate(request.getQualification().getDate());
            qualificationRepository.saveAndFlush(prev);
            return UpdateQualificationResponse.builder()
                    .qualifications(getQualifications())
                    .build();
        } catch (Exception e) {
            throw  new NotIndatabaseException("Qualification missing "+e.getMessage());
        }
    }

    public UpdateLinkResponse updateLink_(
            UpdateLinkRequest request
    ) {
        try {
            LinkEntity prev = linkRepository.getReferenceById(request.getLink().getLinkid());
            prev.setUrl(request.getLink().getUrl());
            linkRepository.saveAndFlush(prev);
            return UpdateLinkResponse.builder()
                    .links(getLinks())
                    .build();
        } catch (Exception e) {
            throw  new NotIndatabaseException("Link missing "+e.getMessage());
        }
    }

    public List<Employment> getEmployments() {
        return employmentRepository.getEmploymentHistoryFromUser(getAuthenticatedUser().getUsername());
    }

    public List<Qualification> getQualifications() {
        return qualificationRepository.getQualificationsFromUser(getAuthenticatedUser().getUsername());
    }

    public List<Link> getLinks() {
        return linkRepository.getLinksFromUser(getAuthenticatedUser().getUsername());
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

    @Transactional
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
            return ResponseEntity.notFound().build();
        }
    }
    public String uploadFile(MultipartFile request, MultipartFile cover) {
        try {
            FileEntity file = FileEntity.builder()
                    .user(getAuthenticatedUser())
                    .filename(request.getOriginalFilename())
                    .filetype(request.getContentType())
                    .data(request.getBytes())
                    .cover(cover.getBytes())
                    .build();
            fileRepository.save(file);
            return "Success";
        } catch (Exception e) {
            throw new UnknownErrorException("File exception!: "+e.getMessage());
        }
    }

    @Transactional
    public GenerateUrlResponse generateUrl(
            GenerateUrlRequest request
    ) {
        try {
            update();
            List<FileModel> files = fileRepository.getFileFromUser(getAuthenticatedUser().getUsername(),request.getFilename());
            if (files.size() != 1) {
                throw new Exception("Failed",null);
            }
            FileModel file = files.get(0);
            shareRepository.save(
                    ShareEntity.builder()
                            .filetype(file.getFiletype())
                            .filename(file.getFilename())
                            .data(file.getData())
                            .ExpireDate(Date.from(Instant.now().plusMillis(request.getDuration().toMillis())))
                            .build()
            );
            return GenerateUrlResponse.builder()
                    .generatedUrl(request.getBase()+"share/"+shareRepository.findByFilename(file.getFilename()).orElseThrow().getUuid().toString())
                    .build();
        } catch (Exception e) {
            throw new FileNotFoundException(request.getFilename()+" was not found!");
        }
    }

    public GenerateUrlResponse generateUrlFromFile(String base, MultipartFile file, Duration duration) {
        try {
            update();
            shareRepository.save(
                    ShareEntity.builder()
                            .filetype(file.getContentType())
                            .filename(file.getOriginalFilename())
                            .data(file.getBytes())
                            .ExpireDate(Date.from(Instant.now().plusMillis(duration.toMillis())))
                            .build()
            );
            return GenerateUrlResponse.builder()
                    .generatedUrl(base+"share/"+shareRepository.findByFilename(file.getOriginalFilename()).orElseThrow().getUuid().toString())
                    .build();
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

    private void update() {
        shareRepository.deleteAllInBatch(shareRepository.getExpiredURLs(java.util.Date.from(Instant.now())));
        shareRepository.flush();
    }
}
