import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Link.dart';
part 'userDetails.g.dart';

@JsonSerializable()
class Details {
  Details({
    required this.qualifications,
    required this.employhistory,
    required this.links,
    required this.detailsid
  });
  int detailsid;
  List<Qualification> qualifications;
  List<Employment> employhistory;
  List<Link> links;

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}