// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenerationRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerationRequest _$GenerationRequestFromJson(Map<String, dynamic> json) =>
    GenerationRequest(
      data: AIInput.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GenerationRequestToJson(GenerationRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
