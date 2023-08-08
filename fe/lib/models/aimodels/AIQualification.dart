import 'package:json_annotation/json_annotation.dart';

part 'AIQualification.g.dart';

@JsonSerializable()
class AIQualification {
  AIQualification({
    required this.qualification,
    required this.institution,
    required this.startDate,
    required this.endDate
  });
  String qualification;
  String institution;
  String startDate;
  String endDate;

  factory AIQualification.fromJson(Map<String,dynamic> json) => _$AIQualificationFromJson(json);

  Map<String,dynamic> toJson() => _$AIQualificationToJson(this);
}