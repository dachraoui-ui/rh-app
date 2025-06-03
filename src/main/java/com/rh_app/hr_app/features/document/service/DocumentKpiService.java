package com.rh_app.hr_app.features.document.service;

import com.rh_app.hr_app.features.document.dto.DocFolderDto;
import com.rh_app.hr_app.features.document.dto.DocFolderKpiDto;
import com.rh_app.hr_app.features.document.mapper.DocFolderMapper;
import com.rh_app.hr_app.features.document.model.DocumentFolder;
import com.rh_app.hr_app.features.document.repository.DocFolderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DocumentKpiService {

    private final DocFolderRepository folderRepository;

    public DocFolderKpiDto getFolderKpis() {
        List<DocumentFolder> allFolders = folderRepository.findAll();

        // Get current time for comparison
        Instant now = Instant.now();
        Instant oneWeekAgo = Instant.now().minusSeconds(7 * 24 * 60 * 60);
        Instant oneMonthAgo = Instant.now().minusSeconds(30 * 24 * 60 * 60);

        // Count folders created in the last week/month
        long foldersLastWeek = allFolders.stream()
                .filter(f -> f.getCreatedAt().isAfter(oneWeekAgo))
                .count();

        long foldersLastMonth = allFolders.stream()
                .filter(f -> f.getCreatedAt().isAfter(oneMonthAgo))
                .count();

        // Calculate average name length
        double avgNameLength = allFolders.stream()
                .mapToInt(f -> f.getName().length())
                .average()
                .orElse(0);

        // Get 5 most recently created folders
        List<DocFolderDto> recentFolders = allFolders.stream()
                .sorted(Comparator.comparing(DocumentFolder::getCreatedAt).reversed())
                .limit(5)
                .map(DocFolderMapper::toDto)
                .collect(Collectors.toList());

        // Create trend data by month
        Map<String, Long> trendByMonth = allFolders.stream()
                .collect(Collectors.groupingBy(
                        folder -> {
                            LocalDateTime ldt = LocalDateTime.ofInstant(
                                    folder.getCreatedAt(), ZoneId.systemDefault());
                            return ldt.format(DateTimeFormatter.ofPattern("yyyy-MM"));
                        },
                        Collectors.counting()
                ));

        return DocFolderKpiDto.builder()
                .totalFolders((long) allFolders.size())
                .foldersCreatedLastWeek(foldersLastWeek)
                .foldersCreatedLastMonth(foldersLastMonth)
                .averageNameLength(avgNameLength)
                .recentlyCreatedFolders(recentFolders)
                .creationTrendByMonth(trendByMonth)
                .build();
    }
}