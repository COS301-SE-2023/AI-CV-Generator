// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../RemoveLinkRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveLinkRequest _$RemoveLinkRequestFromJson(Map<String, dynamic> json) =>
    RemoveLinkRequest(
      link: Link.fromJson(json['link'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoveLinkRequestToJson(RemoveLinkRequest instance) =>
    <String, dynamic>{
      'link': instance.link,
    };
