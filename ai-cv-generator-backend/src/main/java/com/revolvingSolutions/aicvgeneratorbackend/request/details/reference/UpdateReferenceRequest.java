package com.revolvingSolutions.aicvgeneratorbackend.request.details.reference;

import com.revolvingSolutions.aicvgeneratorbackend.model.user.Reference;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UpdateReferenceRequest {
    private Reference reference;
}
