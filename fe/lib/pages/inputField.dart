import 'package:ai_cv_generator/pages/profile.dart';
import 'package:flutter/material.dart';

class inputField extends StatefulWidget {
  TextEditingController editor;
  String? text;
  String label;
  inputField({super.key, 
    required this.editor,
    required this.label
  });
  @override
  State<StatefulWidget> createState() => _inputFieldState();

}

class _inputFieldState extends State<inputField> {

  @override
  Widget build(BuildContext context) {
    TextEditingController editor = widget.editor;
    //editor.text = widget.text != null ? widget.text!:"";
    return InputField(label: widget.label, widgetField: TextFormField(
      autocorrect: true,
      controller: editor,
      onEditingComplete: () {
        editor.notifyListeners();
      },
    ));
  }
}