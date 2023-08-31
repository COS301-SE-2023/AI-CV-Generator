package com.revolvingSolutions.aicvgeneratorbackend.response.details.reference;

import com.revolvingSolutions.aicvgeneratorbackend.model.user.Reference;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AddReferenceResponse {
    List<Reference> references;
}
