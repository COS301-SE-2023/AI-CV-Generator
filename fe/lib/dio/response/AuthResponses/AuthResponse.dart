import 'package:json_annotation/json_annotation.dart';

part 'AuthResponse.g.dart';

@JsonSerializable()
class AuthResponse {
  String token;
  String refreshToken;

  AuthResponse({
    required this.token,
    required this.refreshToken
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}