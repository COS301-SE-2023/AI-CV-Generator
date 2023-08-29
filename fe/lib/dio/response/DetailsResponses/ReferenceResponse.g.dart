// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReferenceResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferenceResponse _$ReferenceResponseFromJson(Map<String, dynamic> json) =>
    ReferenceResponse(
      references: (json['references'] as List<dynamic>)
          .map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReferenceResponseToJson(ReferenceResponse instance) =>
    <String, dynamic>{
      'references': instance.references,
    };
