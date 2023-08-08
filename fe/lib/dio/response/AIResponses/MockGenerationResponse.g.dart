// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MockGenerationResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MockGenerationResponse _$MockGenerationResponseFromJson(
        Map<String, dynamic> json) =>
    MockGenerationResponse(
      mockgeneratedUser:
          UserModel.fromJson(json['mockgeneratedUser'] as Map<String, dynamic>),
      data: CVData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MockGenerationResponseToJson(
        MockGenerationResponse instance) =>
    <String, dynamic>{
      'mockgeneratedUser': instance.mockgeneratedUser,
      'data': instance.data,
    };
