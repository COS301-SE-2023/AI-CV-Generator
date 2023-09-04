import 'package:json_annotation/json_annotation.dart';

part 'RegisterRequest.g.dart';

@JsonSerializable()
class RegisterRequest {
  String username;
  String password;
  String email;
  String fname;
  String lname;

  RegisterRequest({
    required this.username,
    required this.password,
    required this.email,
    required this.fname,
    required this.lname
  });
  
  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);

}