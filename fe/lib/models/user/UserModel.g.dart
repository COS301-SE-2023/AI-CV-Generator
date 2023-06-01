// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfomat _$UserInfomatFromJson(Map<String, dynamic> json) => UserInfomat(
      fname: json['fname'] as String,
      id: json['userid'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserInfomatToJson(UserInfomat instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'userid': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
