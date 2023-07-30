import 'package:json_annotation/json_annotation.dart';

part 'CVData.g.dart';

@JsonSerializable()
class CVData {
  String description;
  List<String> employmenthis;

  CVData({
    required this.description,
    required this.employmenthis
  });

  factory CVData.fromJson(Map<String,dynamic> json) => _$CVDataFromJson(json);

    Map<String,dynamic> toJson() => _$CVDataToJson(this);
}