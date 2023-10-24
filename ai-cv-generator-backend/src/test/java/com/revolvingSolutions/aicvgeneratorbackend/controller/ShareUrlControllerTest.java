package com.revolvingSolutions.aicvgeneratorbackend.controller;

import com.revolvingSolutions.aicvgeneratorbackend.request.file.RetrieveFileWithURLRequest;
import com.revolvingSolutions.aicvgeneratorbackend.service.ShareService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.UUID;

import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.mockito.Mockito.verify;

class ShareUrlControllerTest {

    private ShareUrlController shareUrlController;
    @Mock
    private ShareService shareService;
    AutoCloseable closeable;
    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
        shareUrlController = new ShareUrlController(shareService);
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    @Test
    void getSharedFile() {
        // given
        RetrieveFileWithURLRequest req = RetrieveFileWithURLRequest.builder()
                .uuid(UUID.randomUUID())
                .build();
        // when
        shareUrlController.getSharedFile(req);
        // then
        verify(shareService).RetrieveUrl(req);
    }

    @Test
    void getSharedFileWithURL() {
        // when
        shareUrlController.getSharedFileWithURL(UUID.randomUUID());
        // then
        ArgumentCaptor<RetrieveFileWithURLRequest> requestArgumentCaptor =ArgumentCaptor.forClass(RetrieveFileWithURLRequest.class);
        verify(shareService).RetrieveUrl(requestArgumentCaptor.capture());
        assertThat(requestArgumentCaptor.getValue().getUuid() != null).isTrue();
    }
}