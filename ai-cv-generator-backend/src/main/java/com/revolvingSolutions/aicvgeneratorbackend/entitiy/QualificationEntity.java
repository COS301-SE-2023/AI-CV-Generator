package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity()
@Table(name="qualification")
public class QualificationEntity {
    @Id
    @GeneratedValue
    public Integer quaid;

    @ManyToOne()
    @JoinColumn(name = "uid", referencedColumnName = "userid")
    @JsonBackReference
    public UserEntity user;

    public String qualification;
    public String intstitution;
    public Date date;
}
