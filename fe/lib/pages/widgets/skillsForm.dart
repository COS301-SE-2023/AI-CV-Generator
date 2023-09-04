// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/pages/widgets/description.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/referencesForm.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

class SkillsDetailsForm extends StatefulWidget {
   SkillsDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SkillsDetailsFormState();
  }
}

class _SkillsDetailsFormState extends State<SkillsDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  Column column =  Column(children: [],);

  @override
  void initState() {
    if(Home.adjustedModel!.skills == null) {
      add();
      return;
    }
    for(int i = 0; i < Home.adjustedModel!.skills!.length; i++) {
      Skill skills = Home.adjustedModel!.skills![i];
      UniqueKey key = UniqueKey();
      column.children.add(TextMonitorWidget(key: key, skill: skills.skill, reason: skills.reason, level: skills.level,));
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
    Home.adjustedModel!.skills = [];
    for (var element in column.children) {
      if((element is TextMonitorWidget) == true) {
        Map data = (element as TextMonitorWidget).getdata();
        if(isDataNull(data.values) == false) {
          Home.adjustedModel!.skills!.add(Skill(reason: data['reason'].toString(), skill: data['skill'].toString(), level: data['level'],  skillid: 0,));
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
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: ListView(
                    children: [
                      ...column.children
                    ],
                  ) 
                ):  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.build,color: Colors.grey,size: 100,),
                      SizedBox(height: 20),
                      Text(
                        "No Skills...", 
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
                      showQuestionaireModal(context,  ReferencesDetailsForm());
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
                      showQuestionaireModal(context,  DescriptionForm());
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

  Widget titleSection = Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsSkill.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
      ],
    );
}

class TextMonitorWidget extends StatefulWidget {
  Row row =  Row(children: [],);
  TextEditingController skillC = TextEditingController();
  TextEditingController reasonC = TextEditingController();
  TextEditingController levelC = TextEditingController();
  String? skill = "";
  String? reason = "";
  int? level = 0;
  TextMonitorWidget({super.key, this.skill, this.reason, this.level,});

  getdata() {
    return {
      "skill": skillC.text,
      "reason": reasonC.text,
      "level": int.parse(levelC.text),
    };
  }

  @override
  TextMonitorWidgetState createState() => TextMonitorWidgetState();
}

class TextMonitorWidgetState extends State<TextMonitorWidget> {
  final List<String> _dropdownItems = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5'
  ];
  @override
  void initState() {
    widget.skillC.text = widget.skill != null ? widget.skill! : "";
    widget.reasonC.text = widget.reason != null ? widget.reason! : "";
    widget.levelC.text = widget.reason != null ? widget.level!.toString() : "0";
    widget.levelC.addListener(() {setState(() {});});
    super.initState();
  }

  Widget _buildskillField(TextEditingController controller) {
    return Container (
      constraints: BoxConstraints.tight( Size(550,70)),
      child: TextFormField(
        key:  Key("skill input"),
        controller: controller,
        decoration:  InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Skill',
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

  Widget _buildreasonField(TextEditingController controller) {
    return Container (
      constraints: BoxConstraints.tight( Size(550,70)),
      child: TextFormField(
        key:  Key("reason input"),
        controller: controller,
        decoration:  InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Reason',
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

  _buildlevelField(TextEditingController level) {
    return Container (
      alignment: Alignment.topCenter,
      constraints: BoxConstraints.tight(Size(550,70)),
      child: DropdownButton<String>(
        value: level.text,
        onChanged: (String? newValue) {
          setState(() {level.text = newValue!;});
        },
        items: _dropdownItems.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 90,
      width: 10,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 24,),
          Expanded(flex: 2, child:_buildskillField(widget.skillC)),
          SizedBox(width: 8,),
          Expanded(flex: 2, child: _buildreasonField(widget.reasonC),),
          SizedBox(width: 8,),
          Expanded(flex: 1, child:_buildlevelField(widget.levelC)),
          SizedBox(width: 24,)
        ],
      ),
    );
  }
}