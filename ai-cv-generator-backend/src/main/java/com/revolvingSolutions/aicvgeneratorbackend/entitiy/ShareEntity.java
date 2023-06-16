package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "sharedUrls")
public class ShareEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(unique = true)
    private UUID uuid;

    @Column(nullable = false)
    public String filename;
    public String filetype;

    public Date ExpireDate;

    @Lob
    public byte[] data;
}
