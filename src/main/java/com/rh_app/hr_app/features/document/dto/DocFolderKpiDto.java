package com.rh_app.hr_app.features.document.dto;

import lombok.Builder;
import lombok.Value;


import java.util.List;
import java.util.Map;

@Value
@Builder
public class DocFolderKpiDto {
    long totalFolders;
    long foldersCreatedLastWeek;
    long foldersCreatedLastMonth;
    double averageNameLength;
    List<DocFolderDto> recentlyCreatedFolders;
    Map<String, Long> creationTrendByMonth;
}