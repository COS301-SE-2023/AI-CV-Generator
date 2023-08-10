
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GenerationResponse.g.dart';

@JsonSerializable()
class GenerationResponse {
  CVData data;

  GenerationResponse({
    required this.data
  });

  factory GenerationResponse.fromJson(Map<String, dynamic> json) => _$GenerationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenerationResponseToJson(this);
}