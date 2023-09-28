// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/qualifications.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/referencesForm.dart';
import 'package:date_field/date_field.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:flutter/material.dart';

class EmploymentDetailsFormTest extends StatefulWidget {
  EmploymentDetailsFormTest({super.key});

  @override
  State<StatefulWidget> createState() => EmploymentDetailsFormTestState();
}

class EmploymentDetailsFormTestState extends State<EmploymentDetailsFormTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: EmploymentDetailsForm(),
    );
  }
}

class EmploymentDetailsForm extends StatefulWidget {
  const EmploymentDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmploymentDetailsFormState();
  }
}

class _EmploymentDetailsFormState extends State<EmploymentDetailsForm> {
  final _formKey = GlobalKey<FormState>();
    // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
    Column column =  Column(children: [],);

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

  add() async {
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

  TextEditingController company1 = TextEditingController();
  TextEditingController jobTitle1 = TextEditingController();
  TextEditingController company2 = TextEditingController();
  TextEditingController jobTitle2 = TextEditingController();
  TextEditingController duration1 = TextEditingController();


    back() {
      Navigator.of(context).pop();
      showQuestionaireModal(context, const QualificationsDetailsForm());
    }

    toNext() {
      Navigator.pop(context);
      showQuestionaireModal(context, const ReferencesDetailsForm());
    }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
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
                      Icon(Icons.cases_rounded,color: Colors.grey,size: w*h*1,),
                      SizedBox(height: h*2),
                      Text(
                        "No Work Experience...", 
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: w*h*0.15
                        )
                      )
                    ],
                  ),
                )
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container ( 
                padding: const EdgeInsets.all(20.0),
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
                SizedBox(width: 6.4*w,),
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
              StringsEmployment.appsubHeadingTitle,
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
    widget.column.children.add( const SizedBox(height: 4,));
    widget.column.children.add(_buildCompanyField(widget.companyC));
    widget.column.children.add( const SizedBox(height: 8,));
    widget.column.children.add(_buildJobTitleField(widget.titleC));
    widget.column.children.add(_buildEmploymentDurationField());
  }

  Widget _buildCompanyField(TextEditingController controller) {
    return Container (
      constraints: BoxConstraints.tight( const Size(550,70)),
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
      constraints: BoxConstraints.tight( const Size(550,70)),
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
      constraints: BoxConstraints.tight(const Size(550,70)),
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