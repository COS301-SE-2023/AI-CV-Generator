package com.revolvingSolutions.aicvgeneratorbackend.conf;

import com.revolvingSolutions.aicvgeneratorbackend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Configuration
@RequiredArgsConstructor
public class appConf {

    private final UserRepository repository;
    @Bean
    public UserDetailsService userDetailsService() {
        return username -> repository.findByUsername(username).orElseThrow(
                () -> new UsernameNotFoundException("User Does not exist")
        );
    }

}
