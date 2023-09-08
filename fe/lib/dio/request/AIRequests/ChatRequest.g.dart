// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRequest _$ChatRequestFromJson(Map<String, dynamic> json) => ChatRequest(
      messages:
          (json['messages'] as List<dynamic>).map((e) => e as String).toList(),
      userMessage: json['userMessage'] as String,
    );

Map<String, dynamic> _$ChatRequestToJson(ChatRequest instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'userMessage': instance.userMessage,
    };
