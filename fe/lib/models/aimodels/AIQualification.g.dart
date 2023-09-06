// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AIQualification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIQualification _$AIQualificationFromJson(Map<String, dynamic> json) =>
    AIQualification(
      qualification: json['qualification'] as String?,
      institution: json['institution'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$AIQualificationToJson(AIQualification instance) =>
    <String, dynamic>{
      'qualification': instance.qualification,
      'institution': instance.institution,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
