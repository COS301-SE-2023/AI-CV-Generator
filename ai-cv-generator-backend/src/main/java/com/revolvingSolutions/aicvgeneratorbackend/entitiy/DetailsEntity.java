package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity()
@Table(name="details")
public class DetailsEntity {
    @Id
    @GeneratedValue
    public Integer detailsid;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "uid", referencedColumnName = "userid")
    public UserEntity user;

    @OneToMany(mappedBy = "details")
    public List<EmploymentEntity> employmentHistory;

    @OneToMany(mappedBy = "details")
    public List<QualificationEntity> qualifications;

    @OneToMany(mappedBy = "details")
    public List<LinkEntity> links;
}
