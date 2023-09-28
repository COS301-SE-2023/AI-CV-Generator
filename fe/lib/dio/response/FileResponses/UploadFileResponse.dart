
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:json_annotation/json_annotation.dart';


part 'UploadFileResponse.g.dart';

@JsonSerializable()
class UploadFileResponse {
  
  Code code;

  UploadFileResponse({
    required this.code
  });

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) => _$UploadFileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UploadFileResponseToJson(this);
}