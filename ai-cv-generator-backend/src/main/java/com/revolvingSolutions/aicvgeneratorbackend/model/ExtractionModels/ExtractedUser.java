package com.revolvingSolutions.aicvgeneratorbackend.model.ExtractionModels;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ExtractedUser {
    public String fname;
    public String lname;
    public String username;
    public String email;
    public String phoneNumber;
    public String location;
    public String description;
}
