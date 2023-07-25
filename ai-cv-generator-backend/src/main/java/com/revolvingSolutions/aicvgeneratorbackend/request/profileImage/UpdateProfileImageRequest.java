package com.revolvingSolutions.aicvgeneratorbackend.request.profileImage;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UpdateProfileImageRequest {
    private byte[] imgdata;
}
