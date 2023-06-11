// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../AddEmploymentRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddEmploymentRequest _$AddEmploymentRequestFromJson(
        Map<String, dynamic> json) =>
    AddEmploymentRequest(
      employment:
          Employment.fromJson(json['employment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddEmploymentRequestToJson(
        AddEmploymentRequest instance) =>
    <String, dynamic>{
      'employment': instance.employment,
    };
