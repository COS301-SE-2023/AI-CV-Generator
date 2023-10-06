// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResetPasswordRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequest _$ResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordRequest(
      username: json['username'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
    };
