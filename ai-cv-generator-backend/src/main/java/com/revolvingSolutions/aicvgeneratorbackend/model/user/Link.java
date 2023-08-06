package com.revolvingSolutions.aicvgeneratorbackend.model.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Link {
    private Integer linkid;
    private String url;
}
