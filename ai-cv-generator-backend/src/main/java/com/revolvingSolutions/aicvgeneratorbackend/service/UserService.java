package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.FileEntity;
import com.revolvingSolutions.aicvgeneratorbackend.entitiy.UserEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.UnknownErrorException;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.repository.FileRepository;
import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.UpdateUserRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.UploadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.response.GetFilesResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

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

    public String uploadFile(UploadFileRequest request) {
        FileEntity file = FileEntity.builder()
                .user(getAuthenticatedUser())
                .filename(request.getFilename())
                .filetype(request.getFiletype())
                .data(request.getData())
                .build();
        fileRepository.save(file);
        return "Success";
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
