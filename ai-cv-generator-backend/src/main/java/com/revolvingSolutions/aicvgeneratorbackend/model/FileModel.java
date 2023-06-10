package com.revolvingSolutions.aicvgeneratorbackend.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FileModel {
    private String filename;
    private String filetype;
    private byte[] data;

    public FileModel(String filename) {
        this.filename = filename;
    }
}
