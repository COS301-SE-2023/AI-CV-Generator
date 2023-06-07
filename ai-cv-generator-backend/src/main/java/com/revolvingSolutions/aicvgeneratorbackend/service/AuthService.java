package com.revolvingSolutions.aicvgeneratorbackend.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;

@Service
public class AuthService {

    @Value("${app.tokenExpire-factor}")
    private String expFactor;

    @Value("${app.key}")
    private String key;

    public String getUsername(String token) {
        return extractCl(token,Claims::getSubject);
    }

    private Claims extract(String token) {
        return Jwts.parserBuilder().setSigningKey(
                getKey()
        ).build().parseClaimsJws(
                token
        ).getBody();
    }

    public <T> T extractCl(String token, Function<Claims,T> resolver) {
        final Claims cl = extract(token);
        return  resolver.apply(cl);
    }

    private Key getKey() {
        byte[] bytes = Decoders.BASE64.decode(key);
        return Keys.hmacShaKeyFor(bytes);
    }

    public String genToken(
            UserDetails details
    ) {
        return Jwts
                .builder()
                .setClaims(new HashMap<>())
                .setSubject(details.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000 *Long.parseLong(expFactor)))
                .signWith(getKey(),SignatureAlgorithm.HS512)
                .compact();
    }
    public String genToken(
            Map<String, Object> cls,
            UserDetails details
    ) {
        return Jwts
                .builder()
                .setClaims(cls)
                .setSubject(details.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000*Long.parseLong(expFactor)))
                .signWith(getKey(), SignatureAlgorithm.HS512)
                .compact();
    }

    public boolean validate(String token,UserDetails details) {
        final String name = getUsername(token);
        if (!name.equals(details.getUsername())) return false;
        return !isExpired(token);
    }

    private boolean isExpired(String token) {
        return getExpirationDate(token).before(new Date());
    }

    private Date getExpirationDate(String token) {
        return extractCl(token, Claims::getExpiration);
    }
}
