package com.revolvingSolutions.aicvgeneratorbackend.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CVData {
    public String description;
    public List<String> employmenthis;
    public String education_description;
}
