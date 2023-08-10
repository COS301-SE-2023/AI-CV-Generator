// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CVData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVData _$CVDataFromJson(Map<String, dynamic> json) => CVData(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location: json['location'] as String,
      description: json['description'] as String?,
      employmenthis: (json['employmenthis'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      qualifications: (json['qualifications'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : AIQualification.fromJson(e as Map<String, dynamic>))
          .toList(),
      education_description: json['education_description'] as String?,
    );

Map<String, dynamic> _$CVDataToJson(CVData instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'description': instance.description,
      'employmenthis': instance.employmenthis,
      'qualifications': instance.qualifications,
      'education_description': instance.education_description,
    };
