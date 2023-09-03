import 'package:json_annotation/json_annotation.dart';

part 'AIReference.g.dart';

@JsonSerializable()
class AIReference {
  AIReference({
    required this.description,
    required this.contact
  });
  String description;
  String contact;

  factory AIReference.fromJson(Map<String,dynamic> json) => _$AIReferenceFromJson(json);

  Map<String,dynamic> toJson() => _$AIReferenceToJson(this);
}