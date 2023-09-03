// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/skillsForm.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

class ReferencesDetailsForm extends StatefulWidget {
   ReferencesDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReferencesDetailsFormState();
  }
}

class _ReferencesDetailsFormState extends State<ReferencesDetailsForm> {
  final _formKey = GlobalKey<FormState>();
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
          padding:  EdgeInsets.only(left: 500),
          child: IconButton(
            onPressed: () {
              remove(key);
            }, icon:  Icon(Icons.delete)
          ),
        )
      );
        column.children.add( SizedBox(height: 16,));
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
        padding:  EdgeInsets.only(left: 500),
        child: IconButton(
        onPressed: () {
          remove(key);
        }, icon:  Icon(Icons.delete)
      ),
      )
    );
    column.children.add( SizedBox(height: 16,));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon:  Icon(
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
                      Icon(Icons.people,color: Colors.grey,size: 100,),
                      SizedBox(height: 20),
                      Text(
                        "No References...", 
                        style: TextStyle(
                          color: Colors.grey
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
                padding:  EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child:  Text('Add'),
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
                    child:  Text('Back'),
                    onPressed: ()  {
                      updateUser();
                      Navigator.of(context).pop();
                      showQuestionaireModal(context,  EmploymentDetailsForm());
                    },
                  ),
                ),
                 SizedBox(width: 64,),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child:  Text('Save and Proceed'),
                    onPressed: () async {
                      if(updateUser() == false) {
                        return;
                      }
                      Navigator.of(context).pop();
                      showQuestionaireModal(context,  SkillsDetailsForm());
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

  Widget titleSection= Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsReferences.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
      ],
    );
}

class TextMonitorWidget extends StatefulWidget {
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
    widget.column.children.add( SizedBox(height: 4,));
    widget.column.children.add(_builddescriptionField(widget.descriptionC));
    widget.column.children.add( SizedBox(height: 8,));
    widget.column.children.add(_buildcontactField(widget.contactC));
  }

  Widget _builddescriptionField(TextEditingController controller) {
    return Container (
      constraints: BoxConstraints.tight( Size(550,70)),
      child: TextFormField(
        key:  Key("description input"),
        controller: controller,
        decoration:  InputDecoration(
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
      constraints: BoxConstraints.tight( Size(550,70)),
      child: TextFormField(
        key:  Key("contact input"),
        controller: controller,
        decoration:  InputDecoration(
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