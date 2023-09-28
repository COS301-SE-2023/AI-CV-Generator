import 'package:ai_cv_generator/models/aimodels/AIInput.dart';
import 'package:json_annotation/json_annotation.dart';


part 'GenerationRequest.g.dart';

@JsonSerializable()
class GenerationRequest {
  AIInput data;

  GenerationRequest({
    required this.data
  });
  factory GenerationRequest.fromJson(Map<String, dynamic> json) => _$GenerationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GenerationRequestToJson(this);
}