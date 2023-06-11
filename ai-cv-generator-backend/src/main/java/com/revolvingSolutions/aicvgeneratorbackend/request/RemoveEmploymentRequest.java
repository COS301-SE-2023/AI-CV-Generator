package com.revolvingSolutions.aicvgeneratorbackend.request;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.EmploymentEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RemoveEmploymentRequest {
    private EmploymentEntity employment;
}
