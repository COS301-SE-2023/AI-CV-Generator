import 'package:json_annotation/json_annotation.dart';

part 'AILink.g.dart';

@JsonSerializable()
class AILink {
  AILink({
    this.url
  });

  String? url;

  factory AILink.fromJson(Map<String,dynamic> json) => _$AILinkFromJson(json);

  Map<String,dynamic> toJson() => _$AILinkToJson(this);
}