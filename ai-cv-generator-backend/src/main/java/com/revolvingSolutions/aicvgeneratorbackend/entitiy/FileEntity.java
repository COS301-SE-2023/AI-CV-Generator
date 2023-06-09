package com.revolvingSolutions.aicvgeneratorbackend.entitiy;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity(name="file")
public class FileEntity implements Serializable {
    @Id
    @GeneratedValue
    public Integer fileid;

    public String filename;
}
