
import 'package:ai_cv_generator/pages/inputField.dart';
import 'package:flutter/material.dart';

class InputArray extends StatefulWidget {
  List<String>? inputs;
  TextEditingController editor;
  InputArray({super.key, 
    required this.editor
  });

  @override
  State<StatefulWidget> createState() => InputArrayState();
}

class InputArrayState extends State<InputArray> {
  @override
  Widget build(Object context) {
    List<String> inputs = widget.inputs != null ? widget.inputs! : [];
    
    List<TextEditingController> editors = [];
    for (int n=0; n <inputs.length; n++) {
      editors.add(TextEditingController(text: inputs[n]));
      editors[n].addListener(() { 
        widget.editor.notifyListeners();
      });
    }
    return Scaffold(
      body: Column(
        children: [...editors.map((e) => Column(children: [InputField_(editor: e,label: ""),const SizedBox(height: 8,)]))]
      ),
    );
  }

}