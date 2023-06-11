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
public class EmploymentHistory {
    private List<EmploymentEntity> employmentHis;
}
