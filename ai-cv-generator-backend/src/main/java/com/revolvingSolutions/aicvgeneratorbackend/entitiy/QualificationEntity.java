package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

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

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "did", referencedColumnName = "detailsid")
    public DetailsEntity details;

    public String qualification;
    public String intstitution;
    public Date date;
}
