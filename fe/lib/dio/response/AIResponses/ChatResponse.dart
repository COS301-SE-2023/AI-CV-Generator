import 'package:json_annotation/json_annotation.dart';


part 'ChatResponse.g.dart';

@JsonSerializable()
class ChatResponse {
  List<String> messages;

  ChatResponse({
    required this.messages
  });
  factory ChatResponse.fromJson(Map<String, dynamic> json) => _$ChatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}