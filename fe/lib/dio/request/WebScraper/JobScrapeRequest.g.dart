// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JobScrapeRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobScrapeRequest _$JobScrapeRequestFromJson(Map<String, dynamic> json) =>
    JobScrapeRequest(
      field: json['field'] as String,
      location: json['location'] as String,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$JobScrapeRequestToJson(JobScrapeRequest instance) =>
    <String, dynamic>{
      'field': instance.field,
      'location': instance.location,
      'amount': instance.amount,
    };
