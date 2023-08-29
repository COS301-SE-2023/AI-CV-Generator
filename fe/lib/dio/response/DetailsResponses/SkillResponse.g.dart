// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SkillResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillResponse _$SkillResponseFromJson(Map<String, dynamic> json) =>
    SkillResponse(
      skills: (json['skills'] as List<dynamic>)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SkillResponseToJson(SkillResponse instance) =>
    <String, dynamic>{
      'skills': instance.skills,
    };
