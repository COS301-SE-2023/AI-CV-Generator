// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpdateLinkRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLinkRequest _$UpdateLinkRequestFromJson(Map<String, dynamic> json) =>
    UpdateLinkRequest(
      link: Link.fromJson(json['link'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateLinkRequestToJson(UpdateLinkRequest instance) =>
    <String, dynamic>{
      'link': instance.link,
    };
