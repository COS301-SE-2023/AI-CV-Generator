// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      filename: json['filename'] as String,
      filetype: json['filetype'] as String,
      cover: const Uint8ListConverter().fromJson(json['cover'] as List<int>),
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'filename': instance.filename,
      'filetype': instance.filetype,
      'cover': const Uint8ListConverter().toJson(instance.cover),
    };
