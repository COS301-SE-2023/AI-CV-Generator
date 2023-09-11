import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ResendEmailResponse.g.dart';

@JsonSerializable()
class ResendEmailResponse {
  Code code;

  ResendEmailResponse({
    required this.code
  });

  factory ResendEmailResponse.fromJson(Map<String, dynamic> json) => _$ResendEmailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResendEmailResponseToJson(this);
}