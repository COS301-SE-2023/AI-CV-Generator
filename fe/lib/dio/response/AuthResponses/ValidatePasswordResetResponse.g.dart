// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ValidatePasswordResetResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatePasswordResetResponse _$ValidatePasswordResetResponseFromJson(
        Map<String, dynamic> json) =>
    ValidatePasswordResetResponse(
      code: $enumDecode(_$CodeEnumMap, json['code']),
    );

Map<String, dynamic> _$ValidatePasswordResetResponseToJson(
        ValidatePasswordResetResponse instance) =>
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
