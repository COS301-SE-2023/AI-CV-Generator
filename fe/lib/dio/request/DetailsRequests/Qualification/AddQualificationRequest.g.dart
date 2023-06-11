// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddQualificationRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddQualificationRequest _$AddQualificationRequestFromJson(
        Map<String, dynamic> json) =>
    AddQualificationRequest(
      qualification:
          Qualification.fromJson(json['qualification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddQualificationRequestToJson(
        AddQualificationRequest instance) =>
    <String, dynamic>{
      'qualification': instance.qualification,
    };
