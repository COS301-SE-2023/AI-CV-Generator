package com.revolvingSolutions.aicvgeneratorbackend.entitiy;


import com.fasterxml.jackson.annotation.JsonBackReference;
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

    @ManyToOne()
    @JoinColumn(name = "uid", referencedColumnName = "userid")
    @JsonBackReference
    public UserEntity user;

    public String filename;
    public String filetype;

    @Lob
    public byte[] data;
}
