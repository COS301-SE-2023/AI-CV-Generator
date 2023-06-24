import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserResponse.g.dart';

@JsonSerializable()
class UserResponse {
  UserModel user;

  UserResponse({
    required this.user
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}