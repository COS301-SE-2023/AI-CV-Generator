import 'package:json_annotation/json_annotation.dart';
part 'Links.g.dart';

@JsonSerializable()
class Links {
  Links({
    required this.links
  });
  List<Link> links;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

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