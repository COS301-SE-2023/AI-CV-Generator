import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UpdateUserRequest.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  UserModel user;

  UpdateUserRequest({
    required this.user
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}