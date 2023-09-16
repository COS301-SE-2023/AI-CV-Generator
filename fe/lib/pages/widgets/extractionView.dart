import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExtractionView {
  Future<bool> showModal(BuildContext context, PlatformFile file, Map data) async {
    bool proceed = false;
    await showDialog(
      context: context,
      builder: (context) {
        // Window Resizing
        Size screenSize = MediaQuery.of(context).size;
        double w = screenSize.width/100;
        double h = screenSize.height/100; 
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2)
            ),
            width: w*82,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: w*2
                  ),
                  width: w*40,
                  child: SfPdfViewer.memory(
                    file.bytes!
                  )
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 2*w
                  ),
                  height: 640,
                  width: 40*w,
                  child: SectionContainer(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: ListView(
                            padding: const EdgeInsets.only(right: 16),
                            children: [
                              ...extractedData(data)
                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Expanded(
                          child: CustomizableButton(
                            onTap: () {
                              proceed = true;
                              Navigator.pop(context);
                            
                            },
                            text: "Save and Proceed",
                            width: 10*w,
                            height: 5*h,
                            fontSize: 0.1*w*h,
                          )
                        )
                      ],
                    )
                  )
                ),
              ],
            ),
          )
        );
    });
    return proceed;
  }

  List<Widget> extractedData(Map data) {
    List<Widget> widgets = [];
    data.forEach((key, value) {
      widgets.add(SectionHeading(text: key.toString().toUpperCase()));
      if(value is List) {
        for(int i = 0; i < value.length; i++) {
          value[i].toJson().forEach((key, data) {
            if(data!= null) {
              widgets.add(Text(data));
            }
          });
          if(i != value.length-1) {
            widgets.add(const SizedBox(height: 8,));
          }
        }
      }
      else {
        widgets.add(Text(value.toString()));
      }
      
      widgets.add(const SizedBox(height: 24,));
    });
    return widgets;
  }
      
}