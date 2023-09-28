package com.revolvingSolutions.aicvgeneratorbackend.response.profileImage;

import com.revolvingSolutions.aicvgeneratorbackend.model.file.ProfileImageModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetProfileImageResponse {
    private ProfileImageModel img;
}
