import 'package:json_annotation/json_annotation.dart';

part 'ResendEmailRequest.g.dart';

@JsonSerializable()
class ResendEmailRequest {
  String username;
  String password;
  String siteUrl;

  ResendEmailRequest({
    required this.username,
    required this.password,
    required this.siteUrl
  });
  
  factory ResendEmailRequest.fromJson(Map<String, dynamic> json) => _$ResendEmailRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ResendEmailRequestToJson(this);

}