import 'package:ai_cv_generator/models/user/userDetails.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';


//for creating a user and editing a user
@JsonSerializable()
class UserModel {
  String fname;
  String lname;
  String username;
  Details? details;
  String? phoneNumber;
  String? email;
  String? location;
  String? description;
  
  

  UserModel({
    required this.fname,
    required this.lname,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}