import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/models/aimodels/GenerationInput.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ExtractionResponse.g.dart';

@JsonSerializable()
class ExtractionResponse {
  
  GenerationInput data;

  ExtractionResponse({
    required this.data
  });

  factory ExtractionResponse.fromJson(Map<String, dynamic> json) => _$ExtractionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExtractionResponseToJson(this);
}