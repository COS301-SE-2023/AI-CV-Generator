
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:ai_cv_generator/pages/personaldetails.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/shareCV.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
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
  bool saved = false;
  Future savePdf() async {
    if (!saved) {
      Uint8List bytes = await pdf.save();
      file = PlatformFile(name: "gen.pdf", size: bytes.length,bytes: bytes);
      saved = true;
    }
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalDetails()
                          ),
                        );
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
              onPressed: () async {
                if (!saved) {
                  writeOnPdf();
                  await savePdf();
                }
                if (file != null) {
                  shareCVModal(context,file);
                }
              },
              child: const Icon(Icons.download),
            ),
          ),
          Positioned(
            bottom: 18.0,
            left: 18.0,
            child: FloatingActionButton(
              onPressed: () async {
                if (!saved) {
                  writeOnPdf();
                  await savePdf();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfWindow(file: file,)
                  ),
                );
              },
              child: const Icon(Icons.save),
            ),
          )
        
        ],
      ),
    );
  }
}