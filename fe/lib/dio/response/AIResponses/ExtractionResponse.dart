import 'package:ai_cv_generator/models/aimodels/AIInput.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ExtractionResponse.g.dart';

@JsonSerializable()
class ExtractionResponse {
  
  AIInput data;

  ExtractionResponse({
    required this.data
  });

  factory ExtractionResponse.fromJson(Map<String, dynamic> json) => _$ExtractionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExtractionResponseToJson(this);
}