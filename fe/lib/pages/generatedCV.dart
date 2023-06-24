import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/shareCV.dart';
import 'package:pdf/widgets.dart' as pw;
import 'details.dart';


class generatedCV extends StatefulWidget {
  const generatedCV({super.key});

  @override
  _generatedCVState createState() => _generatedCVState();
}

class _generatedCVState extends State<generatedCV> {

  Map data = content;
  final TextEditingController _controller = TextEditingController();

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

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: [

            ]
          );
        }
      )
    );
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [

              Container(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        createCV();
                      });
                    },
                    child: const Text("Generate")
                  )
                ),
              ),
              
              Expanded(
                child: Container(
                  // decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1.0,
                  // ),
                // ),
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      TextFormField(
                        maxLines: null,
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          Positioned(
            bottom: 18.0, // Adjust the position of the floating button
            right: 18.0,
            child: FloatingActionButton(
              onPressed: () {
                shareCVModal(context);
              },
              child: const Icon(Icons.download),
            ),
          ),
        
        ],
      ),
    );
  }
}