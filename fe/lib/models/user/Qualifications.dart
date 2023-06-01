import 'package:json_annotation/json_annotation.dart';
part 'Qualifications.g.dart';

@JsonSerializable()
class Qualifications {
  Qualifications({
    required this.qualifications
  });
  List<Qualification> qualifications;

  factory Qualifications.fromJson(Map<String, dynamic> json) => _$QualificationsFromJson(json);
  Map<String, dynamic> toJson() => _$QualificationsToJson(this);
}

@JsonSerializable()
class Qualification {
  Qualification({
    required this.qualification,
    required this.instatution,
    required this.date
  });
  String qualification;
  String instatution;
  DateTime date;

  factory Qualification.fromJson(Map<String, dynamic> json) => _$QualificationFromJson(json);
  Map<String, dynamic> toJson() => _$QualificationToJson(this);
}