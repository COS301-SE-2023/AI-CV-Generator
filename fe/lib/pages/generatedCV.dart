import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class generatedCV extends StatefulWidget {
  const generatedCV({super.key});

  @override
  _generatedCVState createState() => _generatedCVState();
}

class _generatedCVState extends State<generatedCV> {

  Map data = {};
  void _pick_cvfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Generated CV stub"),
      )
    );
  }
}