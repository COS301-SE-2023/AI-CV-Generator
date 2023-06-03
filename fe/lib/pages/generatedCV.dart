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
  TextEditingController _controller = TextEditingController();

  void createCV() {
    setState(() {
      File file = File('details.txt');
      // data = json.decode(file.readAsStringSync());
      // value = data['personalDetails'];
      // data.forEach((key, value) {
      //   value += '$key' + '\n';
      //   value += '$value' + '\n\n';
      // });
      _controller.text = file.readAsStringSync();
      // value = file.readAsStringSync();
      // data = json.decode(File('content.json').readAsStringSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  onPressed: () async {
                    setState(() {
                      createCV();
                    });
                  }, 
                  child: const Text("Generate")
                ) 
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: TextFormField(
                  controller: _controller,
                  maxLines: 99999,
                ),
              )
            ]
          ),
        )
    );
  }
}