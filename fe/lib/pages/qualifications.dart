// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/employment.dart';
import 'package:ai_cv_generator/pages/navdrawer.dart';
import 'package:ai_cv_generator/pages/personaldetails.dart';
import 'package:ai_cv_generator/pages/questionaireModal.dart';
import 'package:ai_cv_generator/pages/strings.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class QualificationsDetailsForm extends StatefulWidget {
  const QualificationsDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QualificationsDetailsFormState();
  }
}

class _QualificationsDetailsFormState extends State<QualificationsDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  Map data = {};
  Column column = Column(children: [],);

  @override
  void initState() {
    add();
    super.initState();
  }

  populate() {
    return column;
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

  getData() {
    column.children.forEach((element) {
      print((element as TextMonitorWidget).getdata());
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
                  ...populate().children
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
                      showQuestionaireModal(context, PersonalDetails());
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
                      Navigator.of(context).pop();
                      showQuestionaireModal(context, EmploymentDetailsForm());
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
  TextEditingController qualificationC= TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextMonitorWidget({super.key,});

  getdata() {
    return {
      "institution": institutionC.text,
      "qualification": qualificationC.text,
      "date": dateC.text
    };
  }

  @override
  TextMonitorWidgetState createState() => TextMonitorWidgetState();
}

class TextMonitorWidgetState extends State<TextMonitorWidget> {
  TextEditingController displayDateC = TextEditingController();
  @override
  void initState() {
    displayDateC.text = displayDateTimeRange(stringToDateTimeRange(widget.dateC.text));
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
    // datePicker(context).then((value) {
    //   if(value != null) {
    //     widget.dateC.text = dateTimeToString(value.start, value.end);
    //     displayDateC.text = displayDateTimeRange(value);
    //   }
    // });
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: DateTimeFormField(
        key: const Key("Graduation input"),
        //controller: _timeController1,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Date Obtained',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.date_range),
        ),
        mode: DateTimeFieldPickerMode.date,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    populate();
    return widget.column;
  }
}

String dateTimeToString(DateTime start, DateTime end) {
  return "$start/$end";
}

DateTimeRange stringToDateTimeRange(String text) {
  List<String> dates = text.split('/');
  return DateTimeRange(start: DateTime.parse(dates[0]), end: DateTime.parse(dates[1]));
}

String displayDateTimeRange(DateTimeRange dateTimeRange) {
  return "${dateTimeRange.start.year} - ${dateTimeRange.end.year}";
}

Future<DateTimeRange?> datePicker(BuildContext context) async {
  return showDateRangePicker(
      context: context, 
      firstDate: DateTime.now().subtract(const Duration(days:365*100)),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.input,
    );
}