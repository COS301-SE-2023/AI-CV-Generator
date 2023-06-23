package com.revolvingSolutions.aicvgeneratorbackend.entitiy;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity()
@Table(name="files")
public class FileEntity{
    @Id
    @GeneratedValue
    public Integer fileid;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "uid", referencedColumnName = "userid")
    public UserEntity user;
    @Column(unique = true,nullable = false)
    public String filename;
    public String filetype;

    @Lob
    public byte[] data;
}