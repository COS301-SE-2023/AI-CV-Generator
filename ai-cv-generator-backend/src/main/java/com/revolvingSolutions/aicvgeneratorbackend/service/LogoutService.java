package com.revolvingSolutions.aicvgeneratorbackend.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LogoutService implements LogoutHandler {

    private final AuthService authService;
    private final UserDetailsService uDetailService;
    @Override
    public void logout(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication) {
        final String authHeader = request.getHeader("Authorization");
        final String token;
        if (authHeader == null ||!authHeader.startsWith("Bearer ")) {
            return;
        }
        token = authHeader.substring(7);
        final String username = authService.getUsername(token);
        if (username != null) {
            UserDetails details = uDetailService.loadUserByUsername(username);
            if (!authService.invalidate(token,details)) {
                response.setStatus(403);
            }
        } else {
            response.setStatus(403);
        }

    }
}
