import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SkillRequest.g.dart';

@JsonSerializable()
class SkillRequest {
  Skill skill;

  SkillRequest({
    required this.skill
  });
  
  factory SkillRequest.fromJson(Map<String, dynamic> json) => _$SkillRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SkillRequestToJson(this);

}