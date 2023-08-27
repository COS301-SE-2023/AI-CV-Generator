import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/widgets/pdf_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ExtractionView {
  showModal(BuildContext context, PlatformFile file, Map data) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Stack(
            children: [
              Transform.scale(scaleX: 1.0, child: PdfWindow(file: file,)),
              Container(
                child: Positioned(
                  right: 28,
                  top: 28,
                  child: Container(
                    height: 640,
                    width: 400,
                    child: SectionContainer(
                      child: ListView(
                        padding: EdgeInsets.only(right: 16),
                        children: [
                          ...extractedData(data)
                        ],
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        );
    });
  }

  List<Widget> extractedData(Map data) {
    List<Widget> widgets = [];
    data.forEach((key, value) {
      widgets.add(SectionHeading(text: key.toString().toUpperCase()));
      if(value is List) {
        for(int i = 0; i < value.length; i++) {
          value[i].toJson().forEach((key, data) {
            widgets.add(Text(data));
          });
          if(i != value.length-1) {
            widgets.add(SizedBox(height: 8,));
          }
        }
      }
      else {
        widgets.add(Text(value.toString()));
      }
      
      widgets.add(SizedBox(height: 24,));
    });
    return widgets;
  }
      
}