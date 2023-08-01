// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

class QualificationsDetailsForm extends StatefulWidget {
  const QualificationsDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QualificationsDetailsFormState();
  }
}

class _QualificationsDetailsFormState extends State<QualificationsDetailsForm> {
  // final _formKey = GlobalKey<FormState>();
  Column column = Column(children: [],);

  @override
  void initState() {
    if(Home.adjustedModel!.qualifications == null) {
      add();
      return;
    }
    for(int i = 0; i < Home.adjustedModel!.qualifications!.length; i++) {
      Qualification qualification = Home.adjustedModel!.qualifications![i];
      UniqueKey key = UniqueKey();
      column.children.add(TextMonitorWidget(key: key, institution: qualification.intstitution, qualification: qualification.qualification, start: qualification.date, end: qualification.endo));
      column.children.add(
        Padding(
          padding: const EdgeInsets.only(left: 500),
          child: IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/home'));
            }, icon: const Icon(Icons.remove)
          ),
        )
      );
        column.children.add(const SizedBox(height: 16,));
    }
    setState(() {});
    super.initState();
  }

  remove(UniqueKey key) {
    var index = -1;
    for(int i = 0; i < column.children.length; i++) {
      if(key  == column.children[i].key) {
        index = i;
        break;
      }
    }
    if(index > -1) {
      column.children.removeAt(index);
      column.children.removeAt(index);
      column.children.removeAt(index);
      setState(() {});
    }
  }
  
  add() async {
    UniqueKey key = UniqueKey();
    column.children.add(TextMonitorWidget(key: key));
    column.children.add(
      Padding(
        padding: const EdgeInsets.only(left: 500),
        child: IconButton(
        onPressed: () {
          remove(key);
        }, icon: const Icon(Icons.remove)
      ),
      )
    );
    column.children.add(const SizedBox(height: 16,));

    setState(() {});
  }

  updateUser() {
    Home.adjustedModel!.qualifications = [];
    for (var element in column.children) {
      if((element is TextMonitorWidget) == true) {
        Map data = (element as TextMonitorWidget).getdata();
        if(isDataNull(data.values) == false) {
          Home.adjustedModel!.qualifications!.add(Qualification(qualification: data['qualification'].toString(), intstitution: data['institution'].toString(), date: data['start'], quaid: 0, endo: data['end']));
        }
      }
    }
  }

  isDataNull(Iterable<dynamic> data) {
    for(int i = 0; i < data.length; i++) {
      if(data.elementAt(i) == null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ), 
          onPressed: () async { 
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: titleSection,
            ),
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  ...column.children
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container ( 
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () async {
                    add();
                  },
                ),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child: const Text('Back'),
                    onPressed: () {
                      updateUser();
                      Navigator.of(context).pop();
                      showQuestionaireModal(context, const PersonalDetailsForm());
                    },
                  ),
                ),
                const SizedBox(width: 64,),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child: const Text('Save and Proceed'),
                    onPressed: () async {
                      updateUser();
                      Navigator.of(context).pop();
                      showQuestionaireModal(context, const EmploymentDetailsForm());
                    },
                  ),
                ),

            ],
          ),
            const SizedBox(height: 64,),
          ],
        )
      )
    );
  }

  Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsQualifications.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
      ],
    );
}

class TextMonitorWidget extends StatefulWidget {
  Column column = Column(children: [],);
  TextEditingController institutionC = TextEditingController();
  TextEditingController qualificationC = TextEditingController();
  String? institution = "";
  String? qualification = "";
  DateTime? start;
  DateTime? end;
  TextMonitorWidget({super.key, this.institution, this.qualification, this.start, this.end});

  getdata() {
    return {
      "institution": institutionC.text,
      "qualification": qualificationC.text,
      "start": start,
      "end": end
    };
  }

  @override
  TextMonitorWidgetState createState() => TextMonitorWidgetState();
}

class TextMonitorWidgetState extends State<TextMonitorWidget> {
  @override
  void initState() {
    widget.institutionC.text = widget.institution != null ? widget.institution! : "";
    widget.qualificationC.text = widget.qualification != null ? widget.qualification! : "";
    super.initState();
  }

  populate() {
    widget.column.children.add(_buildInstitutionField(widget.institutionC));
    widget.column.children.add(_buildQualificationField(widget.qualificationC));
    widget.column.children.add(_buildGraduationField());
  }

  Widget _buildInstitutionField(TextEditingController controller) {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Institution input"),
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Institution',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.school),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    );
  }

  Widget _buildQualificationField(TextEditingController controller) {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Qualification input"),
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Qualification',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.article),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    );
  }

  Widget _buildGraduationField() {
    return Container (
      width: 100,
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: Row(
        children: [
          Expanded(
            child: DateTimeFormField(
              initialValue: widget.start,
              onDateSelected: (value) {
                widget.start = value;
              },
              key: const Key("Graduation input"),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(5.0),
                labelText: 'Start Date',
                enabledBorder: OutlineInputBorder(),
                icon: Icon(Icons.date_range),
              ),
              mode: DateTimeFieldPickerMode.date,
            )
          ),
          const SizedBox(width: 16,),
          Expanded(
            child: DateTimeFormField(
              initialValue: widget.end,
              onDateSelected: (value) {
                widget.end = value;
              },
              key: const Key("Graduation input"),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(5.0),
                labelText: 'End Date',
                enabledBorder: OutlineInputBorder(),
                icon: Icon(Icons.date_range),
              ),
              mode: DateTimeFieldPickerMode.date,
            )
          ),
        ],
      )
    );
      
  }

  @override
  Widget build(BuildContext context) {
    populate();
    return widget.column;
  }
}