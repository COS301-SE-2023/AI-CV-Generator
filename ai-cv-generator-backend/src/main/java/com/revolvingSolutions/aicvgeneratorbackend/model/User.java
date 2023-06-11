package com.revolvingSolutions.aicvgeneratorbackend.model;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.EmploymentEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User {
    public String fname;
    public String lname;
    public String username;
    public String email;
    public String phoneNumber;
    public String location;
    public String description;
    public List<EmploymentEntity> employmenthistory;
}
