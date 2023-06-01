import 'dart:convert';
import 'package:ai_cv_generator/models/user/userdata.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserModel.g.dart';

UserModel userModelJson(String str) =>
  UserModel.fromJSON(json.decode(str));

String UserModeltoJson(UserModel data) => json.encode(data.toJson());



@JsonSerializable()
class UserModel {
    Data data;
    // More data to be added
    UserModel({required this.data});

    factory UserModel.fromJSON(Map<String,dynamic> json) => _$UserModelFromJson(json);

    Map<String,dynamic> toJson() => _$UserModelToJson(this);
      
}
