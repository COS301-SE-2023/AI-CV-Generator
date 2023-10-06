package com.revolvingSolutions.aicvgeneratorbackend.request.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegRequest {
    private String fname;
    private String lname;
    private String email;
    private String username;
    private String password;
}
