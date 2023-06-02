
import 'package:ai_cv_generator/pages/inputField.dart';
import 'package:flutter/material.dart';

class inputArray extends StatefulWidget {
  List<String>? inputs;
  TextEditingController editor;
  inputArray({
    required this.editor
  });

  @override
  State<StatefulWidget> createState() => _inputArrayState();
}

class _inputArrayState extends State<inputArray> {
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
        children: [...editors.map((e) => inputField(editor: e,label: "",text: e.text,))]
      ),
    );
  }

}