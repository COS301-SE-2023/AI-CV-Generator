import 'dart:typed_data';

import 'package:ai_cv_generator/pages/personaldetails2.dart';
import 'package:ai_cv_generator/pages/util/fileView.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

//Local imports
//import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

void main() {
  runApp(CreatePdfWidget());
}

/// Represents the PDF widget class.
class CreatePdfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreatePdfStatefulWidget(),
    );
  }
}

/// Represents the PDF stateful widget class.
class CreatePdfStatefulWidget extends StatefulWidget {
  /// Initalize the instance of the [CreatePdfStatefulWidget] class.
  const CreatePdfStatefulWidget({Key? key}) : super(key: key);

  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdfStatefulWidget> {
  TextEditingController fullnameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create PDF document'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue,
                disabledForegroundColor: Colors.grey,
              ),
              onPressed: generateInvoice,
              child: const Text('Generate PDF'),
            )
          ],
        ),
      ),
    );
  }
  TextEditingController controller = TextEditingController(text: "INVOICE");
  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();

    drawMainPage(page, pageSize);
    drawPersonalDetails(page, pageSize);
    drawSkills(page, pageSize);
    PdfLayoutResult result = drawDescription(page, pageSize);
    result = drawExperience(page, pageSize, result);
    result = drawEducation(page, pageSize, result);
    result = drawReference(page, pageSize, result);
    final List<int> bytes = document.saveSync();
    showDialog(
      context: context, 
      builder: (context) {
        Size screenSize = MediaQuery.of(context).size;
      double w = screenSize.width/100;
      double h = screenSize.height/100;
        return SizedBox(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                icon: const Icon(Icons.arrow_back,color: Colors.white,)
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(w*1),
                    width: 1000,
                    height: 1000,
                    child: SfPdfViewer.memory(
                      Uint8List.fromList(bytes),
                      pageSpacing: 8
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      }
    );
  }

  Future<void> templateD(PdfDocument document, PdfPage page, List<int> bytes,Size pageSize,PdfGrid grid) async {
    showDialog(
      context: context, 
      builder: (context) {
        Size screenSize = MediaQuery.of(context).size;
      double w = screenSize.width/100;
      double h = screenSize.height/100;
        return SizedBox(
          width: 37*w,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                icon: const Icon(Icons.arrow_back,color: Colors.white,)
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(w*1),
                    width: 32*w,
                    height: 85*h,
                    child: SfPdfViewer.memory(
                      Uint8List.fromList(bytes),
                      pageSpacing: 8
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(w*0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Container(
                        height: 5*h,
                        width: 10*w,
                        child:  TextField(controller: controller,onChanged: (value) {
                          Navigator.pop(context);
                          List<int> bytes = document.saveSync();
                          templateD(document, page, bytes, pageSize, grid);
                        }),
                       )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        );
      }
    );
  }
  
  drawMainPage(PdfPage page, Size pageSize) {
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(0, 0, 0)));
    
      page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(56, 92, 100)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90)
    );
  //left
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(85, 144, 157)),
      bounds: Rect.fromLTWH(0, 90, pageSize.width/3, pageSize.height - 90)
    );
  //right
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
      bounds: Rect.fromLTWH(pageSize.width/3, 90, pageSize.width/3*2-1, pageSize.height - 90-1)
    );
  }

  drawPersonalDetails(PdfPage page, Size pageSize) {
    page.graphics.drawString(
        "NAME SURNAME", PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle)
    );
    page.graphics.drawString(
        "ADDRESS\nPHONE NUMBER\nEMAIL", PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0+16, 90+16, pageSize.width/3, pageSize.height - 90),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top)
    );
    page.graphics.drawLine(
      PdfPen(PdfColor(255, 255, 255)), 
      Offset(0+16, 170),
      Offset(pageSize.width/3, 170)
    );
  }

  drawDescription(PdfPage page, Size pageSize) {
    String text = "SUMMARY";
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 11);
    final Size contentSize = contentFont.measureString(text);
    page.graphics.drawString(
        "", 
        contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(pageSize.width/3+16, 90+16, pageSize.width/3*2-1, pageSize.height - 90),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top
        )
    );
    return PdfTextElement(text: text, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width/3+16, 90+16,
          pageSize.width/3*2 -30, pageSize.height - 90));
  }

  drawExperience(PdfPage page, Size pageSize, PdfLayoutResult result) {
    String text = "EXPERIENCE";
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 11);
    final Size contentSize = contentFont.measureString(text);
    page.graphics.drawString(
        "", 
        contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(pageSize.width/3+16, result.bounds.bottom, pageSize.width/3*2-1, pageSize.height - 90),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top
        )
    );
    return PdfTextElement(text: text, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width/3+16, result.bounds.bottom+16,
            pageSize.width/3*2 -30, pageSize.height - 90))!;
  }

  drawEducation(PdfPage page, Size pageSize, PdfLayoutResult result) {
    String text = "EDUCATION";
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 11);
    final Size contentSize = contentFont.measureString(text);
    page.graphics.drawString(
        "", 
        PdfStandardFont(PdfFontFamily.helvetica, 11),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(pageSize.width/3+16, 274, result.bounds.bottom, pageSize.height - 90),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top
        )
    );
    return PdfTextElement(text: text, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width/3+16, result.bounds.bottom+16,
            pageSize.width/3*2 -30, pageSize.height - 90))!;
  }

  drawReference(PdfPage page, Size pageSize, PdfLayoutResult result) {
    String text = "REFERENCE";
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 11);
    final Size contentSize = contentFont.measureString(text);
    page.graphics.drawString(
        "", 
        PdfStandardFont(PdfFontFamily.helvetica, 11),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(pageSize.width/3+16, 358, result.bounds.bottom, pageSize.height - 90),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top
        )
    );
    return PdfTextElement(text: text, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width/3+16, result.bounds.bottom+16,
            pageSize.width/3*2 -30, pageSize.height - 90))!;
  }

  drawSkills(PdfPage page, Size pageSize) {
    final skillsList = PdfUnorderedList(
      marker: PdfUnorderedMarker(
          font: PdfStandardFont(PdfFontFamily.helvetica, 10),
          style: PdfUnorderedMarkerStyle.disk,
      ),
      items: PdfListItemCollection(
        <String>[
          'SKILL 1',
          'SKILL 2',
          'SKILL 3',
          'SKILL 4',
          'SKILL 5',
        ]
      ),
      textIndent: 10,
      indent: 20
    );

    page.graphics.drawString(
        "SKILLS", 
        PdfStandardFont(PdfFontFamily.helvetica, 11),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0+16, 190, pageSize.width/3, pageSize.height - 90),
        format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.top
        )
    );

    skillsList.draw(
      page: page,
      bounds: Rect.fromLTWH(0, 210, pageSize.width/3, pageSize.height - 90),
    );
  }
}