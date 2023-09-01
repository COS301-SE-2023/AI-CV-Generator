import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Reference.dart';
import '../elements/elements.dart';

class ReferenceSection extends StatefulWidget {
  final List<Reference> reference;
  const ReferenceSection({super.key, required this.reference});

  @override
  ReferenceSectionState createState() => ReferenceSectionState();
}

class ReferenceSectionState extends State<ReferenceSection> {
  final blankReference = Reference(description: '', contact: '', refid: 0,);
  Map referenceMap = {};
  bool editing = false;

  @override
  void initState() {
    print(widget.reference.length);
    for (var element in widget.reference) {
      display(element);
     }
    super.initState();
  }

  void display(Reference info) {
    TextEditingController descriptionC = TextEditingController();
    TextEditingController contactC = TextEditingController();

    descriptionC.text = info.description;
    contactC.text = info.contact;

    referenceMap[info.refid] = {
      'refid': info.refid,
      'description': descriptionC,
      'contact': contactC,
    };
    referenceMap[info.refid]['widget'] = (
      Column(
        children: [
          const SizedBox(height: 4,),
          ReferenceField(
            descriptionC: referenceMap[info.refid]['description'],
            contactC: referenceMap[info.refid]['contact'],
            ),
          const SizedBox(height: 4,),
        ],
      )
    );
  }

  void add() {
    userApi.addReference(reference: blankReference).then((value) {
      Reference newReference = getCorrect(value!)!;
      print(newReference.refid);
      display(newReference);
      setState(() {});
    });
  }

  void remove(int objectId) async {
    Reference? oldReference = getReference(objectId);
    if(oldReference == null) {
      return;
    }
    userApi.removeReference(reference: oldReference);
    referenceMap.remove(objectId);
    setState(() {});
  }

  void update() async {
    referenceMap.forEach((key, value) {
    Reference? updatedReference = getReference(key);
      if(updatedReference != null) {
        userApi.updateReference(reference: updatedReference);
      }
    });
  }

  Reference? getReference(int objectId) {
    if(referenceMap.containsKey(objectId) == false) {
      return null;
    }

    Reference newReference = Reference(
      description: referenceMap[objectId]['description'].text,
      contact: referenceMap[objectId]['contact'].text,
      refid: referenceMap[objectId]['refid'],
    );
    return newReference;
  }

  Reference? getCorrect(List<Reference> list) {
    for(var i = 0; i <= list.length-1; i++) {
      if(referenceMap.containsKey(list[i].refid) == false) {
        return list[i];
      }
    }
    return null;
  }

  List<Widget> populate() {
    List<Widget> linkWidgets = [];
    referenceMap.forEach((key, value) {
      linkWidgets.add(referenceMap[key]['widget']);
      if(editing == true) {
        linkWidgets.add(
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              
              onPressed: (){
                remove(key);
                if(referenceMap.isEmpty == true) {
                  editing = false;
                }
              }, 
              icon: const Icon(Icons.delete)),
          ),
        );
        linkWidgets.add(const SizedBox(height: 4,),);
      }
    });
    return linkWidgets;
  }

  edit() {
    if(referenceMap.isEmpty == true) {
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
              }, icon: const Icon(Icons.add)),
              IconButton(
                color: const Color(0xFF333C64),
                onPressed: () {
                  edit();
              }, icon: const Icon(Icons.edit)),
            ],
            children: [
              SectionHeading(text: "REFERENCES",),
            ],
          ),
          const SizedBox(height: 16,),
          ...populate(),
        ]
      )
    );
  }
}

class ReferenceField extends StatefulWidget {
  final TextEditingController descriptionC;
  final TextEditingController contactC;
  const ReferenceField({super.key, required this.descriptionC, required this.contactC});

  @override
  ReferenceFieldState createState() => ReferenceFieldState();
}

class ReferenceFieldState extends State<ReferenceField> {
  TextEditingController displayDateC = TextEditingController();
  @override
void initState() {
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        children: [
            TextFormField(
            style: const TextStyle(fontSize: 20),
            controller: widget.descriptionC,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: "REFERENCE DESCRIPTION",
              border: InputBorder.none
              ),
            ),
            const SizedBox(width: 8,),
            TextFormField(
            // style: TextStyle(fontSize: 5),
            controller: widget.contactC,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: "CONTACT INFORMATION",
              hintStyle: TextStyle(fontSize: 15),
              border: InputBorder.none
              ),
            ),
            const SizedBox(width: 8,),
          ],
      )
    );
  }
}
