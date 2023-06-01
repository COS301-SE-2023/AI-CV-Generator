import 'package:ai_cv_generator/models/user/EmploymentHis.dart';
import 'package:ai_cv_generator/models/user/Qualifications.dart';
import 'package:json_annotation/json_annotation.dart';
part 'userDetails.g.dart';

@JsonSerializable()
class Details {
  Details({
    required this.qualifications,
    required this.employhistory
  });
  Qualifications qualifications;
  EmploymentHistory employhistory;

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}