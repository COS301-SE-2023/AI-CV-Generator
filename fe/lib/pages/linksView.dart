import 'package:flutter/material.dart';
import 'package:ai_cv_generator/models/user/Link.dart';

class LinksSection extends StatefulWidget {
  List<Link> links;
  LinksSection({super.key, required this.links});

  @override
  LinksSectionState createState() => LinksSectionState();
}

class LinksSectionState extends State<LinksSection> {
  Map linksMap = {};
  int id = 0;

  @override
  void initState() {
    widget.links.forEach((element) {
      print(element.url);
      add(element);
     }
    );
    super.initState();
  }

  int get_id() {
    return id++;
  }

  void add(Link info) {
    int linkId = get_id();
    TextEditingController urlC = TextEditingController();

    urlC.text = info.url;

    linksMap[linkId] = {
      'url': urlC,
      'linkid': info.linkid,
    };

    linksMap[linkId]['widget'] = (
      Column(
        children: [
          SizedBox(height: 16,),
          LinksField(urlC: linksMap[linkId]['url']),
          SizedBox(height: 16,),
          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton(
              onPressed: (){
                remove(linkId);
              }, 
              child: Text('-'),),
          )
        ],
      )
    );
  }

  void remove(int linkId) {
    print('removed:');
    print(linksMap[linkId]['url'].text);
    linksMap.remove(linkId);
    setState(() {});
  }

  List<Link> update() {
    List<Link> linkCol = [];
    linksMap.forEach((key, value) {
      linkCol.add(Link(url: linksMap[key]["url"].text, linkid: linksMap[key]["linkid"]));
    });
    return linkCol;
  }

  List<Widget> populate() {
    List<Widget> linkWidgets = [];
    linksMap.forEach((key, value) {
      linkWidgets.add(linksMap[key]['widget']);
    });
    return linkWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...populate(),
        SizedBox(height: 8,),
        OutlinedButton(onPressed: (){
          var newLink = Link(url: '', linkid: 0);
          widget.links.add(newLink);
          add(newLink);
          setState(() {});
        }, child: Text('+')),
        SizedBox(height: 16,),
      ],
    );
  }
}

class LinksField extends StatefulWidget {
  TextEditingController urlC;
  LinksField({required this.urlC});

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
        hintText: "Url",
        border: OutlineInputBorder(),),
      ),
    );
  }
}