import 'package:flutter/material.dart';
import 'details.dart';


class generatedCV extends StatefulWidget {
  const generatedCV({super.key});

  @override
  _generatedCVState createState() => _generatedCVState();
}

class _generatedCVState extends State<generatedCV> {

  Map data = content;
  TextEditingController _controller = TextEditingController();

  void createCV() {
    String response = '';
    setState(() {
      data.forEach((key, value) {
        response += '$key\n';
        response += '$value\n\n';
      });
    });
    _controller.text = response;
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