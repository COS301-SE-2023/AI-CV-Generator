// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CVData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVData _$CVDataFromJson(Map<String, dynamic> json) => CVData(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      employmenthistory: (json['employmenthistory'] as List<dynamic>?)
          ?.map((e) => AIEmployment.fromJson(e as Map<String, dynamic>))
          .toList(),
      qualifications: (json['qualifications'] as List<dynamic>?)
          ?.map((e) => AIQualification.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => AILink.fromJson(e as Map<String, dynamic>))
          .toList(),
      references: (json['references'] as List<dynamic>?)
          ?.map((e) => AIReference.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => AISkill.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CVDataToJson(CVData instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'description': instance.description,
      'employmenthistory': instance.employmenthistory,
      'qualifications': instance.qualifications,
      'links': instance.links,
      'references': instance.references,
      'skills': instance.skills,
    };
