// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reference _$ReferenceFromJson(Map<String, dynamic> json) => Reference(
      description: json['description'] as String,
      contact: json['contact'] as String,
      refid: json['refid'] as int,
    );

Map<String, dynamic> _$ReferenceToJson(Reference instance) => <String, dynamic>{
      'description': instance.description,
      'contact': instance.contact,
      'refid': instance.refid,
    };
