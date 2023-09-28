import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ResetPasswordResponse.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  Code code;

  ResetPasswordResponse({
    required this.code
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => _$ResetPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}