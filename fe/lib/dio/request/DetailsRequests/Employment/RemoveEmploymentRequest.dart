import 'package:ai_cv_generator/models/user/EmploymentHis.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/RemoveEmploymentRequest.g.dart';

@JsonSerializable()
class RemoveEmploymentRequest {
  Employment employment;

  RemoveEmploymentRequest({
    required this.employment
  });
  
  factory RemoveEmploymentRequest.fromJson(Map<String, dynamic> json) => _$RemoveEmploymentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveEmploymentRequestToJson(this);

}