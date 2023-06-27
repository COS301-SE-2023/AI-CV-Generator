// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddLinkRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLinkRequest _$AddLinkRequestFromJson(Map<String, dynamic> json) =>
    AddLinkRequest(
      link: Link.fromJson(json['link'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddLinkRequestToJson(AddLinkRequest instance) =>
    <String, dynamic>{
      'link': instance.link,
    };
