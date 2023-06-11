import 'package:json_annotation/json_annotation.dart';

part 'generated/RefreshRequest.g.dart';

@JsonSerializable()
class RefreshRequest {
  String refreshToken;

  RefreshRequest({
    required this.refreshToken
  });
  
  factory RefreshRequest.fromJson(Map<String, dynamic> json) => _$RefreshRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshRequestToJson(this);

}