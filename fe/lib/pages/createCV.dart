import 'package:flutter/material.dart';
import 'text.dart';
// Left side is imported cv data that can be edited
// Right side is generated cv data that can also be edited
//side by side for comparison
//must include buttons upload cv and generate cv
//upload cv button will populate text area on left
//generate cv button will populate text area on right
final leftPaneKey = GlobalKey<TextSpaceState>();
final rightPaneKey = GlobalKey<TextSpaceState>();


class CreateCV extends StatelessWidget {
  const CreateCV({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
          children: [
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {leftPaneKey.currentState?.textEditorController.text = userText;}, 
                  child: const Text("Upload")
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {rightPaneKey.currentState?.textEditorController.text = aiText;}, 
                  child: const Text("Generate CV")
                ),
              ]
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: TextSpace(leftPaneKey)),
                  const SizedBox(width: 50),
                  Expanded(child: TextSpace(rightPaneKey)),
                ],
              ),
            ),
          ],
        ),
          ),
      ),
    );
  }
}

class TextSpace extends StatefulWidget {
  const TextSpace(Key key): super(key: key);
  @override
  TextSpaceState createState() => TextSpaceState();
}

class TextSpaceState extends State<TextSpace> {
  var textEditorController = TextEditingController();

  String populateField() {
    var t = "";
    for(var i = 0; i < 4000; i++) {
      t += "0";
    }
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        controller: textEditorController,
        maxLines: 99999,
      )
    );
  }
}