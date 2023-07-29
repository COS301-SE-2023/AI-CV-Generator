// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/employment.dart';
import 'package:ai_cv_generator/pages/navdrawer.dart';
import 'package:ai_cv_generator/pages/personaldetails.dart';
import 'package:ai_cv_generator/pages/questionaireModal.dart';
import 'package:ai_cv_generator/pages/strings.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class QualificationsDetailsForm extends StatefulWidget {
  final UserModel user;
  const QualificationsDetailsForm({super.key, required this.user});

  @override
  State<StatefulWidget> createState() {
    return _QualificationsDetailsFormState();
  }
}

class _QualificationsDetailsFormState extends State<QualificationsDetailsForm> {
  // final _formKey = GlobalKey<FormState>();
  Map data = {};
  Column column = Column(children: [],);

  @override
  void initState() {
    if(widget.user.qualifications == null) {
      add();
      return;
    }
    for(int i = 0; i < widget.user.qualifications!.length; i++) {
      Qualification qualification = widget.user.qualifications![i];
      UniqueKey key = UniqueKey();
      column.children.add(TextMonitorWidget(key: key, institution: qualification.intstitution, qualification: qualification.qualification, start: qualification.date, end: qualification.endo));
      column.children.add(
        Padding(
          padding: EdgeInsets.only(left: 500),
          child: IconButton(
            onPressed: () {
              remove(key);
            }, icon: const Icon(Icons.remove)
          ),
        )
      );
        column.children.add(SizedBox(height: 16,));
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
        padding: EdgeInsets.only(left: 500),
        child: IconButton(
        onPressed: () {
          remove(key);
        }, icon: const Icon(Icons.remove)
      ),
      )
    );
    column.children.add(SizedBox(height: 16,));

    setState(() {});
  }

  updateUser() {
    print("here");
    column.children.forEach((element) {
      var data = (element as TextMonitorWidget).getdata();
      print(data);
      widget.user.qualifications!.add(Qualification(qualification: data.qualification, intstitution: data.intstitution, date: data.date, quaid: 0, endo: data.endo));
    });
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
                    onPressed: () async {
                      Navigator.of(context).pop();
                      showQuestionaireModal(context, PersonalDetailsForm(user: widget.user));
                    },
                  ),
                ),
                SizedBox(width: 64,),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child: const Text('Save and Proceed'),
                    onPressed: () async {
                      updateUser();
                      Navigator.of(context).pop();
                      showQuestionaireModal(context, EmploymentDetailsForm(user: widget.user));
                    },
                  ),
                ),

            ],
          ),
            SizedBox(height: 64,),
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
  DateTime? start = null;
  DateTime? end = null;
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
          SizedBox(width: 16,),
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