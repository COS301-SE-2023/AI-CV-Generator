package com.revolvingSolutions.aicvgeneratorbackend.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FileModelForList {
    private String filename;
    private byte[] cover;
}
