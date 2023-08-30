import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Template extends StatefulWidget{

  Template({super.key});
  TemplateOption option = TemplateOption.templateA;

  Future<PlatformFile?> transform() async {
    return null;
  }

  void swap(TemplateOption option) {
    this.option = option;
    createState();
  }

  @override
  State<StatefulWidget> createState() => TemplateState();
}

enum TemplateOption {templateA,templateB,templateC}

class TemplateState extends State<Template> {
  late TemplateOption op;
  
   @override
  void initState() {
    super.initState();
    op = widget.option;
  }

  @override
  Widget build(BuildContext context) {
    switch (op) {
      case TemplateOption.templateA:
        return templateA();
      default:
        return templateA();
    }
  }


  Widget templateA() {
    return const SizedBox(height: 2,);
  }
}

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({super.key, required this.controller, this.fontSize, this.textAlign, this.color, this.maxLines});
  final TextEditingController controller;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;

  @override
  TextFieldInputState createState() => TextFieldInputState();
}

class TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      textAlign: widget.textAlign!,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize
      ),
      decoration: 
      const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none
      ),
    );
  }
}