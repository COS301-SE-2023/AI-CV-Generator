import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RemoveQualificationRequest.g.dart';

@JsonSerializable()
class RemoveQualificationRequest {
  Qualification qualification;

  RemoveQualificationRequest({
    required this.qualification
  });
  
  factory RemoveQualificationRequest.fromJson(Map<String, dynamic> json) => _$RemoveQualificationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveQualificationRequestToJson(this);

}