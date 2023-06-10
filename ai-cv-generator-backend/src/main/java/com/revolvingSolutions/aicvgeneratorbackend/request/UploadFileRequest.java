package com.revolvingSolutions.aicvgeneratorbackend.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UploadFileRequest {
    private String filename;
    private String filetype;
    private byte[] data;
}
