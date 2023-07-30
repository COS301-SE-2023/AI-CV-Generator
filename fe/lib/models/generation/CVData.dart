import 'package:json_annotation/json_annotation.dart';

part 'CVData.g.dart';

@JsonSerializable()
class CVData {
  String description;
  List<String> employmenthis;
  String education_description;

  CVData({
    required this.description,
    required this.employmenthis,
    required this.education_description
  });

  factory CVData.fromJson(Map<String,dynamic> json) => _$CVDataFromJson(json);

    Map<String,dynamic> toJson() => _$CVDataToJson(this);
}