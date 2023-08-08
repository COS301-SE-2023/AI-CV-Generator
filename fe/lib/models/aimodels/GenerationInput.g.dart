// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenerationInput.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerationInput _$GenerationInputFromJson(Map<String, dynamic> json) =>
    GenerationInput(
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

Map<String, dynamic> _$GenerationInputToJson(GenerationInput instance) =>
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
