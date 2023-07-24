package com.revolvingSolutions.aicvgeneratorbackend.request.details.link;

import com.revolvingSolutions.aicvgeneratorbackend.model.Link;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UpdateLinkRequest {
    private Link link;
}
