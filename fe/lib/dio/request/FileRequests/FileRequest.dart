import 'package:json_annotation/json_annotation.dart';

part 'FileRequest.g.dart';

@JsonSerializable()
class FileRequest {
  String filename;

  FileRequest({
    required this.filename
  });
  
  factory FileRequest.fromJson(Map<String, dynamic> json) => _$FileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FileRequestToJson(this);

}