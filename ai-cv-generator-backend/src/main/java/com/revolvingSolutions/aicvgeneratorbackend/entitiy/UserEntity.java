package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "_user")
public class UserEntity implements UserDetails {

    @Id
    @GeneratedValue
    public Integer userid;

    public String fname;
    public String lname;
    public String email;
    public String password;

    @Enumerated(EnumType.STRING)
    public Role role;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.name()));
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

    //Not doing override for non expired
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    //Not doing override for non expired
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    //Not doing override for non expired
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    //Not doing override for non expired
    @Override
    public boolean isEnabled() {
        return true;
    }
}
