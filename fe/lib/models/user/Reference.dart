import 'package:json_annotation/json_annotation.dart';
part 'Reference.g.dart';

@JsonSerializable()
class Reference {
  Reference({
    required this.description,
    required this.contact,
    required this.refid
  });
  String description;
  String contact;
  int refid;
  factory Reference.fromJson(Map<String, dynamic> json) => _$ReferenceFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceToJson(this);
}