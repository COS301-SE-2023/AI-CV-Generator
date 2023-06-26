import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';

class QualificationsSection extends StatefulWidget {
  List<Qualification> qualifications;
  QualificationsSection({super.key, required this.qualifications});

  @override
  QualificationsSectionState createState() => QualificationsSectionState();
}

class QualificationsSectionState extends State<QualificationsSection> {
  Map qualificationsMap = {};
  int id = 0;

  @override
  void initState() {
    widget.qualifications.forEach((element) {
      print(element.qualification);
      display(element);
     }
    );
    super.initState();
  }

  int get_id() {
    return id++;
  }

  void display(Qualification info) {
    int objectId = get_id();
    TextEditingController qualificationC = TextEditingController();
    TextEditingController instatutionC = TextEditingController();
    TextEditingController dateC = TextEditingController();

    qualificationC.text = info.qualification != null ? info.qualification : '';
    instatutionC.text = info.intstitution != null ? info.intstitution : '';
    dateC.text = dateTimeToString(info.date, info.endo);

    qualificationsMap[objectId] = {
      'quaid': info.quaid,
      'qualification': qualificationC,
      'instatution': instatutionC,
      'date': dateC,
    };

    qualificationsMap[objectId]['widget'] = (
      Column(
        children: [
          SizedBox(height: 16,),
          QualificationsField(
            qualificationC: qualificationsMap[objectId]['qualification'],
            instatutionC: qualificationsMap[objectId]['instatution'],
            dateC: qualificationsMap[objectId]['date'],
            ),
          SizedBox(height: 16,),
          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton(
              onPressed: (){
                remove(objectId);
              }, 
              child: Text('-'),),
          )
        ],
      )
    );
  }

  void add() {
    var newQualification = Qualification(
      qualification: '',
      intstitution: '',
      date: DateTime.now(),
      quaid: 0,
      endo: DateTime.now()
    );
    userApi.addQulaification(qualification: newQualification);
    display(newQualification);
  }

  void remove(int objectId) {
    Qualification? oldQualification = getQualification(objectId);
    if(oldQualification == null) {
      return;
    }
    userApi.removeQulaification(qualification: oldQualification);
    qualificationsMap.remove(objectId);
    setState(() {});
  }

  void update() {
    qualificationsMap.forEach((key, value) {
    Qualification? updatedQualification = getQualification(key);
      if(updatedQualification != null) {
        print("&&&&&&&&&&&&&");
        print(updatedQualification.intstitution);
        print(updatedQualification.qualification);
        print(updatedQualification.date);
        print(updatedQualification.endo);
        userApi.updateQulaification(qualification: updatedQualification);
      }
    });
  }

  Qualification? getQualification(int objectId) {
    if(qualificationsMap.containsKey(objectId) == false) {
      return null;
    }
    DateTimeRange dateTimeRange = stringToDateTimeRange(qualificationsMap[objectId]['date'].text);

    Qualification newQualification = Qualification(
      qualification: qualificationsMap[objectId]['qualification'].text,
      intstitution: qualificationsMap[objectId]['instatution'].text,
      quaid: 0,
      date: dateTimeRange.start,
      endo: dateTimeRange.end,
    );
    return newQualification;
  }

  List<Widget> populate() {
    List<Widget> linkWidgets = [];
    qualificationsMap.forEach((key, value) {
      linkWidgets.add(qualificationsMap[key]['widget']);
    });
    return linkWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...populate(),
        SizedBox(height: 8,),
        OutlinedButton(onPressed: (){
          add();
          setState(() {});
        }, child: Text('+')),
        SizedBox(height: 16,),
      ],
    );
  }
}

class QualificationsField extends StatefulWidget {
  TextEditingController qualificationC;
  TextEditingController instatutionC;
  TextEditingController dateC;
  QualificationsField({required this.qualificationC, required this.instatutionC, required this.dateC});

  @override
  QualificationsFieldState createState() => QualificationsFieldState();
}

class QualificationsFieldState extends State<QualificationsField> {
  TextEditingController displayDateC = TextEditingController();
  @override
void initState() {
  displayDateC.text = displayDateTimeRange(stringToDateTimeRange(widget.dateC.text));
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
          controller: widget.instatutionC,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "Institution",
            border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: TextFormField(
          controller: widget.qualificationC,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "Qualification",
            border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                datePicker(context).then((value) {
                  if(value != null) {
                    widget.dateC.text = dateTimeToString(value.start, value.end);
                    displayDateC.text = displayDateTimeRange(value);
                  }
                });
              });
            },
            child: TextFormField(
              enabled: false,
              controller: displayDateC,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Date",
                border: OutlineInputBorder(),
                ),
              ),
          ),
        ),
      ],
    );
  }
}

String dateTimeToString(DateTime start, DateTime end) {
  return start.toString() + "/" + end.toString();
}

DateTimeRange stringToDateTimeRange(String text) {
  List<String> dates = text.split('/');
  return DateTimeRange(start: DateTime.parse(dates[0]), end: DateTime.parse(dates[1]));
}

String displayDateTimeRange(DateTimeRange dateTimeRange) {
  return dateTimeRange.start.year.toString() + " - " + dateTimeRange.end.year.toString();
}

Future<DateTimeRange?> datePicker(BuildContext context) async {
  return showDateRangePicker(
      context: context, 
      firstDate: DateTime.now().subtract(const Duration(days:365*100)),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
    );
}

