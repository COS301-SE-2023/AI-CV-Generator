
import 'package:json_annotation/json_annotation.dart';
part 'userdata.g.dart';

@JsonSerializable()
class Data {
  Data({
    required this.email,
    required this.username,
  });

  String email;
  @JsonKey(name: 'username')
  String username;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}