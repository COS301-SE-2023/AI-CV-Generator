import 'package:json_annotation/json_annotation.dart';
part 'Qualification.g.dart';


@JsonSerializable()
class Qualification {
  Qualification({
    required this.qualification,
    required this.instatution,
    required this.date,
    required this.quaid,
    required this.endo
  });

  int quaid;
  String qualification;
  String instatution;
  DateTime date;
  DateTime endo;

  factory Qualification.fromJson(Map<String, dynamic> json) => _$QualificationFromJson(json);
  Map<String, dynamic> toJson() => _$QualificationToJson(this);
}