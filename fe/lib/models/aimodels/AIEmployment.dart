import 'package:json_annotation/json_annotation.dart';

part 'AIEmployment.g.dart';

@JsonSerializable()
class AIEmployment {
  AIEmployment({
    required this.company,
    required this.jobTitle,
    required this.startDate,
    required this.endDate
  });
  String company;
  String jobTitle;
  String startDate;
  String endDate;

  factory AIEmployment.fromJson(Map<String,dynamic> json) => _$AIEmploymentFromJson(json);

  Map<String,dynamic> toJson() => _$AIEmploymentToJson(this);
}