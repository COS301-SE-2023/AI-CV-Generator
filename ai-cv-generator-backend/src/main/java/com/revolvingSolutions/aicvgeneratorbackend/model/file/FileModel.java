package com.revolvingSolutions.aicvgeneratorbackend.model.file;

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
    private byte[] cover;

    public FileModel(String filename) {
        this.filename = filename;
    }
    public FileModel(String filename,byte[] cover) {
        this.filename = filename;
        this.cover = cover;
    }
}
