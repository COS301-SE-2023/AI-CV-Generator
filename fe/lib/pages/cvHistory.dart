import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';

class CVHistory extends StatefulWidget {
  final BuildContext context;
  const CVHistory({super.key, required this.context});

  @override
  CVHistoryState createState() => CVHistoryState();
}

class CVHistoryState extends State<CVHistory> {
  List<Widget> list = [];

  @override
  void initState() {
    FileApi.getFiles().then((value) {
      for (var element in value!) {
        list.add(add(element.filename));
      }
        setState(() {
      });
    });
    super.initState();
  }

  Widget add(String filename,) {
    return OutlinedButton(
        onPressed: ()  {
          FileApi.requestFile(filename: filename).then((value) {
            showDialog(
              context: widget.context,
              builder: (context) {
                return Dialog(
                  child: PdfWindow(file: value,)
                );
            });
          });

        },
        child: Text(filename),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...list,
            ], 
        ) 
      )
    );
  }
}