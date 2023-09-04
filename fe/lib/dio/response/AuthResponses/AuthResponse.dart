import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AuthResponse.g.dart';

@JsonSerializable()
class AuthResponse {
  String token;
  String refreshToken;
  Code code;

  AuthResponse({
    required this.token,
    required this.refreshToken,
    required this.code
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}