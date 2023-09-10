package com.revolvingSolutions.aicvgeneratorbackend.model.user;

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
    public List<Employment> employmenthistory;
    public List<Qualification> qualifications;
    public List<Link> links;
    public List<Reference> references;
    public List<Skill> skills;
}
