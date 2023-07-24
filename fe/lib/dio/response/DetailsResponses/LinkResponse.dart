
import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LinkResponse.g.dart';

@JsonSerializable()
class LinkResponse {
  List<Link> links;

  LinkResponse({
    required this.links
  });

  factory LinkResponse.fromJson(Map<String, dynamic> json) => _$LinkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LinkResponseToJson(this);
}