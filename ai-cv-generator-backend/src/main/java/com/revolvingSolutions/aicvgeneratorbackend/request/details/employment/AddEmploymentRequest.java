package com.revolvingSolutions.aicvgeneratorbackend.request.details.employment;

import com.revolvingSolutions.aicvgeneratorbackend.model.Employment;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AddEmploymentRequest {
    private Employment employment;
}
