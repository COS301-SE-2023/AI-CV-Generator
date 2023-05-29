import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:file_picker/file_picker.dart';

class ImportCV extends StatefulWidget {
  @override
  _ImportCVState createState() => _ImportCVState();
}

class _ImportCVState extends State<ImportCV> {

  Map data = {};
  void _pick_cvfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => PdfView(controller: PdfController(document: PdfDocument.openAsset("assets/Documents/DocumentTest.pdf"),initialPage: 1, viewportFraction: 1.0))
                  // ));
                  _pick_cvfile();
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
          ],
        )
      )
    );
  }
}