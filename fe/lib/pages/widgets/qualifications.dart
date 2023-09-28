// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';

class QualificationsDetailsFormTest extends StatefulWidget{
  QualificationsDetailsFormTest({super.key});

  @override
  State<StatefulWidget> createState() => QualificationsDetailsFormTestState();
}

class QualificationsDetailsFormTestState extends State<QualificationsDetailsFormTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: QualificationsDetailsForm(),
    );
  }
}


class QualificationsDetailsForm extends StatefulWidget {
  const QualificationsDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QualificationsDetailsFormState();
  }
}

class _QualificationsDetailsFormState extends State<QualificationsDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
  Column column =  Column(children: [],);

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
              remove(key);
            }, icon: const Icon(Icons.delete)
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
  
  add() {
    UniqueKey key = UniqueKey();
    column.children.add(TextMonitorWidget(key: key));
    column.children.add(
      Padding(
        padding: const EdgeInsets.only(left: 500),
        child: IconButton(
        onPressed: () {
          remove(key);
        }, icon: const Icon(Icons.delete)
      ),
      )
    );
    column.children.add(const SizedBox(height: 16,));

    setState(() {});
  }

  bool updateUser() {
    Home.adjustedModel!.qualifications = [];
    for (var element in column.children) {
      if((element is TextMonitorWidget) == true) {
        Map data = (element as TextMonitorWidget).getdata();
        if(isDataNull(data.values) == false) {
          Home.adjustedModel!.qualifications!.add(Qualification(qualification: data['qualification'].toString(), intstitution: data['institution'].toString(), date: data['start'], quaid: 0, endo: data['end']));
        }
      }
    }
    return _formKey.currentState!.validate();
  }

  isDataNull(Iterable<dynamic> data) {
    for(int i = 0; i < data.length; i++) {
      if(data.elementAt(i) == null) {
        return true;
      }
    }
    return false;
  }

  back() {
    Navigator.of(context).pop();
    showQuestionaireModal(context,const PersonalDetailsForm());
  }

  toNext() {
    Navigator.of(context).pop();
    showQuestionaireModal(context,const EmploymentDetailsForm());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return Scaffold(
      drawer:  const NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ), 
          onPressed: () async { 
           Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: titleSection(w,h),
            ),
            Expanded(
              flex: 4,
              child: Form(
                key: _formKey,
                child: 
                column.children.isNotEmpty ?
                ListView(
                  children: [
                    ...column.children
                  ],
                ) : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school,color: Colors.grey,size: w*h*1,),
                      SizedBox(height: h*2),
                      Text(
                        "No Qualifications...", 
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: w*h*0.15
                        )
                      )
                    ],
                  ),
                )
              )     
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container ( 
                padding:  EdgeInsets.all(0.2*w*h),
                child: CustomizableButton(
                  text: 'Add',
                  width: w*3,
                  height: h*4,
                  onTap: () => add(),
                  fontSize: w*h*0.1,
                )
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                CustomizableButton(
                  text: 'Back',
                  width: w*8,
                  height: h*5,
                  onTap: () {
                    updateUser();
                    back();
                  },
                  fontSize: w*h*0.1,
                ),
                SizedBox(width: w*6.4,),
                CustomizableButton(
                  text: 'Save and Proceed',
                  width: w*8,
                  height: h*5,
                  onTap: () {
                    if(updateUser() == false) {
                      return;
                    }
                    toNext();
                  },
                  fontSize: w*h*0.1,
                ),
              ],
            ),
          SizedBox(height: 4*h,),
          ],
        )
      )
    );
  }

  Widget titleSection(double w,double h) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(0.8*w),
            child: Text (
              StringsQualifications.appsubHeadingTitle,
              style: TextStyle (
                fontSize: w*h*0.2
              ),
          ),
        ),
      ],
    );
  }
}

class TextMonitorWidget extends StatefulWidget {
  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
  Column column =  Column(children: [],);
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
    widget.column.children.add(const SizedBox(height: 4,));
    widget.column.children.add(_buildInstitutionField(widget.institutionC));
    widget.column.children.add(const SizedBox(height: 8,));
    widget.column.children.add(_buildQualificationField(widget.qualificationC));
    widget.column.children.add(_buildGraduationField());
  }

  Widget _buildInstitutionField(TextEditingController controller) {
    return Container (
      constraints: BoxConstraints.tight(const Size(550,70)),
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
            return 'This field is required';
          }
          return null;
        },
      )
    );
  }

  Widget _buildQualificationField(TextEditingController controller) {
    return Container (
      constraints: BoxConstraints.tight(const Size(550,70)),
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
            return 'This field is required';
          }
          return null;
        },
      )
    );
  }

  Widget _buildGraduationField() {
    return Container (
      width: 100,
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: Row(
        children: [
          Expanded(
            child: DateTimeFormField(
              initialValue: widget.start,
              onDateSelected: (value) {
                widget.start = value;
              },
              key: const Key("Start date input"),
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
              key: const Key("End date input"),
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