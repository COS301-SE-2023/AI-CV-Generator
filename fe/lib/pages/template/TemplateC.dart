import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import '../pdf_window.dart';

// Ui counter part for pdf
class TemplateC extends StatefulWidget {
  const TemplateC({super.key});

  @override
  State<StatefulWidget> createState() => TemplateCState();

}

class TemplateCState extends State<TemplateC> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

// Pdf

class TemplateCPdf{
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