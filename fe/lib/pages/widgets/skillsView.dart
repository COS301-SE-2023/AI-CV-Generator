import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/pages/elements/elements.dart';

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

  Widget createInput(controller, hintText) {
    return Container(
      alignment: Alignment.center,
      // color: isHeader ? Colors.grey[300] : Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: 50,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
          border: InputBorder.none
        ),
        controller: controller,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  void add() {
    UserApi.addSkill(skill: blankSkill).then((value) {
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
    UserApi.removeSkill(skill: oldSkill);
    skillMap.remove(objectId);
    setState(() {});
  }

  void update() async {
    skillMap.forEach((key, value) {
    Skill? updatedSkill = getSkill(key);
      if(updatedSkill != null) {
        UserApi.updateSkill(skill: updatedSkill);
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

  Widget populate() {
    List<TableRow> linkWidgets = [];
    if (skillMap.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flag,color: Colors.grey,size: 100,),
            SizedBox(height: 20),
            Text(
              "No Skills...", 
              style: TextStyle(
                color: Colors.grey
              )
            )
          ],
        ),
      );
    }
    skillMap.forEach((key, value) {
      linkWidgets.add(
        CreateRow(
          skillMap[key]['skill'],
          skillMap[key]['reason'], 
          skillMap[key]['level'],
          key
        )
      );
    });
    return createTable(linkWidgets);
  }

  final List<String> _dropdownItems = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5'
  ];

  TableRow CreateRow(skill, reason, level, key)
  {
    return TableRow(
      children: <Widget>[
        CreateCell(createInput(skill, "INSERT SKILL")),
        CreateCell(createInput(reason, "INSERT EXPERIENCE")),
        CreateCell(
            DropdownButton<String>(
              value: level.text,
              onChanged: (String? newValue) {
                level.text = newValue;
                setState(() {});
              },
              items: _dropdownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          ),
        ),
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
        padding: const EdgeInsets.all(8.0),
        child: content,
      )
    );
  }

  Table createTable(linkWidgets) {
    return Table(
        border: TableBorder.all(
          width: 0.5,
          borderRadius:const BorderRadius.all(Radius.circular(5)),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              CreateCell(const Text("SKILL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
              CreateCell(const Text("EXPERIENCE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),),
              CreateCell(const Text("LEVEL (0-5)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
              if(editing == true)
                CreateCell(const Text("REMOVE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),))
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
    Color addCol = const Color(0xFF333C64);
    if (editing) {
      addCol = const Color.fromARGB(255, 141, 142, 145);
    }
    return SectionContainer(
      child: Column(
        children: [
          SectionHeadingBar(
            actions: [
              IconButton(
                color: addCol,
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