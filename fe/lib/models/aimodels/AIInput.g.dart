// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AIInput.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIInput _$AIInputFromJson(Map<String, dynamic> json) =>
    AIInput(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      experience: (json['experience'] as List<dynamic>)
          .map((e) => AIEmployment.fromJson(e as Map<String, dynamic>))
          .toList(),
      qualifications: (json['qualifications'] as List<dynamic>)
          .map((e) => AIQualification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AIInputToJson(AIInput instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'description': instance.description,
      'experience': instance.experience,
      'qualifications': instance.qualifications,
    };
