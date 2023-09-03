import 'package:json_annotation/json_annotation.dart';

part 'AISkill.g.dart';

@JsonSerializable()
class AISkill {
  AISkill({
    required this.skill,
    required this.level,
    required this.reason
  });
  String skill;
  String level;
  String reason;

  factory AISkill.fromJson(Map<String,dynamic> json) => _$AISkillFromJson(json);

  Map<String,dynamic> toJson() => _$AISkillToJson(this);
}