package com.revolvingSolutions.aicvgeneratorbackend.model.webscrapper;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class JobResponseDTO {
    public String title;
    public String subTitle;
    public String link;
    public String location;
    public String imgLink;
    public String salary;
}
