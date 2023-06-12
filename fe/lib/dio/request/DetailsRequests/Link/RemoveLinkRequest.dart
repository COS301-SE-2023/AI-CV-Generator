import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'RemoveLinkRequest.g.dart';

@JsonSerializable()
class RemoveLinkRequest {
  Link link;

  RemoveLinkRequest({
    required this.link
  });
  
  factory RemoveLinkRequest.fromJson(Map<String, dynamic> json) => _$RemoveLinkRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveLinkRequestToJson(this);

}