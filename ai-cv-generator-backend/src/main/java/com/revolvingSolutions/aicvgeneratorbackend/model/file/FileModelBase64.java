package com.revolvingSolutions.aicvgeneratorbackend.model.file;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FileModelBase64 {
    private String filename;
    private String cover;
}
