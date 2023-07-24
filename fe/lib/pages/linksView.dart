import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'elements/elements.dart';

class LinksSection extends StatefulWidget {
  List<Link> links;
  LinksSection({super.key, required this.links});

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
          SizedBox(height: 4,),
          LinksField(urlC: linksMap[info.linkid]['url']),
          SizedBox(height: 4,),
        ],
      )
    );
  }

  void add() {
    userApi.AddLink(link: blankLink).then((value) {
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
    userApi.RemoveLink(link: oldLink);
    linksMap.remove(objectId);
    setState(() {});
  }

  void update() async {
    linksMap.forEach((key, value) {
    Link? updatedLink = getLink(key);
      if(updatedLink != null) {
        userApi.UpdateLink(link: updatedLink);
      }
    });
  }

  List<Widget> populate() {
    List<Widget> linkWidgets = [];
    linksMap.forEach((key, value) {
      linkWidgets.add(linksMap[key]['widget']);
      if(editing == true) {
        linkWidgets.add(
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: (){
                remove(key);
              }, 
              icon: Icon(Icons.remove)),
          ),
        );
        linkWidgets.add(SizedBox(height: 4,),);
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
            children: [
              SectionHeading(text: "LINKS",),
            ],
            actions: [
              IconButton(onPressed: () {
                if(editing == false) {
                  add();
                }
              }, icon: Icon(Icons.add)),
              IconButton(onPressed: () {
                  edit();
              }, icon: Icon(Icons.edit)),
            ],
          ),
          SizedBox(height: 16,),
          ...populate(),
        ]
      )
    );
  }
}

class LinksField extends StatefulWidget {
  TextEditingController urlC;
  LinksField({super.key, required this.urlC});

  @override
  LinksFieldState createState() => LinksFieldState();
}

class LinksFieldState extends State<LinksField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
      controller: widget.urlC,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "URL",
        border: OutlineInputBorder(),),
      ),
    );
  }
}