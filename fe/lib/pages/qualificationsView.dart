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
    int linkId = get_id();
    TextEditingController qualificationC = TextEditingController();
    TextEditingController instatutionC = TextEditingController();
    TextEditingController dateC = TextEditingController();

    qualificationC.text = info.qualification;
    instatutionC.text = info.instatution;

    qualificationsMap[linkId] = {
      'quaid': info.quaid,
      'qualification': qualificationC,
      'instatution': instatutionC,
      'date': dateC,
    };

    qualificationsMap[linkId]['widget'] = (
      Column(
        children: [
          SizedBox(height: 16,),
          QualificationsField(
            qualificationC: qualificationsMap[linkId]['qualification'],
            instatutionC: qualificationsMap[linkId]['instatution'],
            dateC: qualificationsMap[linkId]['date'],
            ),
          SizedBox(height: 16,),
          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton(
              onPressed: (){
                remove(linkId);
              }, 
              child: Text('-'),),
          )
        ],
      )
    );
  }

  void remove(int linkId) {
    print('removed:');
    print(qualificationsMap[linkId]['quaid'].text);
    qualificationsMap.remove(linkId);
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
          // var newQualification = Qualification(qualification: qualification, instatution: instatution, date: date, quaid: quaid);
          // widget.qualifications.add(newQualification);
          // add(newQualification);
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
        Container(
          child: TextFormField(
          controller: widget.instatutionC,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "",
            border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          child: TextFormField(
          controller: widget.qualificationC,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "",
            border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          child: TextFormField(
          controller: widget.dateC,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: "",
            border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

void datePicker(BuildContext context) {
  showDialog(context: context, builder: (BuildContext context) {
    return Container(
      child: CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now(),
        onDateChanged:(value) {
        },
      ),
    );
  });
}

