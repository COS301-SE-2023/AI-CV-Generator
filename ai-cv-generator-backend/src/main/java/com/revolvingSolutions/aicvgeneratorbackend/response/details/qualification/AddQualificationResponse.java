package com.revolvingSolutions.aicvgeneratorbackend.response.details.qualification;


import com.revolvingSolutions.aicvgeneratorbackend.model.user.Qualification;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AddQualificationResponse {
    List<Qualification> qualifications;
}
