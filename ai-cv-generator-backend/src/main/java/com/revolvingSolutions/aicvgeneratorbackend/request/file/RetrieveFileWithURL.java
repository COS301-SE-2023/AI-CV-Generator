package com.revolvingSolutions.aicvgeneratorbackend.request.file;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RetrieveFileWithURL {
    private UUID uuid;
}
