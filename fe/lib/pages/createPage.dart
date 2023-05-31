import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:file_picker/file_picker.dart';

class ImportCV extends StatefulWidget {
  @override
  _ImportCVState createState() => _ImportCVState();
}

class _ImportCVState extends State<ImportCV> {

  Map data = {};
  static Future<File?> _pick_cvfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf']
    );
    if (result == null) return null; 
    String? path = result.paths.first;
    if ( path == null) return null;
    return File(path);
  }

  @override
  Widget build(BuildContext context) {
    List<File> files = [];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: OutlinedButton(
                      onPressed: () {
                        files.add(_pick_cvfile() as File);
                      }, 
                      child: const Text("Upload")
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: OutlinedButton(
                      onPressed: () {
                      }, 
                      child: const Text("Create Manually")
                    ) 
                  )
                ]
              ),
          ],
        )
      )
    );
  }
}