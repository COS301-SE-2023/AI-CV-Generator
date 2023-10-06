import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CVData.g.dart';

@JsonSerializable()
class CVData {
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? location; 
  String? description;
  List<AIEmployment>? employmenthistory;
  List<AIQualification>? qualifications;
  List<AILink>? links;
  List<AIReference>? references;
  List<AISkill>? skills;

  CVData({
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.location,
    this.description,
    this.employmenthistory,
    this.qualifications,
    this.links,
    this.references,
    this.skills
  });

  factory CVData.fromJson(Map<String,dynamic> json) => _$CVDataFromJson(json);

    Map<String,dynamic> toJson() => _$CVDataToJson(this);
}