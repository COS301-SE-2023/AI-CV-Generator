// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CVData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVData _$CVDataFromJson(Map<String, dynamic> json) => CVData(
      description: json['description'] as String?,
      employmenthis: (json['employmenthis'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      education_description: json['education_description'] as String?,
    );

Map<String, dynamic> _$CVDataToJson(CVData instance) => <String, dynamic>{
      'description': instance.description,
      'employmenthis': instance.employmenthis,
      'education_description': instance.education_description,
    };
