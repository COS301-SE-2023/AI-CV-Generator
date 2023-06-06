package com.revolvingSolutions.aicvgeneratorbackend.conf;

import com.revolvingSolutions.aicvgeneratorbackend.service.AuthService;
import com.revolvingSolutions.aicvgeneratorbackend.service.UserDetailService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class AuthFilter extends OncePerRequestFilter {

    private AuthService authService;
    private UserDetailService uDetailService;
    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {
        final String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer")) {
            final String token = header.substring(7);
            final String username = authService.getUsername(token);
            if (username != null) {
                if (SecurityContextHolder.getContext().getAuthentication() == null) {
                    //UserDetails details = this. tbc
                }
            }

        } else {
            filterChain.doFilter(request,response);
            return;
        }
    }
}
