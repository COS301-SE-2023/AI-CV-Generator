// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpdateEmploymentRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEmploymentRequest _$UpdateEmploymentRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateEmploymentRequest(
      employment:
          Employment.fromJson(json['employment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateEmploymentRequestToJson(
        UpdateEmploymentRequest instance) =>
    <String, dynamic>{
      'employment': instance.employment,
    };
