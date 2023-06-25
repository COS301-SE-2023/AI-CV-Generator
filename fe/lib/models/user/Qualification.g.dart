// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Qualification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qualification _$QualificationFromJson(Map<String, dynamic> json) =>
    Qualification(
      qualification: json['qualification'] as String,
      instatution: json['instatution'] as String,
      date: DateTime.parse(json['date'] as String),
      endo: DateTime.parse(json['endo'] as String),
      quaid: json['quaid'] as int,
    );

Map<String, dynamic> _$QualificationToJson(Qualification instance) =>
    <String, dynamic>{
      'quaid': instance.quaid,
      'qualification': instance.qualification,
      'instatution': instance.instatution,
      'date': instance.date.toIso8601String(),
      'endo': instance.date.toIso8601String()
    };
