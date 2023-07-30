package com.revolvingSolutions.aicvgeneratorbackend.response.file;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DownloadFileResponse {
    private byte[] data;
    private String filename;
    private String filetype;
}
