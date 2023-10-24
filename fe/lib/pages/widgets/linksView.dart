import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import '../elements/elements.dart';

class LinksTest extends StatefulWidget {
  TextEditingController urlC = TextEditingController();
  LinksTest({super.key, required this.urlC});

  @override
  State<StatefulWidget> createState() => LinksTestState();

}

class LinksTestState extends State<LinksTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: LinksField(urlC: TextEditingController()),
    );
  }
}

class LinksSection extends StatefulWidget {
  final List<Link> links;
  const LinksSection({super.key, required this.links});

  @override
  LinksSectionState createState() => LinksSectionState();
}

class LinksSectionState extends State<LinksSection> {
  final blankLink = Link(url: '', linkid: 0);
  Map linksMap = {};
  bool editing = false;

  @override
  void initState() {
    for (var element in widget.links) {
      display(element);
     }
    super.initState();
  }

  void display(Link info) {
    TextEditingController urlC = TextEditingController();

    urlC.text = info.url;

    linksMap[info.linkid] = {
      'url': urlC,
      'linkid': info.linkid,
    };

    linksMap[info.linkid]['widget'] = (
      Column(
        children: [
          const SizedBox(height: 4,),
          LinksField(urlC: linksMap[info.linkid]['url']),
          const SizedBox(height: 4,),
        ],
      )
    );
  }

  void add() {
    UserApi.AddLink(link: blankLink).then((value) {
      Link newLink = getCorrect(value!)!;
      print(newLink.linkid);
      display(newLink);
      setState(() {});
    });
  }

  void remove(int objectId) async {
    Link? oldLink = getLink(objectId);
    if(oldLink == null) {
      return;
    }
    UserApi.RemoveLink(link: oldLink);
    linksMap.remove(objectId);
    setState(() {});
  }

  void update() async {
    linksMap.forEach((key, value) {
    Link? updatedLink = getLink(key);
      if(updatedLink != null) {
        UserApi.UpdateLink(link: updatedLink);
      }
    });
  }

  List<Widget> populate() {
    List<Widget> linkWidgets = [];
    if (linksMap.isEmpty) {
      linkWidgets.add(
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.link,color: Colors.grey,size: 100,),
              SizedBox(height: 20),
              Text(
                "No Links...", 
                style: TextStyle(
                  color: Colors.grey
                )
              )
            ],
          ),
        )
      );
    }
    linksMap.forEach((key, value) {
      linkWidgets.add(linksMap[key]['widget']);
      if(editing == true) {
        linkWidgets.add(
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              
              onPressed: () {
                remove(key);
                if(linksMap.isEmpty == true) {
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
  
  Link? getCorrect(List<Link> list) {
    for(var i = 0; i <= list.length-1; i++) {
      if(linksMap.containsKey(list[i].linkid) == false) {
        return list[i];
      }
    }
    return null;
  }

  Link? getLink(int objectId) {
    if(linksMap.containsKey(objectId) == false) {
      return null;
    }

    Link newLink = Link(
      linkid: linksMap[objectId]['linkid'],
      url: linksMap[objectId]['url'].text,
    );
    return newLink;
  }

  edit() {
    if(linksMap.isEmpty == true) {
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
              }, icon: const Icon(Icons.add)),
              IconButton(
                color: const Color(0xFF333C64),
                onPressed: () {
                  edit();
              }, icon: const Icon(Icons.edit)),
            ],
            children: [
              SectionHeading(text: "LINKS",),
            ],
          ),
          const SizedBox(height: 16,),
          ...populate(),
        ]
      )
    );
  }
}

class LinksField extends StatefulWidget {
  final TextEditingController urlC;
  const LinksField({super.key, required this.urlC});

  @override
  LinksFieldState createState() => LinksFieldState();
}

class LinksFieldState extends State<LinksField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
      key: const Key("url"),
      controller: widget.urlC,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        hintText: "URL",
        border: OutlineInputBorder(),),
      ),
    );
  }
}