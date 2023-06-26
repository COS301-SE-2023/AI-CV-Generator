import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UpdateEmploymentRequest.g.dart';

@JsonSerializable()
class UpdateEmploymentRequest {
  Employment employment;

  UpdateEmploymentRequest({
    required this.employment
  });
  
  factory UpdateEmploymentRequest.fromJson(Map<String, dynamic> json) => _$UpdateEmploymentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateEmploymentRequestToJson(this);

}