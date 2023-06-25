package com.revolvingSolutions.aicvgeneratorbackend.response.file;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.core.io.ByteArrayResource;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class InnerResponse {
    private String filename;
    private ByteArrayResource bytes;
}
