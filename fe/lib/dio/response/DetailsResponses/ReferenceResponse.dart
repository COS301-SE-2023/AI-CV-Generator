import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ReferenceResponse.g.dart';

@JsonSerializable()
class ReferenceResponse {
  List<Reference> references;

  ReferenceResponse({
    required this.references
  });
  
  factory ReferenceResponse.fromJson(Map<String, dynamic> json) => _$ReferenceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceResponseToJson(this);

}