import 'dart:typed_data';

import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/shareCV.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'details.dart';


Future<Uint8List> makePdf() async {
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          ); // Center
        }
      )
    );
    return await pdf.save();
  }

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyAppforPDf()
                          ),
                        );
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
class MyAppforPDf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PdfTest(),
    );
  }
}

class PdfTest extends StatelessWidget {
  final pdf = pw.Document();
  writeOnPdf() {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Text("1st header"),
            ),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Header(level: 1, child: pw.Text("2nd ehader")),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
            pw.Paragraph(text: "TEST PDF"),
          ];
        },
      ),
    );
  }
  PlatformFile? file;
  Future savePdf() async {
    Uint8List bytes = await pdf.save();
    file = PlatformFile(name: "gen.pdf", size: bytes.length,bytes: bytes);
    await FileApi.uploadFile(file: file);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "PDF TUTORIAL",
              style: TextStyle(fontSize: 34),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          writeOnPdf();
          await savePdf();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfWindow(file: file,)
            ),
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}