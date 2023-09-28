// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JobResponseDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobResponseDTO _$JobResponseDTOFromJson(Map<String, dynamic> json) =>
    JobResponseDTO(
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      link: json['link'] as String?,
      location: json['location'] as String?,
      salary: json['salary'] as String?,
      imgLink: json['imgLink'] as String?,
    );

Map<String, dynamic> _$JobResponseDTOToJson(JobResponseDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'link': instance.link,
      'location': instance.location,
      'salary': instance.salary,
      'imgLink': instance.imgLink,
    };
