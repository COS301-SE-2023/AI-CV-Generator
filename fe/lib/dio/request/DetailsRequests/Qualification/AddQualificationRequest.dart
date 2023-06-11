import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AddQualificationRequest.g.dart';

@JsonSerializable()
class AddQualificationRequest {
  Qualification qualification;

  AddQualificationRequest({
    required this.qualification
  });
  
  factory AddQualificationRequest.fromJson(Map<String, dynamic> json) => _$AddQualificationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddQualificationRequestToJson(this);

}