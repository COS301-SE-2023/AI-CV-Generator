import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SkillResponse.g.dart';

@JsonSerializable()
class SkillResponse {
  List<Skill> skills;

  SkillResponse({
    required this.skills
  });
  
  factory SkillResponse.fromJson(Map<String, dynamic> json) => _$SkillResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SkillResponseToJson(this);

}