// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      qualifications: Qualifications.fromJson(
          json['qualifications'] as Map<String, dynamic>),
      employhistory: EmploymentHistory.fromJson(
          json['employhistory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'qualifications': instance.qualifications,
      'employhistory': instance.employhistory,
    };
