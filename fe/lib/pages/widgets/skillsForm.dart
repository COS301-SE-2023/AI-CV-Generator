// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/description.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/referencesForm.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';

class SkillsDetailsFormTest extends StatefulWidget{
  SkillsDetailsFormTest({super.key});

  @override
  State<StatefulWidget> createState() => SkillsDetailsFormTestState();
}

class SkillsDetailsFormTestState extends State<SkillsDetailsFormTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SkillsDetailsForm(),
    );
  }
}

class SkillsDetailsForm extends StatefulWidget {
  const SkillsDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SkillsDetailsFormState();
  }
}

class _SkillsDetailsFormState extends State<SkillsDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
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

  back() {
    Navigator.of(context).pop();
    showQuestionaireModal(context, const ReferencesDetailsForm());
  }

  toNext() {
    Navigator.of(context).pop();
    showQuestionaireModal(context, const DescriptionForm());
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
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListView(
                    children: [
                      ...column.children
                    ],
                  ) 
                ):  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flag,color: Colors.grey,size: w*h*1,),
                      SizedBox(height: h*2),
                      Text(
                        "No Skills...", 
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
              StringsSkill.appsubHeadingTitle,
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
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: TextFormField(
        key: const Key("skill input"),
        controller: controller,
        decoration: const InputDecoration(
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
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: TextFormField(
        key: const Key("reason input"),
        controller: controller,
        decoration: const InputDecoration(
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
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: DropdownButton<String>(
        key: const Key("level input"),
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
          const SizedBox(width: 24,),
          Expanded(flex: 2, child:_buildskillField(widget.skillC)),
          const SizedBox(width: 8,),
          Expanded(flex: 2, child: _buildreasonField(widget.reasonC),),
          const SizedBox(width: 8,),
          Expanded(flex: 1, child:_buildlevelField(widget.levelC)),
          const SizedBox(width: 24,)
        ],
      ),
    );
  }
}