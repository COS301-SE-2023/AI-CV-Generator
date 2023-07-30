// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Qualification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qualification _$QualificationFromJson(Map<String, dynamic> json) =>
    Qualification(
      qualification: json['qualification'] as String,
      intstitution: json['intstitution'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
      quaid: json['quaid'] as int,
      endo: DateTime.fromMillisecondsSinceEpoch(json['endo'] as int),
    );

Map<String, dynamic> _$QualificationToJson(Qualification instance) =>
    <String, dynamic>{
      'quaid': instance.quaid,
      'qualification': instance.qualification,
      'intstitution': instance.intstitution,
      'date': instance.date.toIso8601String(),
      'endo': instance.endo.toIso8601String(),
    };
