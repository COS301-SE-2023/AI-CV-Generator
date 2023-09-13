package com.revolvingSolutions.aicvgeneratorbackend.response.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ResendEmailResponse {
    private Code code;
}
