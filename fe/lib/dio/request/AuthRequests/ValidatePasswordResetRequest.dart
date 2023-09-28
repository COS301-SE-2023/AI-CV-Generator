import 'package:json_annotation/json_annotation.dart';

part 'ValidatePasswordResetRequest.g.dart';

@JsonSerializable()
class ValidatePasswordResetRequest {
  String token;

  ValidatePasswordResetRequest({
    required this.token
  });
  
  factory ValidatePasswordResetRequest.fromJson(Map<String, dynamic> json) => _$ValidatePasswordResetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ValidatePasswordResetRequestToJson(this);

}