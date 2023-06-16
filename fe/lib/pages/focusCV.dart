import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfx/pdfx.dart';
import 'package:file_picker/file_picker.dart';
import 'pdf_window.dart';

void viewCVModal(BuildContext context, PlatformFile? file) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: FractionallySizedBox(
          widthFactor: 0.4,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: PdfWindow(file: file),
          ),
        ),
      );
    },
  );
}
