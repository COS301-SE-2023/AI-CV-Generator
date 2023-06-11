package com.revolvingSolutions.aicvgeneratorbackend.model;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.QualificationEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Qualifications {
    private List<QualificationEntity> qualifications;
}
