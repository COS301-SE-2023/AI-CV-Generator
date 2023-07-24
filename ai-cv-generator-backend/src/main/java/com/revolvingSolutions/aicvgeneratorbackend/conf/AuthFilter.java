package com.revolvingSolutions.aicvgeneratorbackend.conf;

import com.revolvingSolutions.aicvgeneratorbackend.service.AuthService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class AuthFilter extends OncePerRequestFilter {

    private final AuthService authService;
    private final UserDetailsService uDetailService;
    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {
        System.out.println(
                request.getMethod()
        );
        final String header = request.getHeader("Authorization");
        System.out.println(
                request.getAuthType()
        );
        if (header != null && header.startsWith("Bearer")) {
            final String token = header.substring(7);
            final String username = authService.getUsername(token);
            if (username != null) {
                if (SecurityContextHolder.getContext().getAuthentication() == null) {
                    UserDetails details = uDetailService.loadUserByUsername(username);
                    if (authService.validate(token,details)) {
                        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(details,null,details.getAuthorities());
                        authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                        SecurityContextHolder.getContext().setAuthentication(authToken);
                    }
                }
            } else {
                System.out.println("Error with auth token");
            }
            filterChain.doFilter(request,response);
        } else {
            filterChain.doFilter(request,response);
            return;
        }
    }
}
