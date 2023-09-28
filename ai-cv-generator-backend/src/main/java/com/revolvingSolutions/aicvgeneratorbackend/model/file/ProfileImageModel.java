package com.revolvingSolutions.aicvgeneratorbackend.model.file;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProfileImageModel {
    private byte[] imgdata;
}
