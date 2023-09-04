package com.revolvingSolutions.aicvgeneratorbackend.response.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AuthResponse {
    private Code code;
    private String token;
    private String refreshToken;
}
