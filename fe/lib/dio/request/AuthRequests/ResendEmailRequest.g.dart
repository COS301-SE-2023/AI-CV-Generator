// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResendEmailRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendEmailRequest _$ResendEmailRequestFromJson(Map<String, dynamic> json) =>
    ResendEmailRequest(
      username: json['username'] as String,
      password: json['password'] as String,
      siteUrl: json['siteUrl'] as String,
    );

Map<String, dynamic> _$ResendEmailRequestToJson(ResendEmailRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'siteUrl': instance.siteUrl
    };
