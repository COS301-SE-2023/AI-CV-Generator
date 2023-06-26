import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UpdateLinkRequest.g.dart';

@JsonSerializable()
class UpdateLinkRequest {
  Link link;

  UpdateLinkRequest({
    required this.link
  });
  
  factory UpdateLinkRequest.fromJson(Map<String, dynamic> json) => _$UpdateLinkRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateLinkRequestToJson(this);

}