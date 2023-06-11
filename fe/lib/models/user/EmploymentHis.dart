import 'package:json_annotation/json_annotation.dart';

part 'EmploymentHis.g.dart';

@JsonSerializable()
class EmploymentHistory {
    EmploymentHistory({
      required this.employHis
    });

    List<Employment> employHis;

    factory EmploymentHistory.fromJson(Map<String, dynamic> json) => _$EmploymentHistoryFromJson(json);
    Map<String, dynamic> toJson() => _$EmploymentHistoryToJson(this);
}

@JsonSerializable()
class Employment {
    Employment ({
      required this.company,
      required this.title,
      required this.start_date,
      required this.end_date,
      required this.empid
    });

    String company;
    String title;
    DateTime start_date;
    DateTime end_date;
    int empid;

    factory Employment.fromJson(Map<String, dynamic> json) => _$EmploymentFromJson(json);
    Map<String, dynamic> toJson() => _$EmploymentToJson(this);

}