import 'package:json_annotation/json_annotation.dart';

part 'ChangePasswordRequest.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  String? oldPassword;
  String newPassword;
  String token;

  ChangePasswordRequest({
    required this.newPassword,
    required this.token,
    this.oldPassword
  });
  
  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);

}