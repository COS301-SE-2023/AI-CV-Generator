import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:json_annotation/json_annotation.dart';


part 'MockGenerationRequest.g.dart';

@JsonSerializable()
class MockGenerationRequest {
  UserModel adjustedModel;

  MockGenerationRequest({
    required this.adjustedModel
  });
  factory MockGenerationRequest.fromJson(Map<String, dynamic> json) => _$MockGenerationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MockGenerationRequestToJson(this);
}