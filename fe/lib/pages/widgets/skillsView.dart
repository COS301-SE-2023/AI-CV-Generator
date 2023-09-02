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
      linkWidgets.add(
        CreateRow(
          skillMap[key]['skill'].text,
          skillMap[key]['reason'].text, 
          int.parse(skillMap[key]['level'].text),
          key
        )
      );
    });
    return createTable(linkWidgets);
  }

  TableRow CreateRow(String skill, String reason, int level, key)
  {
    return TableRow(
      children: <Widget>[
        CreateCell(Text(skill)),
        CreateCell(Text(reason)),
        CreateCell(Text(level.toString())),
        if(editing == true)
          CreateCell(
            IconButton(
              onPressed: () {
                remove(key);
                if(skillMap.isEmpty == true) {
                  editing = false;
                }
              },
            icon: const Icon(Icons.delete)),
          )
      ],
    );
  }

  TableCell CreateCell(Widget content)
  {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        child: content,
        padding: EdgeInsets.all(8.0),
      )
    );
  }

  Table createTable(linkWidgets) {
    return Table(
        border: TableBorder.all(
          borderRadius:BorderRadius.all(Radius.circular(10)),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              CreateCell(Text("SKILL")),
              CreateCell(Text("EXPERIENCE")),
              CreateCell(Text("LEVEL")),
              if(editing == true)
                CreateCell(Text("REMOVE"))
            ],
          ),
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