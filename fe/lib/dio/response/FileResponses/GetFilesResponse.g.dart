// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetFilesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFilesResponse _$GetFilesResponseFromJson(Map<String, dynamic> json) =>
    GetFilesResponse(
      files: (json['files'] as List<dynamic>)
          .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFilesResponseToJson(GetFilesResponse instance) =>
    <String, dynamic>{
      'files': instance.files,
    };
