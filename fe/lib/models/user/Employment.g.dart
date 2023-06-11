// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Employment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employment _$EmploymentFromJson(Map<String, dynamic> json) => Employment(
      company: json['company'] as String,
      title: json['title'] as String,
      start_date: DateTime.parse(json['start_date'] as String),
      end_date: DateTime.parse(json['end_date'] as String),
      empid: json['empid'] as int,
    );

Map<String, dynamic> _$EmploymentToJson(Employment instance) =>
    <String, dynamic>{
      'company': instance.company,
      'title': instance.title,
      'start_date': instance.start_date.toIso8601String(),
      'end_date': instance.end_date.toIso8601String(),
      'empid': instance.empid,
    };
