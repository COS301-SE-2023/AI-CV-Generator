import 'package:json_annotation/json_annotation.dart';


part 'ExtractionRequest.g.dart';

@JsonSerializable()
class ExtractionRequest {
  String text;

  ExtractionRequest({
    required this.text
  });
  factory ExtractionRequest.fromJson(Map<String, dynamic> json) => _$ExtractionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ExtractionRequestToJson(this);
}