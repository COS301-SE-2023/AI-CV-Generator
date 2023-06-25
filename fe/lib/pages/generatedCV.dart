
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/pages/create_CV.dart';
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/shareCV.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
  final pdf = pw.Document();
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
  PlatformFile? file;
  Future savePdf() async {
    Uint8List bytes = await pdf.save();
    file = PlatformFile(name: "gen.pdf", size: bytes.length,bytes: bytes);
    // await FileApi.uploadFile(file: file);
  }
  writeOnPdf() {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Text(
              _controller.text
            )
          ];
        },
      ),
    );
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
          Positioned(
            bottom: 18.0,
            left: 18.0,
            child: FloatingActionButton(
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
            ),
          )
        
        ],
      ),
    );
  }
}