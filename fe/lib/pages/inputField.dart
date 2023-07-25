import 'package:ai_cv_generator/pages/profile.dart';
import 'package:flutter/material.dart';

class InputField_ extends StatefulWidget {
  final TextEditingController editor;
  final String label;
  const InputField_({super.key, 
    required this.editor,
    required this.label
  });
  @override
  State<StatefulWidget> createState() => InputFieldState();

}

class InputFieldState extends State<InputField_> {

  @override
  Widget build(BuildContext context) {
    TextEditingController editor = widget.editor;
    return InputField(label: widget.label, widgetField: TextFormField(
      autocorrect: true,
      controller: editor,
      onEditingComplete: () {
        editor.notifyListeners();
      },
    ));
  }
}