// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Qualifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qualifications _$QualificationsFromJson(Map<String, dynamic> json) =>
    Qualifications(
      qualifications: (json['qualifications'] as List<dynamic>)
          .map((e) => Qualification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QualificationsToJson(Qualifications instance) =>
    <String, dynamic>{
      'qualifications': instance.qualifications,
    };

Qualification _$QualificationFromJson(Map<String, dynamic> json) =>
    Qualification(
      qualification: json['qualification'] as String,
      instatution: json['instatution'] as String,
      date: DateTime.parse(json['date'] as String),
      quaid: int.parse(json['quaid'] as String)
    );

Map<String, dynamic> _$QualificationToJson(Qualification instance) =>
    <String, dynamic>{
      'qualification': instance.qualification,
      'instatution': instance.instatution,
      'date': instance.date.toIso8601String(),
    };
