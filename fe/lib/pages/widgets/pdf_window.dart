import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfWindow extends StatefulWidget{
  final PlatformFile? file;

  const PdfWindow(
    {
      Key? key,
      this.file,
    }
  ) : super(key: key);

  @override
  _PdfWindowState createState() => _PdfWindowState();

}

class _PdfWindowState extends State<PdfWindow> {
  @override
  Widget build(BuildContext context) {
    PlatformFile? file = widget.file;
    if (file != null) {
      return Scaffold(
        body : PdfView(
          controller: PdfController(document: PdfDocument.openData(file.bytes as FutureOr<Uint8List>)),
          scrollDirection: Axis.horizontal,
          pageSnapping: false,
        )
      );
    }
    return const Scaffold(
      body: Text("File not available")
    );
  }
}