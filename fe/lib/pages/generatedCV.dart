import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';


class generatedCV extends StatefulWidget {
  const generatedCV({super.key});

  @override
  _generatedCVState createState() => _generatedCVState();
}

class _generatedCVState extends State<generatedCV> {

  Map data = {};
  String value = '';

  void createCV() {
    // File file = File('details.txt');
    // data = json.decode(file.readAsStringSync());
    // String response = '';
    // data.forEach((key, value) {
    //   response += '$key' + '\n';
    //   response += '$value' + '\n\n';
    // });
    setState(() {
      value = File('details.txt').readAsStringSync();
      data = json.decode(File('content.json').readAsStringSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              value
            ),
          ),
        )
      )
    );
  }
}