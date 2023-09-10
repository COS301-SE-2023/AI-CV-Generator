import 'package:ai_cv_generator/models/webscraper/JobResponseDTO.dart';
import 'package:json_annotation/json_annotation.dart';

part 'JobScrapeResponse.g.dart';

@JsonSerializable()
class JobScrapeResponse {
  List<JobResponseDTO> jobs;

  JobScrapeResponse({
    required this.jobs
  });

  factory JobScrapeResponse.fromJson(Map<String, dynamic> json) => _$JobScrapeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JobScrapeResponseToJson(this);
}