package com.revolvingSolutions.aicvgeneratorbackend.response.user;

import com.revolvingSolutions.aicvgeneratorbackend.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UpdateUserResponse {
    private User user;
}
