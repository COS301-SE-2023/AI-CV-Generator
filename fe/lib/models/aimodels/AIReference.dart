import 'package:json_annotation/json_annotation.dart';

part 'AIReference.g.dart';

@JsonSerializable()
class AIReference {
  AIReference({
    this.description,
    this.contact
  });
  String? description;
  String? contact;

  factory AIReference.fromJson(Map<String,dynamic> json) => _$AIReferenceFromJson(json);

  Map<String,dynamic> toJson() => _$AIReferenceToJson(this);
}