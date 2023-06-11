import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/AddLinkRequest.g.dart';

@JsonSerializable()
class AddLinkRequest {
  Link link;

  AddLinkRequest({
    required this.link
  });
  
  factory AddLinkRequest.fromJson(Map<String, dynamic> json) => _$AddLinkRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddLinkRequestToJson(this);

}