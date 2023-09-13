// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChangePasswordRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequest(
      newPassword: json['newPassword'] as String,
      token: json['token'] as String,
      oldPassword: json['oldPassword'] as String?,
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
      'token': instance.token,
    };
