import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Skill.dart';
import '../elements/elements.dart';

class SkillSection extends StatefulWidget {
  final List<Skill> skill;
  const SkillSection({super.key, required this.skill});

  @override
  SkillSectionState createState() => SkillSectionState();
}

class SkillSectionState extends State<SkillSection> {
  final blankSkill = Skill(skill: '', reason: '', level: 0, skillid: 0,);
  Map skillMap = {};
  List<Map> institution = [];
  bool editing = false;

  @override
  void initState() {
    for (var element in widget.skill) {
      display(element);
     }
    super.initState();
  }

  void display(Skill info) {
    TextEditingController skillC = TextEditingController();
    TextEditingController reasonC = TextEditingController();
    TextEditingController levelC = TextEditingController();

    skillC.text = info.skill;
    reasonC.text = info.reason;
    levelC.text = info.level.toString();
    skillMap[info.skillid] = {
      'skillid': info.skillid,
      'skill': skillC,
      'reason': reasonC,
      'level': levelC,
    };
    skillMap[info.skillid]['widget'] = 
      SkillField(
            skillMap[info.skillid]['skill'],
            skillMap[info.skillid]['reason'],
            skillMap[info.skillid]['level'],
      
    );
  }

  List<Widget> SkillField(skill, reason, level) {
    List<Widget> tableCols = [
      Text("Cell 0"),
      Text("Cell 1"),
      Text("Cell 2"),
      // createInput(skill),
      // createInput(reason),
      // createInput(level),
    ];

    return tableCols;
  }

  Widget createInput(controller) {
    return Container(
      // color: isHeader ? Colors.grey[300] : Colors.white,
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Insert"
        ),
        controller: controller,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  void add() {
    userApi.addSkill(skill: blankSkill).then((value) {
      Skill newSkill = getCorrect(value!)!;
      display(newSkill);
      setState(() {});
    });
      // display(blankSkill);
      // setState(() {});
  }

  void remove(int objectId) async {
    Skill? oldSkill = getSkill(objectId);
    if(oldSkill == null) {
      return;
    }
    userApi.removeSkill(skill: oldSkill);
    skillMap.remove(objectId);
    setState(() {});
  }

  void update() async {
    skillMap.forEach((key, value) {
    Skill? updatedSkill = getSkill(key);
      if(updatedSkill != null) {
        userApi.updateSkill(skill: updatedSkill);
      }
    });
  }

  Skill? getSkill(int objectId) {
    if(skillMap.containsKey(objectId) == false) {
      return null;
    }

    Skill newSkill = Skill(
      skill: skillMap[objectId]['skill'].text,
      reason: skillMap[objectId]['reason'].text,
      level:  int.parse(skillMap[objectId]['level'].text),
      skillid: skillMap[objectId]['skillid'],
    );
    return newSkill;
  }

  Skill? getCorrect(List<Skill> list) {
    for(var i = 0; i <= list.length-1; i++) {
      if(skillMap.containsKey(list[i].skillid) == false) {
        return list[i];
      }
    }
    return null;
  }

  Table populate() {
    List<TableRow> linkWidgets = [];
    skillMap.forEach((key, value) {
      linkWidgets.add(TableRow(
        children: [
          ...skillMap[key]['widget']
        ]
      ));
      if(editing == true) {
          linkWidgets.add(TableRow(
        children: [
          ...skillMap[key]['widget'],
          IconButton(
            onPressed: () {
              remove(key);
              if(skillMap.isEmpty == true) {
                editing = false;
              }
            },
          icon: const Icon(Icons.delete)),
        ]
      ));
      }
    });
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(children: [
          Text("Skill"),
          Text("Level"),
          Text("Qualifications/Experience"),
        ]),
        ...linkWidgets
      ],
    );
  }

  Table createTable(linkWidgets, editing) {
  return Table(
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            Text("Skill"),
            Text("Level"),
            Text("Qualifications/Experience"),
          ]),
          ...linkWidgets
        ],
    );
  }

  edit() {
    if(skillMap.isEmpty == true) {
      return;
    }
    setState(() {
      editing = !editing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        children: [
          SectionHeadingBar(
            actions: [
              IconButton(
                color: const Color(0xFF333C64),
                onPressed: () {
                if(editing == false) {
                  add();
                }
              }, icon: const Icon(Icons.add,)),
              IconButton(
                color: const Color(0xFF333C64),
                onPressed: () {
                  edit();
              }, icon: const Icon(Icons.edit)),
            ],
            children: [
              SectionHeading(text: "SKILLS",),
            ],
          ),
          const SizedBox(height: 16,),
          populate(),
        ]
      )
    );
  }
}