import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AuthResponse.g.dart';

@JsonSerializable()
class AuthResponse {
  Code code;
  String? token;
  String? refreshToken;

  AuthResponse({
    required this.code,
    this.token,
    this.refreshToken
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}