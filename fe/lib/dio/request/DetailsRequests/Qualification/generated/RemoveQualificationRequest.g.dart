// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../RemoveQualificationRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveQualificationRequest _$RemoveQualificationRequestFromJson(
        Map<String, dynamic> json) =>
    RemoveQualificationRequest(
      qualification:
          Qualification.fromJson(json['qualification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoveQualificationRequestToJson(
        RemoveQualificationRequest instance) =>
    <String, dynamic>{
      'qualification': instance.qualification,
    };
