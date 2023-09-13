import 'package:json_annotation/json_annotation.dart';

part 'VerificationRequest.g.dart';

@JsonSerializable()
class VerificationRequest {
  String registrationToken;

  VerificationRequest({
    required this.registrationToken
  });
  
  factory VerificationRequest.fromJson(Map<String, dynamic> json) => _$VerificationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerificationRequestToJson(this);

}
