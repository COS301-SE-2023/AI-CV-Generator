// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      code: $enumDecode(_$CodeEnumMap, json['code']),
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'code': _$CodeEnumMap[instance.code]!,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };

const _$CodeEnumMap = {
  Code.success: 'success',
  Code.failed: 'failed',
  Code.emailFailed: 'emailFailed',
  Code.expired: 'expired',
  Code.requestFailed: 'requestFailed',
  Code.notEnabled: 'notEnabled',
};
