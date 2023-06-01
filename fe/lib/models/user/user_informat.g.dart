// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_informat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfomat _$UserInfomatFromJson(Map<String, dynamic> json) => UserInfomat(
      name: json['name'] as String,
      job: json['job'] as String,
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserInfomatToJson(UserInfomat instance) =>
    <String, dynamic>{
      'name': instance.name,
      'job': instance.job,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
