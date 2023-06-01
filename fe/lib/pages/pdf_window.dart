import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:typed_data';
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
//import 'dart:io';
import 'package:http/http.dart' as http;
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
        )
      );
    }
    return Scaffold(
      body: Text("File not available")
    );
  }
}