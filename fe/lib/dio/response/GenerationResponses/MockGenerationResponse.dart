
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MockGenerationResponse.g.dart';

@JsonSerializable()
class MockGenerationResponse {
  UserModel mockgeneratedUser;
  String? extradata;

  MockGenerationResponse({
    required this.mockgeneratedUser,
    this.extradata
  });

  factory MockGenerationResponse.fromJson(Map<String, dynamic> json) => _$MockGenerationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MockGenerationResponseToJson(this);
}