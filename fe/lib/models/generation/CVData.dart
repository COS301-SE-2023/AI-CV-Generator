import 'package:json_annotation/json_annotation.dart';

part 'CVData.g.dart';

@JsonSerializable()
class CVData {
  String? description;
  List<String>? employmenthis;
  String? education_description;

  CVData({
    this.description,
    this.employmenthis,
    this.education_description
  });

  factory CVData.fromJson(Map<String,dynamic> json) => _$CVDataFromJson(json);

    Map<String,dynamic> toJson() => _$CVDataToJson(this);
}