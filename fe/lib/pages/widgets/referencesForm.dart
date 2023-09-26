// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/skillsForm.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';

class ReferencesDetailsFormTest extends StatefulWidget{
  ReferencesDetailsFormTest({super.key});

  @override
  State<StatefulWidget> createState() => ReferencesDetailsFormTestState();
}

class ReferencesDetailsFormTestState extends State<ReferencesDetailsFormTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ReferencesDetailsForm(),
    );
  }
}


class ReferencesDetailsForm extends StatefulWidget {
  const ReferencesDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReferencesDetailsFormState();
  }
}

class _ReferencesDetailsFormState extends State<ReferencesDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
  Column column =  Column(children: [],);

  @override
  void initState() {
    if(Home.adjustedModel!.references == null) {
      add();
      return;
    }
    for(int i = 0; i < Home.adjustedModel!.references!.length; i++) {
      Reference references = Home.adjustedModel!.references![i];
      UniqueKey key = UniqueKey();
      column.children.add(TextMonitorWidget(key: key, description: references.description, contact: references.contact,));
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

  bool updateUser() {
    Home.adjustedModel!.references = [];
    for (var element in column.children) {
      if((element is TextMonitorWidget) == true) {
        Map data = (element as TextMonitorWidget).getdata();
        if(isDataNull(data.values) == false) {
          Home.adjustedModel!.references!.add(Reference(contact: data['contact'].toString(), description: data['description'].toString(), refid: 0,));
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
    showQuestionaireModal(context, const EmploymentDetailsForm());
  }

  toNext() {
    Navigator.of(context).pop();
    showQuestionaireModal(context, const SkillsDetailsForm());
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
                ) :  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people,color: Colors.grey,size: w*h*1,),
                      SizedBox(height: h*2),
                      Text(
                        "No References...", 
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
              StringsReferences.appsubHeadingTitle,
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
  TextEditingController descriptionC = TextEditingController();
  TextEditingController contactC = TextEditingController();
  String? description = "";
  String? contact = "";
  TextMonitorWidget({super.key, this.description, this.contact});

  getdata() {
    return {
      "description": descriptionC.text,
      "contact": contactC.text,
    };
  }

  @override
  TextMonitorWidgetState createState() => TextMonitorWidgetState();
}

class TextMonitorWidgetState extends State<TextMonitorWidget> {
  @override
  void initState() {
    widget.descriptionC.text = widget.description != null ? widget.description! : "";
    widget.contactC.text = widget.contact != null ? widget.contact! : "";
    super.initState();
  }

  populate() {
    widget.column.children.add(const SizedBox(height: 4,));
    widget.column.children.add(_builddescriptionField(widget.descriptionC));
    widget.column.children.add(const SizedBox(height: 8,));
    widget.column.children.add(_buildcontactField(widget.contactC));
  }

  Widget _builddescriptionField(TextEditingController controller) {
    return Container (
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: TextFormField(
        key: const Key("description input"),
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Description',
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

  Widget _buildcontactField(TextEditingController controller) {
    return Container (
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: TextFormField(
        key: const Key("contact input"),
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Contact Information',
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

  @override
  Widget build(BuildContext context) {
    populate();
    return widget.column;
  }
}