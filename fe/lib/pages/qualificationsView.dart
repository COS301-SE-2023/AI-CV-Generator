import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'elements/elements.dart';

class QualificationsSection extends StatefulWidget {
  List<Qualification> qualifications;
  QualificationsSection({super.key, required this.qualifications});

  @override
  QualificationsSectionState createState() => QualificationsSectionState();
}

class QualificationsSectionState extends State<QualificationsSection> {
  final blankQualification = Qualification(qualification: '', intstitution: '', date: DateTime.now(), quaid: 0, endo: DateTime.now());
  Map qualificationsMap = {};
  List<Map> institution = [];
  bool editing = false;

  @override
  void initState() {
    widget.qualifications.forEach((element) {
      display(element);
     }
    );
    super.initState();
  }

  void display(Qualification info) {
    TextEditingController qualificationC = TextEditingController();
    TextEditingController intstitutionC = TextEditingController();
    TextEditingController dateC = TextEditingController();

    qualificationC.text = info.qualification != null ? info.qualification : '';
    intstitutionC.text = info.intstitution != null ? info.intstitution : '';
    dateC.text = dateTimeToString(info.date, info.endo);
    qualificationsMap[info.quaid] = {
      'quaid': info.quaid,
      'qualification': qualificationC,
      'intstitution': intstitutionC,
      'date': dateC,
    };
    qualificationsMap[info.quaid]['widget'] = (
      Column(
        children: [
          SizedBox(height: 4,),
          QualificationsField(
            qualificationC: qualificationsMap[info.quaid]['qualification'],
            intstitutionC: qualificationsMap[info.quaid]['intstitution'],
            dateC: qualificationsMap[info.quaid]['date'],
            ),
          SizedBox(height: 4,),
        ],
      )
    );
  }

  void add() {
    userApi.addQulaification(qualification: blankQualification).then((value) {
      Qualification newQualification = getCorrect(value!)!;
      display(newQualification);
      setState(() {});
    });
  }

  void addInstitution() {
    institution;
  }

  void addQualification() {
    
  }

  void remove(int objectId) async {
    Qualification? oldQualification = getQualification(objectId);
    if(oldQualification == null) {
      return;
    }
    userApi.removeQulaification(qualification: oldQualification);
    qualificationsMap.remove(objectId);
    setState(() {});
  }

  void update() async {
    qualificationsMap.forEach((key, value) {
    Qualification? updatedQualification = getQualification(key);
      if(updatedQualification != null) {
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
      intstitution: qualificationsMap[objectId]['intstitution'].text,
      quaid: qualificationsMap[objectId]['quaid'],
      date: dateTimeRange.start,
      endo: dateTimeRange.end,
    );
    return newQualification;
  }

  Qualification? getCorrect(List<Qualification> list) {
    for(var i = 0; i <= list.length-1; i++) {
      if(qualificationsMap.containsKey(list[i].quaid) == false) {
        return list[i];
      }
    }
    return null;
  }

  List<Widget> populate() {
    List<Widget> linkWidgets = [];
    qualificationsMap.forEach((key, value) {
      linkWidgets.add(qualificationsMap[key]['widget']);
      if(editing == true) {
        linkWidgets.add(
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: (){
                remove(key);
              }, 
              icon: Icon(Icons.remove)),
          ),
        );
        linkWidgets.add(SizedBox(height: 4,),);
      }
    });
    return linkWidgets;
  }

  edit() {
    setState(() {
      editing = !editing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        children: [
          SectionHeadingBar(
            children: [
              SectionHeading(text: "EDUCATION",),
            ],
            actions: [
              IconButton(onPressed: () {
                if(editing == false) {
                  add();
                }
              }, icon: Icon(Icons.add)),
              IconButton(onPressed: () {
                  edit();
              }, icon: Icon(Icons.edit)),
            ],
          ),
          SizedBox(height: 16,),
          ...populate(),
        ]
      )
    );
  }
}

class QualificationsField extends StatefulWidget {
  TextEditingController qualificationC;
  TextEditingController intstitutionC;
  TextEditingController dateC;
  QualificationsField({required this.qualificationC, required this.intstitutionC, required this.dateC});

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
    return Container(
      // color: Colors.grey,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        children: [
            TextFormField(
            style: TextStyle(fontSize: 20),
            controller: widget.intstitutionC,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "INSTITUTION NAME",
              border: InputBorder.none
              ),
            ),
            SizedBox(width: 8,),
            TextFormField(
            // style: TextStyle(fontSize: 5),
            controller: widget.qualificationC,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "QUALIFICATION NAME",
              hintStyle: TextStyle(fontSize: 15),
              border: InputBorder.none
              ),
            ),
            SizedBox(width: 8,),
            GestureDetector(
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
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "Date",
                  border: InputBorder.none,
                  ),
                ),
            ),
          ],
      )
      // child: Row(
      //   children: [
      //     Expanded(
      //       child: TextFormField(
      //       // style: TextStyle(fontSize: 5),
      //       controller: widget.intstitutionC,
      //       textAlign: TextAlign.center,
      //       decoration: InputDecoration(
      //         hintText: "Institution",
      //         border: OutlineInputBorder(),
      //         ),
      //       ),
      //     ),
      //     SizedBox(width: 8,),
      //     Expanded(
      //       child: TextFormField(
      //         controller: widget.qualificationC,
      //         textAlign: TextAlign.center,
      //         decoration: InputDecoration(
      //           hintText: "Qualification",
      //           border: OutlineInputBorder(),
      //         ),
      //       ),
      //     ),
      //     SizedBox(width: 8,),
      //     Expanded(
      //       child: GestureDetector(
      //         onTap: () {
      //           setState(() {
      //             datePicker(context).then((value) {
      //               if(value != null) {
      //                 widget.dateC.text = dateTimeToString(value.start, value.end);
      //                 displayDateC.text = displayDateTimeRange(value);
      //               }
      //             });
      //           });
      //         },
      //         child: TextFormField(
      //           enabled: false,
      //           controller: displayDateC,
      //           textAlign: TextAlign.center,
      //           decoration: InputDecoration(
      //             hintText: "Date",
      //             border: OutlineInputBorder(),
      //             ),
      //           ),
      //       ),
      //     ),
      //   ],
      // )
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