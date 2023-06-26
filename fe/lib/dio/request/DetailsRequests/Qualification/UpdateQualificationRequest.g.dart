// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpdateQualificationRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateQualificationRequest _$UpdateQualificationRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateQualificationRequest(
      qualification:
          Qualification.fromJson(json['qualification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateQualificationRequestToJson(
        UpdateQualificationRequest instance) =>
    <String, dynamic>{
      'qualification': instance.qualification,
    };
