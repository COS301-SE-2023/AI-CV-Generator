package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "profileImage")
public class ProfileImageEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long imgid;

    @OneToOne
    @JoinColumn(name = "usersid", referencedColumnName = "userid")
    private UserEntity user;

    @Column(nullable = false)
    @Lob
    private byte[] imgdata;

    @Column(nullable = false)
    private String type;
}
