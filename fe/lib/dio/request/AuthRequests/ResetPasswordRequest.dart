import 'package:json_annotation/json_annotation.dart';

part 'ResetPasswordRequest.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  String username;
  String email;
  String siteUrl;

  ResetPasswordRequest({
    required this.username,
    required this.email,
    required this.siteUrl
  });
  
  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);

}