package com.revolvingSolutions.aicvgeneratorbackend.response;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.EmploymentEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AddEmploymentResponse {
    private EmploymentEntity employment;
}
