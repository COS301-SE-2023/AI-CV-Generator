// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
      messages:
          (json['messages'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
