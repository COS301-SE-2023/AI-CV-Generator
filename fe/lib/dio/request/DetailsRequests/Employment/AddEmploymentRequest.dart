import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AddEmploymentRequest.g.dart';

@JsonSerializable()
class AddEmploymentRequest {
  Employment employment;

  AddEmploymentRequest({
    required this.employment
  });
  
  factory AddEmploymentRequest.fromJson(Map<String, dynamic> json) => _$AddEmploymentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddEmploymentRequestToJson(this);

}