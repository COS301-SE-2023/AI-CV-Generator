package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.*;
import com.revolvingSolutions.aicvgeneratorbackend.exception.FileNotFoundException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.NotIndatabaseException;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UnknownErrorException;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModelBase64;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModelForList;
import com.revolvingSolutions.aicvgeneratorbackend.model.user.*;
import com.revolvingSolutions.aicvgeneratorbackend.repository.*;
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.AddEmploymentRequest;
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
import com.revolvingSolutions.aicvgeneratorbackend.request.details.employment.RemoveEmploymentRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.GenerateUrlRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.user.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.auth.Code;
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
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
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

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final FileRepository fileRepository;
    private final EmploymentRepository employmentRepository;
    private final QualificationRepository qualificationRepository;
    private final LinkRepository linkRepository;
    private final ReferenceRepository referenceRepository;
    private final SkillRepository skillRepository;
    private final ShareRepository shareRepository;
    private final ProfileImageRepository profileImageRepository;
    private final UUIDGenerator generator;

    private final PasswordEncoder encoder;

    @Value("${app.frontend.url}")
    private String url;
    public GetUserResponse getUser() {
        UserEntity dbuser = getAuthenticatedUser();
        return GetUserResponse.builder()
                .user(
                        User.builder()
                                .fname(dbuser.getFname())
                                .lname(dbuser.getLname())
                                .username(dbuser.getUsername())
                                .email(dbuser.getEmail())
                                .location(dbuser.getLocation())
                                .phoneNumber(dbuser.getPhoneNumber())
                                .description(dbuser.getDescription())
                                .employmenthistory(getEmployments())
                                .qualifications(getQualifications())
                                .links(getLinks())
                                .references(getReferences())
                                .skills(getSkills())
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
                .endo(request.getQualification().getEndo())
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

    public AddReferenceResponse addReference(
            AddReferenceRequest request
    ) {
        referenceRepository.saveAndFlush(
                ReferenceEntity.builder()
                        .user(getAuthenticatedUser())
                        .description(request.getReference().getDescription())
                        .contact(request.getReference().getContact())
                        .build()
        );
        return AddReferenceResponse.builder()
                .references(getReferences())
                .build();
    }

    public AddSkillResponse addSkill(
            AddSkillRequest request
    ) {
        skillRepository.saveAndFlush(
                SkillEntity.builder()
                        .user(getAuthenticatedUser())
                        .level(request.getSkill().getLevel())
                        .skill(request.getSkill().getSkill())
                        .reason(request.getSkill().getReason())
                        .build()
        );
        return AddSkillResponse.builder()
                .skills(getSkills())
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

    public RemoveReferenceResponse removeReference(
            RemoveReferenceRequest request
    ) {
        try {
            referenceRepository.deleteById(request.getReference().getRefid());
            referenceRepository.flush();
            return RemoveReferenceResponse.builder()
                    .references(getReferences())
                    .build();
        } catch (Exception e) {
            throw new NotIndatabaseException("Reference missing "+e.getMessage());
        }
    }

    public RemoveSkillResponse removeSkill(
            RemoveSkillRequest request
    ) {
        try {
            skillRepository.deleteById(request.getSkill().getSkillid());
            skillRepository.flush();
            return RemoveSkillResponse.builder()
                    .skills(getSkills())
                    .build();
        } catch (Exception e) {
            throw new NotIndatabaseException("Skill missing "+e.getMessage());
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
            prev.setEndo(request.getQualification().getEndo());
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

    public UpdateReferenceResponse updateReference_(
            UpdateReferenceRequest request
    ) {
        try {
            ReferenceEntity prev = referenceRepository.getReferenceById(request.getReference().getRefid());
            prev.setDescription(request.getReference().getDescription());
            prev.setContact(request.getReference().getContact());
            referenceRepository.saveAndFlush(prev);
            return UpdateReferenceResponse.builder()
                    .references(getReferences())
                    .build();
        } catch (Exception e) {
            throw new NotIndatabaseException("Reference missing "+e.getMessage());
        }
    }

    public UpdateSkillResponse updateSkill_(
            UpdateSkillRequest request
    ) {
        try {
            SkillEntity prev = skillRepository.getReferenceById(request.getSkill().getSkillid());
            prev.setSkill(request.getSkill().getSkill());
            prev.setLevel(request.getSkill().getLevel());
            prev.setReason(request.getSkill().getReason());
            skillRepository.saveAndFlush(prev);
            return UpdateSkillResponse.builder()
                    .skills(getSkills())
                    .build();
        } catch (Exception e) {
            throw new NotIndatabaseException("Skill missing "+e.getMessage());
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

    public List<Reference> getReferences() {
        return referenceRepository.getReferencesFromUser(getAuthenticatedUser().getUsername());
    }

    public List<Skill> getSkills() {
        return skillRepository.getSkillsFromUser(getAuthenticatedUser().getUsername());
    }

    public UpdateUserResponse updateUser(UpdateUserRequest request) {
        UserEntity user = getAuthenticatedUser();
        user.setFname(request.getUser().getFname());
        user.setLname(request.getUser().getLname());
        user.setUsername(request.getUser().getUsername());
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
    public GetFilesResponse getFiles() {
        List<FileModelForList> files = fileRepository.getFilesFromUser(getAuthenticatedUser().getUsername());
        List<FileModelBase64> newFiles = new ArrayList<>();
        for (FileModelForList file : files) {
            newFiles.add(
                FileModelBase64.builder()
                .filename(file.getFilename())
                .cover(Base64.getEncoder().encodeToString(file.getCover()))
                .build()
            );
        }
        return GetFilesResponse.builder()
                .files(newFiles)
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

    @Transactional
    public ResponseEntity<Resource> getFileCover(DownloadFileRequest request) {
        try {
            FileModel file = fileRepository.getFileFromUser(getAuthenticatedUser().getUsername(), request.getFilename()).get(0);
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(file.getFiletype()))
                    .header(
                            HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + file.getFilename() + "\""
                    )
                    .body(
                            new ByteArrayResource(file.getCover())
                    );
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
    public UploadFileResponse uploadFile(MultipartFile request, MultipartFile cover) {
        if (!fileRepository.getFileFromUser(getAuthenticatedUser().getUsername(),request.getOriginalFilename()).isEmpty()) {
            return UploadFileResponse.builder()
                    .code(Code.failed)
                    .build();
        }
        try {
            FileEntity file = FileEntity.builder()
                    .user(getAuthenticatedUser())
                    .filename(request.getOriginalFilename())
                    .filetype(request.getContentType())
                    .data(request.getBytes())
                    .cover(cover.getBytes())
                    .build();
            fileRepository.save(file);
            return UploadFileResponse.builder()
                    .code(Code.success)
                    .build();
        } catch (Exception e) {
            return UploadFileResponse.builder()
                    .code(Code.failed)
                    .build();
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
                            .ExpireDate(LocalDateTime.now().plus(request.getDuration()))
                            .build()
            );
            return GenerateUrlResponse.builder()
                    .generatedUrl(request.getBase()+"share/"+shareRepository.findByFilename(file.getFilename()).orElseThrow().getUuid().toString())
                    .build();
        } catch (Exception e) {
            throw new FileNotFoundException(request.getFilename()+" was not found!");
        }
    }


    @Transactional
    public GenerateUrlResponse generateUrlFromFile(MultipartFile file, Integer hours) throws IOException {
            update();
            UUID id = generator.generateID();
            shareRepository.save(
                ShareEntity.builder()
                        .uuid(id)
                        .filetype(file.getContentType())
                        .filename(file.getName())
                        .data(file.getBytes())
                        .ExpireDate(LocalDateTime.now().plusHours(hours))
                        .build()
            );

            return GenerateUrlResponse.builder()
                    .generatedUrl(url+"/share/"+id)
                    .build();

    }

    @Transactional
    public ResponseEntity<Resource> getProfileImage() {
        try {
            ProfileImageEntity img = profileImageRepository.findByUser(getAuthenticatedUser()).orElseThrow();
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(img.getType()))
                    .header(
                            HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + "profimage" + "\""
                    )
                    .body(
                            new ByteArrayResource(img.getImgdata())
                    );
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @Transactional
    public ResponseEntity<Resource> updateProfileImage(
            MultipartFile file
    ) {
        try {


            ProfileImageEntity img = profileImageRepository.findByUser(getAuthenticatedUser()).orElse(
                    ProfileImageEntity.builder()
                            .user(getAuthenticatedUser())
                            .imgdata(file.getBytes())
                            .type(file.getContentType())
                            .build()
            );
            img.setImgdata(file.getBytes());
            img.setType(file.getContentType());
            profileImageRepository.save(img);
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(img.getType()))
                    .header(
                            HttpHeaders.CONTENT_DISPOSITION,
                            "attachment; filename=\"" + "profimage" + "\""
                    )
                    .body(
                            new ByteArrayResource(img.getImgdata())
                    );
        } catch (Exception e) {
            return  ResponseEntity.notFound().build();
        }
    }

    private UserEntity getAuthenticatedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication instanceof AnonymousAuthenticationToken)) {
            String currentUserName = authentication.getName();
            return userRepository.findByUsername(currentUserName).orElseThrow();
        }
        throw new UnknownErrorException("This should not be possible");
    }

    private void update() {
        shareRepository.deleteAllInBatch(shareRepository.getExpiredURLs(LocalDateTime.now()));
        shareRepository.flush();
    }
}
