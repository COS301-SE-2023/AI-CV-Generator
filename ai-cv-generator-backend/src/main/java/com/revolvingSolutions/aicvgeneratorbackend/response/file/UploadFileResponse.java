package com.revolvingSolutions.aicvgeneratorbackend.response.file;

import com.revolvingSolutions.aicvgeneratorbackend.response.auth.Code;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UploadFileResponse {
    Code code;
}
