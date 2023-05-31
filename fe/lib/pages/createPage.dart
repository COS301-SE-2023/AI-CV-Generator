import 'dart:io';
import 'dart:typed_data';

import 'package:ai_cv_generator/api/pdfApi.dart';
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImportCV extends StatefulWidget {
  @override
  _ImportCVState createState() => _ImportCVState();
}

class _ImportCVState extends State<ImportCV> {

  Map data = {};
  

  @override
  Widget build(BuildContext context) {
    PlatformFile? file = null;
    bool fileAvail = false;
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
                      onPressed: () async {
                          final fi = await pdfAPI.pick_cvfile();
                          if (fi == null) return;
                          file = fi;
                          fileAvail = true;
                          openFile(file, context);
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
                  ),
                ]
              ),
              fileAvail == true ?
              PdfWindow(
                file: file
              ) : const Text("I am here")
          ],
        )
      )
    );
  }
  void openFile(PlatformFile? f,BuildContext c) => Navigator.of(c).push(
    MaterialPageRoute(builder: (c)=> PdfWindow(key:null,file: f,))
  );
}