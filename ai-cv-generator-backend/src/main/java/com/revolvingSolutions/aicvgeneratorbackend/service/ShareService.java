package com.revolvingSolutions.aicvgeneratorbackend.service;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.ShareEntity;
import com.revolvingSolutions.aicvgeneratorbackend.exception.FileNotFoundException;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import com.revolvingSolutions.aicvgeneratorbackend.repository.ShareRepository;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.DownloadFileRequest;
import com.revolvingSolutions.aicvgeneratorbackend.request.file.RetrieveFileWithURL;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Date;

@Service
@RequiredArgsConstructor
public class ShareService {
    private final ShareRepository shareRepository;

    @Transactional
    public ResponseEntity<Resource> RetriveUrl(RetrieveFileWithURL request) {
        try {
            update();
            ShareEntity share = shareRepository.getReferenceById(request.getUuid());
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

    private void update() {
        shareRepository.deleteAllInBatch(shareRepository.getExpiredURLs(Date.from(Instant.now())));
        shareRepository.flush();
    }

}
