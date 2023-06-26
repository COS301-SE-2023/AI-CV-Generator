// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Employment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employment _$EmploymentFromJson(Map<String, dynamic> json) => Employment(
      company: json['company'] as String,
      title: json['title'] as String,
      startdate: DateTime.parse(json['startdate'] as String),
      enddate: DateTime.parse(json['enddate'] as String),
      empid: json['empid'] as int,
    );

Map<String, dynamic> _$EmploymentToJson(Employment instance) =>
    <String, dynamic>{
      'company': instance.company,
      'title': instance.title,
      'startdate': instance.startdate.toIso8601String(),
      'enddate': instance.enddate.toIso8601String(),
      'empid': instance.empid,
    };
