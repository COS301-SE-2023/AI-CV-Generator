import 'package:json_annotation/json_annotation.dart';

part 'GetSharedFileRequest.g.dart';

@JsonSerializable()
class GetSharedFileRequest {
  String uuid;

  GetSharedFileRequest({
    required this.uuid
  });
  
  factory GetSharedFileRequest.fromJson(Map<String, dynamic> json) => _$GetSharedFileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetSharedFileRequestToJson(this);

}