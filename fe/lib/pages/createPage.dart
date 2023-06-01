import 'dart:io';

import 'package:ai_cv_generator/api/pdfApi.dart';
import 'package:ai_cv_generator/pages/pdfWinLink.dart';
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImportCV extends StatefulWidget {
  @override
  _ImportCVState createState() => _ImportCVState();
}

class _ImportCVState extends State<ImportCV> {
  Map data = {};
  PlatformFile? file = null;
  bool fileAvail = false;
  @override
  Widget build(BuildContext context) {
    
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
                          
                          setState(() {
                              file = fi;
                              fileAvail = true;
                          });
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
              Expanded(child:pdfWinLink(file: file,)) : const Text("")
          ],
        )
      )
    );
  }
  void openFile(PlatformFile? f,BuildContext c) => Navigator.of(c).push(
    MaterialPageRoute(builder: (c)=> PdfWindow(key:null,file: f,))
  );
}