// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Qualification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qualification _$QualificationFromJson(Map<String, dynamic> json) =>
    Qualification(
      qualification: json['qualification'] as String,
      intstitution: json['intstitution'] as String,
      date: DateTime.parse(json['date'] as String),
      quaid: json['quaid'] as int,
      endo: DateTime.parse(json['endo'] as String),
    );

Map<String, dynamic> _$QualificationToJson(Qualification instance) =>
    <String, dynamic>{
      'quaid': instance.quaid,
      'qualification': instance.qualification,
      'intstitution': instance.intstitution,
      'date': instance.date.toIso8601String(),
      'endo': instance.endo.toIso8601String(),
    };
