import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/Template.dart';
import 'package:ai_cv_generator/pages/widgets/loadingScreens/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Editor extends StatefulWidget {
  const Editor({super.key, required this.data,required this.option});
  final CVData data;
  final TemplateOption option;
  @override
  State<StatefulWidget> createState() => EditableTextState();
}

class EditorState extends State<Editor> {

  bool wait = true;
  Uint8List? bytes;

  setOnLoadingScreen() {
    setState(() {
      wait = true;
    });
  }

  setOffLoadingScreen() {
    setState(() {
      wait = false;
    });
  }

  @override
  void initState() {
    // create pdf
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (wait) {
      return const LoadingScreen();
    }
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    return SizedBox(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(w*1),
            width: 32*w,
            height: 85*h,
            child: SfPdfViewer.memory(
              bytes!,
              pageSpacing: 8
            ),
          ),
          Container(
            
          )
        ]
        
      ),
    );
  }

  

}