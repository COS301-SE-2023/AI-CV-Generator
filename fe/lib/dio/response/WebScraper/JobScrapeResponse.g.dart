// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JobScrapeResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobScrapeResponse _$JobScrapeResponseFromJson(Map<String, dynamic> json) =>
    JobScrapeResponse(
      jobs: (json['jobs'] as List<dynamic>)
          .map((e) => JobResponseDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobScrapeResponseToJson(JobScrapeResponse instance) =>
    <String, dynamic>{
      'jobs': instance.jobs,
    };
