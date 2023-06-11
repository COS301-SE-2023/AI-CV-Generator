import 'package:json_annotation/json_annotation.dart';

part 'generated/RegisterRequest.g.dart';

@JsonSerializable()
class RegisterRequest {
  String username;
  String password;
  String fname;
  String lname;

  RegisterRequest({
    required this.username,
    required this.password,
    required this.fname,
    required this.lname
  });
  
  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

}