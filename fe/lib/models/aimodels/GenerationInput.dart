import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:json_annotation/json_annotation.dart';


part 'GenerationInput.g.dart';

@JsonSerializable()
class GenerationInput {

  GenerationInput({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.location,
    required this.description,
    required this.experience,
    required this.qualifications
  });
  String firstname;
  String lastname;
  String email;
  String phoneNumber;
  String location;
  String description;
  List<AIEmployment> experience;
  List<AIQualification> qualifications;

  factory GenerationInput.fromJson(Map<String,dynamic> json) => _$GenerationInputFromJson(json);

  Map<String,dynamic> toJson() => _$GenerationInputToJson(this);
}