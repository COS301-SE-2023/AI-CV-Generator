import 'package:json_annotation/json_annotation.dart';
part 'Skill.g.dart';

@JsonSerializable()
class Skill {
  Skill({
    required this.skill,
    required this.level,
    required this.reason,
    required this.skillid
  });
  String skill;
  int level;
  String reason;
  int skillid;
  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);
}