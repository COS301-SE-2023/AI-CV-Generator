package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.FileEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UnknownErrorException;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.repository.FileRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.UploadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.DownloadFileResponse;
import com.revolvingSolutions.aicvgeneratorbackend.response.GetFilesResponse;
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
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final FileRepository fileRepository;
    private final PasswordEncoder encoder;
    public UserEntity getUser() {
        return getAuthenticatedUser();
    }

    public UserEntity updateUser(UpdateUserRequest request) {
        UserEntity user = getAuthenticatedUser();
        user.setFname(request.getFname());
        user.setLname(request.getLname());
        user.setUsername(request.getUsername());
        user.setPassword(encoder.encode(request.getPassword()));
        userRepository.save(user);
        return  user;
    }

    public GetFilesResponse getFile() {
        return GetFilesResponse.builder()
                .files(fileRepository.getFilesFromUser(getAuthenticatedUser().getUsername()))
                .build();
    }

    public ResponseEntity<Resource> downloadFile(DownloadFileRequest request) {
        FileModel file = fileRepository.getFileFromUser(getAuthenticatedUser().getUsername(), request.getFilename()).get(0);
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(file.getFiletype()))
                .header(
                        HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\""+file.getFilename()+"\""
                )
                .body(
                        new ByteArrayResource(file.getData())
                );

    }

    public String uploadFile(MultipartFile request) {
        try {
            FileEntity file = FileEntity.builder()
                    .user(getAuthenticatedUser())
                    .filename(request.getName())
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
