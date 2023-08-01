
import 'package:ai_cv_generator/models/generation/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MockGenerationResponse.g.dart';

@JsonSerializable()
class MockGenerationResponse {
  UserModel mockgeneratedUser;
  CVData data;

  MockGenerationResponse({
    required this.mockgeneratedUser,
    required this.data
  });

  factory MockGenerationResponse.fromJson(Map<String, dynamic> json) => _$MockGenerationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MockGenerationResponseToJson(this);
}