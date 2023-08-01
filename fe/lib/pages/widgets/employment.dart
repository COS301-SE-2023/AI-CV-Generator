// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/pages/widgets/description.dart';
import 'package:ai_cv_generator/pages/widgets/qualifications.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:date_field/date_field.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

// void main () => runApp(const EmploymentDetails());

class EmploymentDetailsForm extends StatefulWidget {
  const EmploymentDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmploymentDetailsFormState();
  }
}

class _EmploymentDetailsFormState extends State<EmploymentDetailsForm> {
  // final _formKey = GlobalKey<FormState>();
    Column column = Column(children: [],);

  @override
  void initState() {
    if(Home.adjustedModel!.employmenthistory == null) {
      add();
      return;
    }
    for(int i = 0; i < Home.adjustedModel!.employmenthistory!.length; i++) {
      Employment employmenthistory = Home.adjustedModel!.employmenthistory![i];
      UniqueKey key = UniqueKey();
      column.children.add(TextMonitorWidget(key: key, company: employmenthistory.company, title: employmenthistory.title, start: employmenthistory.startdate, end: employmenthistory.enddate));
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
      Home.adjustedModel!.employmenthistory = [];
      for (var element in column.children) {
        if((element is TextMonitorWidget) == true) {
          Map data = (element as TextMonitorWidget).getdata();
          if(isDataNull(data.values) == false) {
            Home.adjustedModel!.employmenthistory!.add(Employment(title: data['title'].toString(), company: data['company'].toString(), startdate: data['start'], empid: 0, enddate: data['end']));
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

  TextEditingController company1 = TextEditingController();
  TextEditingController jobTitle1 = TextEditingController();
  TextEditingController company2 = TextEditingController();
  TextEditingController jobTitle2 = TextEditingController();
  TextEditingController duration1 = TextEditingController();
  
    Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsEmployment.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
      ],
    );

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
            Navigator.popUntil(context, ModalRoute.withName('/home'));
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
                      updateUser();
                      Navigator.of(context).pop();
                      showQuestionaireModal(context, const QualificationsDetailsForm());
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
                      Navigator.pop(context);
                      showQuestionaireModal(context, const DescriptionForm());
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

}

class TextMonitorWidget extends StatefulWidget {
  Column column = Column(children: [],);
  TextEditingController companyC = TextEditingController();
  TextEditingController titleC = TextEditingController();
  String? company = "";
  String? title= "";
  DateTime? start;
  DateTime? end;
  TextMonitorWidget({super.key, this.company, this.title, this.start, this.end});

  getdata() {
    return {
      "company": companyC.text,
      "title": titleC.text,
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
    widget.companyC.text = widget.company != null ? widget.company! : "";
    widget.titleC.text = widget.title != null ? widget.title! : "";
    super.initState();
  }

  populate() {
    widget.column.children.add(_buildCompanyField(widget.companyC));
    widget.column.children.add(_buildJobTitleField(widget.titleC));
    widget.column.children.add(_buildEmploymentDurationField());
  }
  Widget _buildCompanyField(TextEditingController controller) {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Company input"),
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Company',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.work),
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
  
  Widget _buildJobTitleField(TextEditingController controller) {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Job Title input"),
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Job Title',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.person),
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

  Widget _buildEmploymentDurationField() {
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
              key: const Key("Employment start"),
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
              key: const Key("Employment end"),
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