package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ShareEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.FileNotFoundException;
import com.revolvingSolutions.aicvgeneratorbackend.model.file.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.repository.ShareRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.RetrieveFileWithURLRequest;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ShareService {
    private final ShareRepository shareRepository;

    @Transactional
    public ResponseEntity<Resource> RetrieveUrl(RetrieveFileWithURLRequest request) {
        try {
            ShareEntity share = shareRepository.getByUuid(request.getUuid()).orElseThrow();
            if (update(share)) {
                throw new FileNotFoundException("Expired");
            }
            FileModel file = FileModel.builder()
                    .filename(share.getFilename())
                    .filetype(share.getFiletype())
                    .data(share.getData())
                    .build();
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

    private Boolean update(ShareEntity getting) {
        List<ShareEntity> expired = shareRepository.getExpiredURLs(LocalDateTime.now());
        shareRepository.deleteAllInBatch(shareRepository.getExpiredURLs(LocalDateTime.now()));
        shareRepository.flush();
        return expired.contains(getting);
    }

}
