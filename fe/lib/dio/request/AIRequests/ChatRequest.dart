import 'package:json_annotation/json_annotation.dart';


part 'ChatRequest.g.dart';

@JsonSerializable()
class ChatRequest {
  List<String> messages;
  String userMessage;

  ChatRequest({
    required this.messages,
    required this.userMessage
  });
  factory ChatRequest.fromJson(Map<String, dynamic> json) => _$ChatRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRequestToJson(this);
}