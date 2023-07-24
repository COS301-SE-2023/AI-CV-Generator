import 'package:json_annotation/json_annotation.dart';
part 'Link.g.dart';

@JsonSerializable()
class Link {
  Link({
    required this.url,
    required this.linkid
  });
  String url;
  int linkid;
  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}