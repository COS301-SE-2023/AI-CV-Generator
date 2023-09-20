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
  TextEditingController addressC = TextEditingController();
  TextEditingController phonenumberC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController descriptC = TextEditingController();

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
              onPressed: templateD,
              child: const Text('Generate PDF'),
            )
          ],
        ),
      ),
    );
  }
  TextEditingController controller = TextEditingController(text: "INVOICE");
  Future<void> templateD() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();

    //top
    Rect topBox = Rect.fromLTWH(0, 0, pageSize.width, 90);
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(56, 92, 100)),
      bounds: topBox
    );
    topBox = Rect.fromLTWH(topBox.left, topBox.top, topBox.width, topBox.height);
    drawNameSurname(page, pageSize, topBox, "Name Surname");
    
    //left
    Rect leftBox = Rect.fromLTWH(0, topBox.bottom, pageSize.width/4, pageSize.height - topBox.height);
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(85, 144, 157)),
      bounds: leftBox
    );
    leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top, leftBox.width-8, 0);
    leftBox = drawContactDetails(page, pageSize, leftBox, "ADDRESS\nPHONE NUMBER\nEMAIL").bounds;
    drawSkills(page, pageSize, leftBox, []);

    //right
    Rect rightBox = Rect.fromLTWH(leftBox.width-8, topBox.bottom, pageSize.width/4*3+16, pageSize.height - topBox.height);
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(250, 250, 250)),
      bounds: rightBox
    );
    rightBox = Rect.fromLTWH(rightBox.left+8, rightBox.top, rightBox.width, 0);
    rightBox = drawDescription(page, pageSize, rightBox, "Hello\nMy name is oscar").bounds;
    rightBox = drawExperience(page, pageSize, rightBox, []).bounds;
    rightBox = drawEducation(page, pageSize, rightBox, []).bounds;
    rightBox = drawReference(page, pageSize, rightBox, []).bounds;

    // addText(page, pageSize, PdfStandardFont(PdfFontFamily.helvetica, 12), PdfStringFormat(), bounds, "Contact").bounds;
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

  PdfLayoutResult addText(PdfPage page, Size pageSize, PdfFont contentFont, PdfStringFormat format, Rect bound, String text)
  {
    final Size contentSize = contentFont.measureString(text);
    return PdfTextElement(
      text: text, 
      font: contentFont,
      format: format
      ).draw(
        page: page,
        bounds: bound,
      )!;
  }

  PdfLayoutResult drawNameSurname(PdfPage page, Size pageSize, Rect bounds, String data) {
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle
      ),
      bounds,
      data
    );
  }

  PdfLayoutResult drawContactDetails(PdfPage page, Size pageSize, Rect bounds, String data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, bounds.height),
      "Contact Details"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, 0),
      data
    );
  }

  PdfLayoutResult drawDescription(PdfPage page, Size pageSize, Rect bounds, String data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, bounds.height),
      "SUMMARY"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, 0),
      data
    );
  }

  PdfLayoutResult drawExperience(PdfPage page, Size pageSize, Rect bounds, List data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, bounds.height),
      "EXPERIENCE"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, 0),
      ""
    );
  }

  PdfLayoutResult drawEducation(PdfPage page, Size pageSize, Rect bounds, List data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, bounds.height),
      "EDUCATION"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, 0),
      ""
    );
  }

  PdfLayoutResult drawReference(PdfPage page, Size pageSize, Rect bounds, List data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, bounds.height),
      "REFERENCE"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, 0),
      ""
    );
  }

  drawSkills(PdfPage page, Size pageSize, Rect bounds, List data) {
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

    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+4, bounds.width, bounds.height),
      "SKILLS"
    ).bounds;

    skillsList.draw(
      page: page,
      bounds: Rect.fromLTWH(0, bounds.bottom+8, pageSize.width/3, pageSize.height - 90),
    );
  }
}