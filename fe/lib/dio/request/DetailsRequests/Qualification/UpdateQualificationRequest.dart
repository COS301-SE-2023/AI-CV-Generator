import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UpdateQualificationRequest.g.dart';

@JsonSerializable()
class UpdateQualificationRequest {
  Qualification qualification;

  UpdateQualificationRequest({
    required this.qualification
  });
  
  factory UpdateQualificationRequest.fromJson(Map<String, dynamic> json) => _$UpdateQualificationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateQualificationRequestToJson(this);

}