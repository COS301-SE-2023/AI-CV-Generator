// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      qualifications: (json['qualifications'] as List<dynamic>)
          .map((e) => Qualification.fromJson(e as Map<String, dynamic>))
          .toList(),
      employhistory: (json['employhistory'] as List<dynamic>)
          .map((e) => Employment.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>)
          .map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      detailsid: json['detailsid'] as int,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'detailsid': instance.detailsid,
      'qualifications': instance.qualifications,
      'employhistory': instance.employhistory,
      'links': instance.links,
    };
