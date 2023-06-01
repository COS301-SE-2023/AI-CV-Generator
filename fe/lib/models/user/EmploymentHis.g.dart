// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmploymentHis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmploymentHistory _$EmploymentHistoryFromJson(Map<String, dynamic> json) =>
    EmploymentHistory(
      employHis: (json['employHis'] as List<dynamic>)
          .map((e) => Employment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmploymentHistoryToJson(EmploymentHistory instance) =>
    <String, dynamic>{
      'employHis': instance.employHis,
    };

Employment _$EmploymentFromJson(Map<String, dynamic> json) => Employment(
      company: json['company'] as String,
      title: json['title'] as String,
      start_date: DateTime.parse(json['start_date'] as String),
      end_date: DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$EmploymentToJson(Employment instance) =>
    <String, dynamic>{
      'company': instance.company,
      'title': instance.title,
      'start_date': instance.start_date.toIso8601String(),
      'end_date': instance.end_date.toIso8601String(),
    };