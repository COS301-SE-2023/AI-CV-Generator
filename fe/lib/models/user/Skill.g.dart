// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
      skill: json['skill'] as String,
      level: json['level'] as int,
      reason: json['reason'] as String,
      skillid: json['skillid'] as int,
    );

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'skill': instance.skill,
      'level': instance.level,
      'reason': instance.reason,
      'skillid': instance.skillid,
    };
