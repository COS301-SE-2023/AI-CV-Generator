// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmploymentResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmploymentResponse _$EmploymentResponseFromJson(Map<String, dynamic> json) =>
    EmploymentResponse(
      employees: (json['employees'] as List<dynamic>)
          .map((e) => Employment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmploymentResponseToJson(EmploymentResponse instance) =>
    <String, dynamic>{
      'employees': instance.employees,
    };
