package com.revolvingSolutions.aicvgeneratorbackend.response.details.link;

import com.revolvingSolutions.aicvgeneratorbackend.model.user.Link;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AddLinkResponse {
    private List<Link> links;
}
