import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ChangePasswordResponse.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  Code code;

  ChangePasswordResponse({
    required this.code
  });
  
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => _$ChangePasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);

}