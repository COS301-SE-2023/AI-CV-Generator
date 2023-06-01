// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      fname: json['fname'] as String,
      id: json['userid'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    )..details = json['details'] == null
        ? null
        : Details.fromJson(json['details'] as Map<String, dynamic>);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fname': instance.fname,
      'userid': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'details': instance.details,
    };
