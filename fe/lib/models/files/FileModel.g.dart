// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      name: json['name'] as String,
      size: json['size'] as int,
      bytes: const Uint8ListConverter().fromJson(json['bytes'] as List<int>),
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
    };
