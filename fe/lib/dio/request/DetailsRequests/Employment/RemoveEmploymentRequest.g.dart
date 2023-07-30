// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RemoveEmploymentRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveEmploymentRequest _$RemoveEmploymentRequestFromJson(
        Map<String, dynamic> json) =>
    RemoveEmploymentRequest(
      employment:
          Employment.fromJson(json['employment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoveEmploymentRequestToJson(
        RemoveEmploymentRequest instance) =>
    <String, dynamic>{
      'employment': instance.employment,
    };
