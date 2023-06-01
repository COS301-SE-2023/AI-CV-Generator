import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';


//for creating a user and editing a user
@JsonSerializable()
class UserInfomat {
  @JsonKey(name: "fname")
  String fname;
  @JsonKey(name: "userid")
  String? id;
  String? createdAt;
  String? updatedAt;
  

  UserInfomat({
    required this.fname,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfomat.fromJson(Map<String, dynamic> json) => _$UserInfomatFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfomatToJson(this);
}