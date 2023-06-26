
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EmploymentResponse.g.dart';

@JsonSerializable()
class EmploymentResponse {
  List<Employment> employees;

  EmploymentResponse({
    required this.employees
  });

  factory EmploymentResponse.fromJson(Map<String, dynamic> json) => _$EmploymentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmploymentResponseToJson(this);
}