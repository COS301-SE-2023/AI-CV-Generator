package com.revolvingSolutions.aicvgeneratorbackend.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CVData {
    public String fname;
    public String lname;
    public String location;
    public String description;
}
