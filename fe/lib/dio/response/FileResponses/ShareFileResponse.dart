import 'package:json_annotation/json_annotation.dart';

part 'ShareFileResponse.g.dart';

@JsonSerializable()
class ShareFileResponse {
  String generateUrl;

  ShareFileResponse({
    required this.generateUrl
  });

  factory ShareFileResponse.fromJson(Map<String, dynamic> json) => _$ShareFileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShareFileResponseToJson(this);
}