// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      id: json['userid'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    )
      ..details = json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>)
      ..phoneNumber = json['phoneNumber'] as String?
      ..email = json['email'] as String?
      ..location = json['location'] as String?
      ..description = json['description'] as String?;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'userid': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'details': instance.details,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'location': instance.location,
      'description': instance.description,
    };
