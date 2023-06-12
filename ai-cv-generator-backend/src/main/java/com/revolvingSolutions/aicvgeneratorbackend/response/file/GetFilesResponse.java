package com.revolvingSolutions.aicvgeneratorbackend.response.file;

import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GetFilesResponse {
    private List<FileModel> files;
}
