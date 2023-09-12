// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChangePasswordResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordResponse _$ChangePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponse(
      code: $enumDecode(_$CodeEnumMap, json['code']),
    );

Map<String, dynamic> _$ChangePasswordResponseToJson(
        ChangePasswordResponse instance) =>
    <String, dynamic>{
      'code': _$CodeEnumMap[instance.code]!,
    };

const _$CodeEnumMap = {
  Code.success: 'success',
  Code.failed: 'failed',
  Code.emailFailed: 'emailFailed',
  Code.expired: 'expired',
  Code.requestFailed: 'requestFailed',
  Code.notEnabled: 'notEnabled',
};
