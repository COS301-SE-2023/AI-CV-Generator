// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QualificationsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualificationsResponse _$QualificationsResponseFromJson(
        Map<String, dynamic> json) =>
    QualificationsResponse(
      qualifications: (json['qualifications'] as List<dynamic>)
          .map((e) => Qualification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QualificationsResponseToJson(
        QualificationsResponse instance) =>
    <String, dynamic>{
      'qualifications': instance.qualifications,
    };
