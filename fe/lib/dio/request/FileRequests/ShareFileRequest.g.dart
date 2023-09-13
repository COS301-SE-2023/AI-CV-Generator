// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShareFileRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareFileRequest _$ShareFileRequestFromJson(Map<String, dynamic> json) =>
    ShareFileRequest(
      filename: json['filename'] as String,
      base: json['base'] as String,
      duration: Duration(microseconds: json['duration'] as int),
    );

Map<String, dynamic> _$ShareFileRequestToJson(ShareFileRequest instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'base': instance.base,
      'duration': instance.duration.inMicroseconds,
    };
