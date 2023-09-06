// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AIEmployment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIEmployment _$AIEmploymentFromJson(Map<String, dynamic> json) => AIEmployment(
      company: json['company'] as String?,
      jobTitle: json['jobTitle'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$AIEmploymentToJson(AIEmployment instance) =>
    <String, dynamic>{
      'company': instance.company,
      'jobTitle': instance.jobTitle,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
