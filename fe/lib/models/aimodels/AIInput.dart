import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:json_annotation/json_annotation.dart';


part 'AIInput.g.dart';

@JsonSerializable()
class AIInput {

  AIInput({
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.location,
    this.description,
    required this.experience,
    required this.qualifications,
    required this.links,
    required this.references,
    required this.skills
  });
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? location;
  String? description;
  List<AIEmployment> experience;
  List<AIQualification> qualifications;
  List<AILink> links;
  List<AIReference> references;
  List<AISkill> skills;

  factory AIInput.fromJson(Map<String,dynamic> json) => _$AIInputFromJson(json);

  Map<String,dynamic> toJson() => _$AIInputToJson(this);
}