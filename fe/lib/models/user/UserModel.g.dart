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
      ..employmenthistory = (json['employmenthistory'] as List<dynamic>?)
          ?.map((e) => Employment.fromJson(e as Map<String, dynamic>))
          .toList()
      ..links = (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList()
      ..references = (json['references'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList()
      ..skills = (json['skills'] as List<dynamic>?)
          ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
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
      'employmenthistory': instance.employmenthistory,
      'links': instance.links,
      'references': instance.references,
      'skills': instance.skills,
    };
