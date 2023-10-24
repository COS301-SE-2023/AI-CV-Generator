package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.revolvingSolutions.aicvgeneratorbackend.converter.StringConverter;
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
import java.util.Set;

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

    @Column(nullable = false)
    @Convert(converter = StringConverter.class)
    public String fname;
    @Column(nullable = false)
    @Convert(converter = StringConverter.class)
    public String lname;

    @Column(unique = true,nullable = false)
    @Convert(converter = StringConverter.class)
    public String username;
    @Column(nullable = false)
    @Convert(converter = StringConverter.class)
    public String password;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    @JsonManagedReference
    public List<FileEntity> files;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    @JsonManagedReference
    public List<EmploymentEntity> employmentHistory;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    @JsonManagedReference
    public List<QualificationEntity> qualifications;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    @JsonManagedReference
    public List<LinkEntity> links;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    public List<ReferenceEntity> references;

    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
    public List<SkillEntity> skills;

    @OneToMany(mappedBy = "user")
    public Set<RegistrationTokenEntity> regTokens;

    @OneToMany(mappedBy = "user")
    public Set<PasswordTokenEntity> passwordResetToken;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    @JsonManagedReference
    public ChatMemory chatMemory;

    @Enumerated(EnumType.STRING)
    public Role role;

    private boolean enabled;

    @Column(nullable = false,updatable = false)
    @Convert(converter = StringConverter.class)
    public String email;

    @Convert(converter = StringConverter.class)
    public String location;
    @Convert(converter = StringConverter.class)
    public String phoneNumber;
    @Convert(converter = StringConverter.class)
    public String description;

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
        return username;
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
        return enabled;
    }
}
