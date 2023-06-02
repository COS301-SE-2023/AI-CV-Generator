import 'package:ai_cv_generator/models/user/userdata.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserLog.g.dart';

@JsonSerializable()
class UserLog {
    Data data_;
    // More data to be added
    UserLog({required this.data_});

    factory UserLog.fromJSON(Map<String,dynamic> json) => _$UserLogFromJson(json);

    Map<String,dynamic> toJson() => _$UserLogToJson(this);
      
}
