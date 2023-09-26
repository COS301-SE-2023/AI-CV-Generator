package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;


@Data
@NoArgsConstructor
@EqualsAndHashCode
public class FileID implements Serializable {
    public Long fileid;
    public UserEntity user;

    public String filename;

    public FileID(Long fileid,UserEntity user, String filename) {
        this.fileid = fileid;
        this.user = user;
        this.filename = filename;
    }
}
