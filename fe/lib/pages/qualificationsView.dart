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
      add(element);
     }
    );
    super.initState();
  }

  int get_id() {
    return id++;
  }

  void add(Qualification info) {
    int objectId = get_id();
    TextEditingController qualificationC = TextEditingController();
    TextEditingController instatutionC = TextEditingController();
    TextEditingController dateC = TextEditingController();

    qualificationC.text = info.qualification;
    instatutionC.text = info.instatution;
    dateC.text = dateTimeToString(info.date, info.end);

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

  void remove(int objectId) {
    qualificationsMap.remove(objectId);
    setState(() {});
  }

  List<Qualification> update() {
    List<Qualification> QualificationCol = [];
    qualificationsMap.forEach((key, value) {
      DateTimeRange dateTimeRange = stringToDateTimeRange(qualificationsMap[key]['date'].text);
      QualificationCol.add(
        Qualification(
          quaid: qualificationsMap[key]['quaid'],
          qualification: qualificationsMap[key]['qualification'].text,
          instatution: qualificationsMap[key]['instatution'].text,
          date: dateTimeRange.start,
          end: dateTimeRange.end,
        )
      );
    });
    return QualificationCol;
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
          Qualification newQualification = Qualification(qualification: '', instatution: '', date: DateTime.now(), end: DateTime.now(), quaid: get_id());
          widget.qualifications.add(newQualification);
          add(newQualification);
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

