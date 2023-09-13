import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:json_annotation/json_annotation.dart';

part 'VerificationResponse.g.dart';

@JsonSerializable()
class VerificationResponse {
  Code code;

  VerificationResponse({
    required this.code
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) => _$VerificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VerificationResponseToJson(this);
}