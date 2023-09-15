import 'package:json_annotation/json_annotation.dart';

part 'JobScrapeRequest.g.dart';

@JsonSerializable()
class JobScrapeRequest {
  String field;
  String location;
  int amount;

  JobScrapeRequest({
    required this.field,
    required this.location,
    required this.amount
  });

  factory JobScrapeRequest.fromJson(Map<String, dynamic> json) => _$JobScrapeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$JobScrapeRequestToJson(this);
}