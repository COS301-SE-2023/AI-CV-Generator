package com.revolvingSolutions.aicvgeneratorbackend.request.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ValidatePasswordResetRequest {
    private String token;
}
