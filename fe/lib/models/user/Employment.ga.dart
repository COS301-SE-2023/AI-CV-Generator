// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Employment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employment _$EmploymentFromJson(Map<String, dynamic> json) => Employment(
      company: json['company'] as String,
      title: json['title'] as String,
      startdate: DateTime.fromMillisecondsSinceEpoch(json['startdate'] as int),
      enddate: DateTime.fromMillisecondsSinceEpoch(json['enddate'] as int),
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
