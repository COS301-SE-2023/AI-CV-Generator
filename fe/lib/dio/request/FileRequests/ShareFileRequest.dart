import 'package:json_annotation/json_annotation.dart';

part 'ShareFileRequest.g.dart';

@JsonSerializable()
class ShareFileRequest {
  String filename;
  String base;
  Duration duration;

  ShareFileRequest({
    required this.filename,
    required this.base,
    required this.duration
  });
  
  factory ShareFileRequest.fromJson(Map<String, dynamic> json) => _$ShareFileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShareFileRequestToJson(this);

}