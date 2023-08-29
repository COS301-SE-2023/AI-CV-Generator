import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ReferenceRequest.g.dart';

@JsonSerializable()
class ReferenceRequest {
  Reference reference;

  ReferenceRequest({
    required this.reference
  });
  
  factory ReferenceRequest.fromJson(Map<String, dynamic> json) => _$ReferenceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceRequestToJson(this);

}