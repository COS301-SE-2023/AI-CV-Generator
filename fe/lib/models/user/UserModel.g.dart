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
      ..phoneNumber = json['phoneNumber'] as String?
      ..email = json['email'] as String?
      ..location = json['location'] as String?
      ..description = json['description'] as String?
      ..qualifications = (json['qualifications'] as List<dynamic>?)
          ?.map((e) => Qualification.fromJson(e as Map<String, dynamic>))
          .toList()
      ..employhistory = (json['employhistory'] as List<dynamic>?)
          ?.map((e) => Employment.fromJson(e as Map<String, dynamic>))
          .toList()
      ..links = (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'location': instance.location,
      'description': instance.description,
      'qualifications': instance.qualifications,
      'employhistory': instance.employhistory,
      'links': instance.links,
    };
