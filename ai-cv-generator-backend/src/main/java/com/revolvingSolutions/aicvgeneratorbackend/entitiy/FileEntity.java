package com.revolvingSolutions.aicvgeneratorbackend.entitiy;


import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity()
@Table(name="files")
@IdClass(FileID.class)
public class FileEntity{
    @Id
    @GeneratedValue
    public Long fileid;

    @Id
    @ManyToOne()
    @JoinColumn(name = "uid", referencedColumnName = "userid")
    @JsonBackReference
    public UserEntity user;

    @Id
    public String filename;
    public String filetype;

    @Lob
    public byte[] data;

    @Lob
    public byte[] cover;
}
