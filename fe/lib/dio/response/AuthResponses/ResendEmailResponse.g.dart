// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResendEmailResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendEmailResponse _$ResendEmailResponseFromJson(Map<String, dynamic> json) =>
    ResendEmailResponse(
      code: $enumDecode(_$CodeEnumMap, json['code']),
    );

Map<String, dynamic> _$ResendEmailResponseToJson(
        ResendEmailResponse instance) =>
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
