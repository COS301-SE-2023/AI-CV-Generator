package com.revolvingSolutions.aicvgeneratorbackend.response.details.employment;


import com.revolvingSolutions.aicvgeneratorbackend.model.user.Employment;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UpdateEmploymentResponse {
    List<Employment> employees;
}
