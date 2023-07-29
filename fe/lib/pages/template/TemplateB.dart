import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import '../widgets/pdf_window.dart';

// Ui counter part for pdf
class TemplateB extends StatefulWidget {
  const TemplateB({super.key});

  @override
  State<StatefulWidget> createState() => TemplateBState();
}

class TemplateBState extends State<TemplateB> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

// Pdf
class TemplateBPdf {
  final pdf = pw.Document();
  final double fontText = 13;
  final double fontHeading = 24;
  final double fontSubHeading = 16;
  final pw.Widget relatedSpacing = pw.SizedBox(height: 8);
  final pw.Widget unRelatedSpacing = pw.SizedBox(height: 16);

  void writeOnPdf() async {

  }
  Future<PlatformFile> getPdf() async {
      Uint8List bytes = await pdf.save();
      PlatformFile? file = PlatformFile(name: "gen.pdf", size: bytes.length,bytes: bytes);
      return file;
  }

  showPdf(BuildContext context) {
    getPdf().then((file) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: PdfWindow(file: file,)
          );
        });
    },);
  }
}