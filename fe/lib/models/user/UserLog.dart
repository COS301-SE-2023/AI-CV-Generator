import 'package:ai_cv_generator/models/user/userdata.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserLog.g.dart';

@JsonSerializable()
class UserModel {
    Data data;
    // More data to be added
    UserModel({required this.data});

    factory UserModel.fromJSON(Map<String,dynamic> json) => _$UserModelFromJson(json);

    Map<String,dynamic> toJson() => _$UserModelToJson(this);
      
}
