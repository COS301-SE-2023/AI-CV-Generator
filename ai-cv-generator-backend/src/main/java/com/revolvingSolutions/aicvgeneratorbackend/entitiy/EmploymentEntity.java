package com.revolvingSolutions.aicvgeneratorbackend.entitiy;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity()
@Table(name="employment")
public class EmploymentEntity {
    @Id
    @GeneratedValue
    public Integer empid;

    @ManyToOne()
    @JoinColumn(name = "uid", referencedColumnName = "userid")
    @JsonBackReference
    public UserEntity user;

    public String company;
    public String title;
    public Date startdate;
    public Date enddate;
}
