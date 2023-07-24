import 'package:json_annotation/json_annotation.dart';

part 'Employment.g.dart';

@JsonSerializable()
class Employment {
    Employment ({
      required this.company,
      required this.title,
      required this.startdate,
      required this.enddate,
      required this.empid
    });

    String company;
    String title;
    DateTime startdate;
    DateTime enddate;
    int empid;

    factory Employment.fromJson(Map<String, dynamic> json) => _$EmploymentFromJson(json);
    Map<String, dynamic> toJson() => _$EmploymentToJson(this);

}