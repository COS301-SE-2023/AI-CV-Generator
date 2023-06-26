// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LinkResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkResponse _$LinkResponseFromJson(Map<String, dynamic> json) => LinkResponse(
      links: (json['links'] as List<dynamic>)
          .map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LinkResponseToJson(LinkResponse instance) =>
    <String, dynamic>{
      'links': instance.links,
    };
