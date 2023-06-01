import 'package:json_annotation/json_annotation.dart';

part 'user_informat.g.dart';


//for creating a user and editing a user
@JsonSerializable()
class UserInfomat {
  String name;
  String job;
  String? id;
  String? createdAt;
  String? updatedAt;

  UserInfomat({
    required this.name,
    required this.job,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfomat.fromJson(Map<String, dynamic> json) => _$UserInfomatFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfomatToJson(this);
}