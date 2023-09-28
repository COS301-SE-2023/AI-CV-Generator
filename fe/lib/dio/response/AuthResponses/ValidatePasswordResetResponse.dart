import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ValidatePasswordResetResponse.g.dart';

@JsonSerializable()
class ValidatePasswordResetResponse {
  Code code;

  ValidatePasswordResetResponse({
    required this.code
  });
  
  factory ValidatePasswordResetResponse.fromJson(Map<String, dynamic> json) => _$ValidatePasswordResetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ValidatePasswordResetResponseToJson(this);

}