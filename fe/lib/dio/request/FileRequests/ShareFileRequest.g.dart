// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShareFileRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareFileRequest _$ShareFileRequestFromJson(Map<String, dynamic> json) =>
    ShareFileRequest(
      filename: json['filename'] as String,
      base: json['base'] as String,
    );

Map<String, dynamic> _$ShareFileRequestToJson(ShareFileRequest instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'base': instance.base,
    };
