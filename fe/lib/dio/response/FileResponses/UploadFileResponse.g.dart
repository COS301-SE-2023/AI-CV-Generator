// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UploadFileResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadFileResponse _$UploadFileResponseFromJson(Map<String, dynamic> json) =>
    UploadFileResponse(
      code: $enumDecode(_$CodeEnumMap, json['code']),
    );

Map<String, dynamic> _$UploadFileResponseToJson(UploadFileResponse instance) =>
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
