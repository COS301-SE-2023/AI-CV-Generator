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
    print('removed:');
    print(qualificationsMap[objectId]['qualification'].text);
    qualificationsMap.remove(objectId);
    setState(() {});
  }

  List<Qualification> update() {
    List<Qualification> QualificationCol = [];
    qualificationsMap.forEach((key, value) {
      // QualificationCol.add(Qualification(quaid: qualificationsMap[key]["quaid"].text, Qualificationid: qualificationsMap[key]["Qualificationid"]));
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
          var newQualification = Qualification(qualification: '', instatution: '', date: DateTime.now(), quaid: get_id());
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
          controller: widget.instatutionC,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "",
            border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: TextFormField(
          controller: widget.qualificationC,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "",
            border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: TextFormField(
          controller: widget.dateC,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "Date",
            border: OutlineInputBorder(),
            ),
            onTap: () {
              setState(() {
                datePicker(context).then((value) {
                if(value != null) {
                  widget.dateC.text = value.start.year.toString() + ' - ' + value.end.year.toString();
                }
              });
              });
            },
          ),
        ),
      ],
    );
  }
}

String getDate(BuildContext context) {
  var date = 'hello';
  datePicker(context).then((value) {
    if(value != null) {
      date = value.start.year.toString() + ' - ' + value.end.year.toString();
      print("not null");
      print(date);
    }
  });
  print(date);
  return date;
}

Future<DateTimeRange?> datePicker(BuildContext context) async {
  return showDateRangePicker(
      context: context, 
      firstDate: DateTime.now().subtract(const Duration(days:365*100)),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
    );
}

