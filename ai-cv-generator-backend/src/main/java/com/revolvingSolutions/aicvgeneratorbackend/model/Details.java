package com.revolvingSolutions.aicvgeneratorbackend.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Details {
    private Qualifications qualifications;
    private EmploymentHistory employmenthistory;
    private Links links;
}
