import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/widgets/pdf_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ExtractionView {
  showModal(BuildContext context, PlatformFile file) {
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
                        children: [
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
      
}