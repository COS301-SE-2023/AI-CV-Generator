
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'QualificationsResponse.g.dart';

@JsonSerializable()
class QualificationsResponse {
  List<Qualification> qualifications;

  QualificationsResponse({
    required this.qualifications
  });

  factory QualificationsResponse.fromJson(Map<String, dynamic> json) => _$QualificationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QualificationsResponseToJson(this);
}