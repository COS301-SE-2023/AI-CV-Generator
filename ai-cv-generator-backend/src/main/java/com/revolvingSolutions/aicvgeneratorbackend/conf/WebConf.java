package com.revolvingSolutions.aicvgeneratorbackend.conf;


import jakarta.servlet.FilterRegistration;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import java.util.Arrays;

@Configuration
@EnableWebMvc
@RequiredArgsConstructor
public class WebConf {
    private static final Long MAX_AGE = 3600L;

    private static final int CORS_FILTER_ORDER = -102;

//    @Bean
//    public CorsFilter corsFilter() {
//        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//        CorsConfiguration corsConfiguration = new CorsConfiguration();
//        corsConfiguration.setAllowCredentials(true);
//        corsConfiguration.addAllowedOriginPattern("http://localhost:**");
//        corsConfiguration.setAllowedMethods(Arrays.asList(
//                HttpMethod.GET.name(),
//                HttpMethod.POST.name(),
//                HttpMethod.PUT.name(),
//                HttpMethod.OPTIONS.name()
//        ));
//        corsConfiguration.setMaxAge(MAX_AGE);
//        source.registerCorsConfiguration("/**",corsConfiguration);
//        return new CorsFilter(source);
//    }
}
