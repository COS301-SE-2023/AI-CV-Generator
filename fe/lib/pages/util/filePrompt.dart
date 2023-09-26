
import 'package:ai_cv_generator/pages/screens/underContruction.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilePrompt extends StatefulWidget {
  FilePrompt({
    super.key, 
    required this.file
  });
  PlatformFile file;
  
  @override
  State<StatefulWidget> createState() => FilePromptState();
}

class FilePromptState extends State<FilePrompt> {
  @override
  Widget build(BuildContext context) {
    return const UnderContruction();
  }

}