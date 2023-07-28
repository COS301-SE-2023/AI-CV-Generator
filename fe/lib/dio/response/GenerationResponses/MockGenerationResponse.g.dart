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
      extradata: json['extradata'] as String?,
    );

Map<String, dynamic> _$MockGenerationResponseToJson(
        MockGenerationResponse instance) =>
    <String, dynamic>{
      'mockgeneratedUser': instance.mockgeneratedUser,
      'extradata': instance.extradata,
    };
