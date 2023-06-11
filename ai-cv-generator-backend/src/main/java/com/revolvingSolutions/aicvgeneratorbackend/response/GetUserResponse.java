package com.revolvingSolutions.aicvgeneratorbackend.response;

import com.revolvingSolutions.aicvgeneratorbackend.model.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetUserResponse {
    private User user;
}
