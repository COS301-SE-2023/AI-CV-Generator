// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      username: json['username'] as String,
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
      'username': instance.username,
      'details': instance.details,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'location': instance.location,
      'description': instance.description,
    };
