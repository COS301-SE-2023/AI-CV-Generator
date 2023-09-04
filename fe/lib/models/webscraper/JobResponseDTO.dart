import 'package:json_annotation/json_annotation.dart';

part 'JobResponseDTO.g.dart';

@JsonSerializable()
class JobResponseDTO {
  String title;
  String subTitle;
  String? link;
  String? location;
  String? salary;

  JobResponseDTO({
    required this.title,
    required this.subTitle,
    this.link,
    this.location,
    this.salary
  });

  factory JobResponseDTO.fromJson(Map<String, dynamic> json) => _$JobResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$JobResponseDTOToJson(this);
}